//
//  QBValidationContainmentRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationContainmentRule : QBValidationRule

@property (nonatomic, copy, readonly) NSArray *preferredValues;

+ (instancetype)ruleWithPreferredValues:(NSArray *)preferredValues;
- (instancetype)initWithPreferredValues:(NSArray *)preferredValues;

@end
