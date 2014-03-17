//
//  QBValidationNegativeRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationNegativeRule : QBValidationRule

@property (nonatomic, strong, readonly) QBValidationRule *rule;

+ (instancetype)ruleWithRule:(QBValidationRule *)rule;
- (instancetype)initWithRule:(QBValidationRule *)rule;

@end
