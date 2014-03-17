//
//  QBValidationNegativeRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationNegativeRule.h"

@interface QBValidationNegativeRule ()

@property (nonatomic, strong, readwrite) QBValidationRule *rule;

@end

@implementation QBValidationNegativeRule

+ (instancetype)ruleWithRule:(QBValidationRule *)rule
{
    return [[self alloc] initWithRule:rule];
}

- (instancetype)initWithRule:(QBValidationRule *)rule
{
    self = [super init];
    
    if (self) {
        self.rule = rule;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; rule = %@>",
            NSStringFromClass([self class]),
            self,
            self.rule
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    return ![self.rule validateValue:value];
}

@end
