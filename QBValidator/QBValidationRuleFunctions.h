//
//  QBValidationRuleFunctions.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>

// Rules
#import "QBValidationRequirementRule.h"
#import "QBValidationComparisonRule.h"
#import "QBValidationRangeRule.h"
#import "QBValidationContainmentRule.h"
#import "QBValidationNegativeRule.h"
#import "QBValidationConditionRule.h"
#import "QBValidationRegularExpressionRule.h"
#import "QBValidationPatternRule.h"
#import "QBValidationBlockRule.h"
#import "QBValidationInheritanceRule.h"

// Macros
#define QBV_OVERLOADABLE static inline __attribute__((overloadable))
#define QBVRequired [QBValidationRequirementRule rule]
#define QBVEmail [QBValidationPatternRule ruleWithPatternType:QBValidationPatternTypeEmail]
#define QBVURI [QBValidationPatternRule ruleWithPatternType:QBValidationPatternTypeURI]

// Functions
QBV_OVERLOADABLE id QBVEqualTo(id value)
{
    return [QBValidationComparisonRule ruleWithValue:value comparisonMode:QBValidationComparisonRuleComparisonModeEqual];
}

QBV_OVERLOADABLE id QBVGreaterThan(id value)
{
    return [QBValidationComparisonRule ruleWithValue:value comparisonMode:QBValidationComparisonRuleComparisonModeGreaterThan];
}

QBV_OVERLOADABLE id QBVGreaterThanOrEqualTo(id value)
{
    return [QBValidationComparisonRule ruleWithValue:value comparisonMode:QBValidationComparisonRuleComparisonModeGreaterThanOrEqual];
}

QBV_OVERLOADABLE id QBVLessThan(id value)
{
    return [QBValidationComparisonRule ruleWithValue:value comparisonMode:QBValidationComparisonRuleComparisonModeLessThan];
}

QBV_OVERLOADABLE id QBVLessThanOrEqualTo(id value)
{
    return [QBValidationComparisonRule ruleWithValue:value comparisonMode:QBValidationComparisonRuleComparisonModeLessThanOrEqual];
}

QBV_OVERLOADABLE id QBVInRange(NSUInteger min, NSUInteger max)
{
    return [QBValidationRangeRule ruleWithMinValue:@(min) maxValue:@(max) inclusive:YES];
}

QBV_OVERLOADABLE id QBVInRange(NSUInteger min, NSUInteger max, BOOL inclusive)
{
    return [QBValidationRangeRule ruleWithMinValue:@(min) maxValue:@(max) inclusive:inclusive];
}

QBV_OVERLOADABLE id QBVContainedIn(NSArray *preferredValues)
{
    return [QBValidationContainmentRule ruleWithPreferredValues:preferredValues];
}

QBV_OVERLOADABLE id QBVNot(QBValidationRule *rule)
{
    return [QBValidationNegativeRule ruleWithRule:rule];
}

QBV_OVERLOADABLE id QBVIf(QBValidationRule *rule, NSDictionary *conditionalRules)
{
    return [QBValidationConditionRule ruleWithRule:rule conditionalRules:conditionalRules];
}

QBV_OVERLOADABLE id QBVMatch(NSString *pattern)
{
    return [QBValidationRegularExpressionRule ruleWithPattern:pattern];
}

QBV_OVERLOADABLE id QBVBlock(BOOL (^block)(id value))
{
    return [QBValidationBlockRule ruleWithBlock:block];
}

QBV_OVERLOADABLE id QBVKindOfClass(Class class)
{
    return [QBValidationInheritanceRule ruleWithClass:class type:QBValidationInheritanceTypeKindOfClass];
}

QBV_OVERLOADABLE id QBVMemberOfClass(Class class)
{
    return [QBValidationInheritanceRule ruleWithClass:class type:QBValidationInheritanceTypeMemberOfClass];
}

QBV_OVERLOADABLE id QBVSubclassOfClass(Class class)
{
    return [QBValidationInheritanceRule ruleWithClass:class type:QBValidationInheritanceTypeSubclassOfClass];
}
