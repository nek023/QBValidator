//
//  QBValidationConditionRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationConditionRule.h"

@interface QBValidationConditionRule ()

@property (nonatomic, strong, readwrite) QBValidationRule *rule;
@property (nonatomic, copy, readwrite) NSDictionary *conditionalRules;

@end

@implementation QBValidationConditionRule

+ (instancetype)ruleWithRule:(QBValidationRule *)rule conditionalRules:(NSDictionary *)conditionalRules
{
    return [[self alloc] initWithRule:rule conditionalRules:conditionalRules];
}

- (instancetype)initWithRule:(QBValidationRule *)rule conditionalRules:(NSDictionary *)conditionalRules
{
    self = [super init];
    
    if (self) {
        self.rule = rule;
        self.conditionalRules = conditionalRules;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; rule = %@; conditionalRules = %@>",
            NSStringFromClass([self class]),
            self,
            self.rule,
            self.conditionalRules
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    return [self.rule validateValue:value];
}

@end
