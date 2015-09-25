//
//  QBValidator.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidator.h"

@interface QBValidator ()

@property (nonatomic, copy) NSDictionary *values;
@property (nonatomic, strong) NSMutableDictionary *errorMessages;

@end

@implementation QBValidator

+ (instancetype)validator
{
    return [[self alloc] init];
}


#pragma mark - Validating Value

- (BOOL)validateValues:(NSDictionary *)values rules:(NSDictionary *)ruleDictionary errorMessages:(NSDictionary * __autoreleasing *)errorMessagesPointer
{
    BOOL valid = YES;
    NSMutableDictionary *errorMessages = [NSMutableDictionary dictionary];
    
    self.values = values;
    self.errorMessages = errorMessages;
    
    for (id name in [ruleDictionary allKeys]) {
        id value = values[name];
        NSArray *rules = ruleDictionary[name];
        
        NSArray *subErrorMessages = nil;
        if (![self validateValue:value name:name rules:rules errorMessages:&subErrorMessages]) {
            valid = NO;
            
            if (subErrorMessages) {
                NSArray *array = errorMessages[name];
                
                if (array) {
                    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
                    [mutableArray addObjectsFromArray:subErrorMessages];
                    
                    errorMessages[name] = [mutableArray copy];
                } else {
                    errorMessages[name] = subErrorMessages;
                }
            }
        }
    }
    
    if (errorMessages.count > 0) {
        *errorMessagesPointer = [errorMessages copy];
    }
    
    self.values = nil;
    self.errorMessages = nil;
    
    return valid;
}

- (BOOL)validateValue:(id)value name:(NSString *)name rules:(NSArray *)rules errorMessages:(NSArray * __autoreleasing *)errorMessagesPointer
{
    BOOL valid = YES;
    NSMutableArray *errorMessages = [NSMutableArray array];
    
    // Allows to pass QBValidationRule or NSDictionary as rules if there is only one rule.
    if ([rules isKindOfClass:[QBValidationRule class]] || [rules isKindOfClass:[NSDictionary class]]) {
        rules = @[rules];
    }
    
    // Validate
    for (id obj in rules) {
        if ([obj isKindOfClass:[QBValidationRule class]]) {
            QBValidationRule *rule = (QBValidationRule *)obj;
            
            if ([rule isMemberOfClass:[QBValidationConditionRule class]]) {
                if ([rule validateValue:value]) {
                    NSDictionary *values = self.values;
                    NSMutableDictionary *originalErrorMessages = self.errorMessages;
                    
                    NSDictionary *conditionalRules = [(QBValidationConditionRule *)rule conditionalRules];
                    NSDictionary *subErrorMessages = nil;
                    
                    if (![self validateValues:values rules:conditionalRules errorMessages:&subErrorMessages]) {
                        valid = NO;
                        
                        if (subErrorMessages) {
                            for (id key in [subErrorMessages allKeys]) {
                                if ([key isEqual:name]) {
                                    [errorMessages addObjectsFromArray:subErrorMessages[key]];
                                } else {
                                    NSArray *array = originalErrorMessages[key];
                                    
                                    if (array) {
                                        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
                                        [mutableArray addObjectsFromArray:subErrorMessages[key]];
                                        
                                        originalErrorMessages[key] = [mutableArray copy];
                                    } else {
                                        originalErrorMessages[key] = subErrorMessages[key];
                                    }
                                }
                            }
                        }
                    }
                    
                    self.errorMessages = originalErrorMessages;
                }
            }
            else {
                if (![rule validateValue:value]) {
                    valid = NO;
                    
                    // Generate error message
                    NSString *errorMessage = [self errorMessageForRule:rule name:name value:value];
                    
                    if (errorMessage) {
                        [errorMessages addObject:errorMessage];
                    }
                }
            }
        }
        else if ([obj isKindOfClass:[NSDictionary class]] && [value isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *originalErrorMessages = self.errorMessages;
            
            // Validate sub values
            NSDictionary *subValues = (NSDictionary *)value;
            NSDictionary *subRules = (NSDictionary *)obj;
            NSDictionary *subErrorMessages = nil;
            if (![self validateValues:subValues rules:subRules errorMessages:&subErrorMessages]) {
                valid = NO;
            }
            
            if (subErrorMessages) {
                NSArray *array = originalErrorMessages[name];
                
                if (array) {
                    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
                    [mutableArray addObject:subErrorMessages];
                    
                    originalErrorMessages[name] = [mutableArray copy];
                } else {
                    originalErrorMessages[name] = @[subErrorMessages];
                }
            }
            
            self.errorMessages = originalErrorMessages;
        }
    }
    
    if (errorMessages.count > 0) {
        *errorMessagesPointer = [errorMessages copy];
    }
    
    return valid;
}


#pragma mark - Generating Error Message

- (NSString *)errorMessageForRule:(QBValidationRule *)rule name:(NSString *)name value:(id)value
{
    // Get rid of negative rules
    BOOL negative = NO;
    
    while ([rule isMemberOfClass:[QBValidationNegativeRule class]]) {
        negative = !negative;
        rule = [(QBValidationNegativeRule *)rule rule];
    }
    
    if (rule) {
        // Generate error message
        NSString *key = [rule localizationKey];
        
        if (key) {
            if (negative) {
                key = [key stringByAppendingString:@"Not"];
            }
            key = [key stringByAppendingString:@"Satisfied"];
            
            // First check bundleForClass:
            // This will ensure that we work if packaged in a framework
            NSString *errorMessage = NSLocalizedStringFromTableInBundle(key, [rule localizationTableName], [NSBundle bundleForClass:[self class]], nil);
            if ([errorMessage isEqualToString:key]) {
                // Fall back to main bundle
                errorMessage = NSLocalizedStringFromTableInBundle(key, [rule localizationTableName], [NSBundle mainBundle], nil);
            }
            
            // Replace patterns
            errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"{name}"
                                                                   withString:name];
            errorMessage = [errorMessage stringByReplacingOccurrencesOfString:@"{value}"
                                                                   withString:[NSString stringWithFormat:@"%@", value]];
            
            // Replace rule petterns
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\{rule\\.(.*?)\\}"
                                                                                               options:0
                                                                                                 error:NULL];
            
            NSTextCheckingResult *result = [regularExpression firstMatchInString:errorMessage
                                                                         options:0
                                                                           range:NSMakeRange(0, errorMessage.length)];
            
            while (result.range.location != NSNotFound && result.numberOfRanges == 2) {
                NSString *keyPath = [errorMessage substringWithRange:[result rangeAtIndex:1]];
                errorMessage = [errorMessage stringByReplacingCharactersInRange:result.range
                                                                     withString:[NSString stringWithFormat:@"%@", [rule valueForKeyPath:keyPath]]];
                
                result = [regularExpression firstMatchInString:errorMessage
                                                       options:0
                                                         range:NSMakeRange(0, errorMessage.length)];
            }
            
            if (errorMessage) {
                return errorMessage;
            }
        }
    }
    
    return nil;
}

@end
