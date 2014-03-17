//
//  QBValidationConditionRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationConditionRule : QBValidationRule

@property (nonatomic, strong, readonly) QBValidationRule *rule;
@property (nonatomic, copy, readonly) NSDictionary *conditionalRules;

+ (instancetype)ruleWithRule:(QBValidationRule *)rule conditionalRules:(NSDictionary *)conditionalRules;
- (instancetype)initWithRule:(QBValidationRule *)rule conditionalRules:(NSDictionary *)conditionalRules;

@end
