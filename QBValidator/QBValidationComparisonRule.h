//
//  QBValidationComparisonRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

typedef NS_ENUM(NSInteger, QBValidationComparisonRuleComparisonMode) {
    QBValidationComparisonRuleComparisonModeEqual,
    QBValidationComparisonRuleComparisonModeGreaterThan,
    QBValidationComparisonRuleComparisonModeGreaterThanOrEqual,
    QBValidationComparisonRuleComparisonModeLessThan,
    QBValidationComparisonRuleComparisonModeLessThanOrEqual
};

@interface QBValidationComparisonRule : QBValidationRule

@property (nonatomic, assign, readonly) QBValidationComparisonRuleComparisonMode comparisonMode;

+ (instancetype)ruleWithValue:(id)value comparisonMode:(QBValidationComparisonRuleComparisonMode)comparisonMode;
- (instancetype)initWithValue:(id)value comparisonMode:(QBValidationComparisonRuleComparisonMode)comparisonMode;

- (void)setValue:(id)value;
- (id)value;

@end
