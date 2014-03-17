//
//  QBValidationComparisonRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationComparisonRule.h"

@interface QBValidationComparisonRule ()
{
    id _value;
}

@property (nonatomic, assign, readwrite) QBValidationComparisonRuleComparisonMode comparisonMode;

@end

@implementation QBValidationComparisonRule

+ (instancetype)ruleWithValue:(id)value comparisonMode:(QBValidationComparisonRuleComparisonMode)comparisonMode
{
    return [[self alloc] initWithValue:value comparisonMode:comparisonMode];
}

- (instancetype)initWithValue:(id)value comparisonMode:(QBValidationComparisonRuleComparisonMode)comparisonMode
{
    self = [super init];
    
    if (self) {
        [self setValue:value];
        self.comparisonMode = comparisonMode;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; value = %@>",
            NSStringFromClass([self class]),
            self,
            [self value]
            ];
}

- (void)dealloc
{
    _value = nil;
}


#pragma mark - Localization

- (NSString *)localizationKey
{
    switch (self.comparisonMode) {
        case QBValidationComparisonRuleComparisonModeEqual:
            return [NSStringFromClass([self class]) stringByAppendingString:@"Equal"];
            break;
            
        case QBValidationComparisonRuleComparisonModeGreaterThan:
            return [NSStringFromClass([self class]) stringByAppendingString:@"GreaterThan"];
            break;
            
        case QBValidationComparisonRuleComparisonModeGreaterThanOrEqual:
            return [NSStringFromClass([self class]) stringByAppendingString:@"GreaterThanOrEqual"];
            break;
            
        case QBValidationComparisonRuleComparisonModeLessThan:
            return [NSStringFromClass([self class]) stringByAppendingString:@"LessThan"];
            break;
            
        case QBValidationComparisonRuleComparisonModeLessThanOrEqual:
            return [NSStringFromClass([self class]) stringByAppendingString:@"LessThanOrEqual"];
            break;
            
        default:
            break;
    }
    
    return nil;
}


#pragma mark - Accessors

- (void)setValue:(id)value
{
    if ([value conformsToProtocol:@protocol(NSCopying)]) {
        _value = [value copy];
    } else {
        _value = value;
    }
}

- (id)value
{
    return _value;
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    switch (self.comparisonMode) {
        case QBValidationComparisonRuleComparisonModeEqual:
        {
            // All objects in Objective-C responds to isEqual: in NSObject protocol, even NSProxy.
            return [value isEqual:self.value];
        }
            break;
            
        case QBValidationComparisonRuleComparisonModeGreaterThan:
        {
            if ([value respondsToSelector:@selector(compare:)]) {
                NSComparisonResult result = [value compare:self.value];
                return (result == NSOrderedDescending);
            }
        }
            break;
            
        case QBValidationComparisonRuleComparisonModeGreaterThanOrEqual:
        {
            if ([value respondsToSelector:@selector(compare:)]) {
                NSComparisonResult result = [value compare:self.value];
                return (result == NSOrderedDescending || result == NSOrderedSame);
            }
        }
            break;
            
        case QBValidationComparisonRuleComparisonModeLessThan:
        {
            if ([value respondsToSelector:@selector(compare:)]) {
                NSComparisonResult result = [value compare:self.value];
                return (result == NSOrderedAscending);
            }
        }
            break;
            
        case QBValidationComparisonRuleComparisonModeLessThanOrEqual:
        {
            if ([value respondsToSelector:@selector(compare:)]) {
                NSComparisonResult result = [value compare:self.value];
                return (result == NSOrderedAscending || result == NSOrderedSame);
            }
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}

@end
