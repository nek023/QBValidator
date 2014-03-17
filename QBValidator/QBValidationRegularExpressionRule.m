//
//  QBValidationRegularExpressionRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRegularExpressionRule.h"

@interface QBValidationRegularExpressionRule ()

@property (nonatomic, copy, readwrite) NSString *pattern;

@end

@implementation QBValidationRegularExpressionRule

+ (instancetype)ruleWithPattern:(NSString *)pattern
{
    return [[self alloc] initWithPattern:pattern];
}

- (instancetype)initWithPattern:(NSString *)pattern
{
    self = [super init];
    
    if (self) {
        self.pattern = pattern;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; pattern = %@>",
            NSStringFromClass([self class]),
            self,
            self.pattern
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[cd] %@", self.pattern];
    return [predicate evaluateWithObject:value];
}

@end
