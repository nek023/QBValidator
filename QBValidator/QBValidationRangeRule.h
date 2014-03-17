//
//  QBValidationRangeRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationRangeRule : QBValidationRule

@property (nonatomic, assign, readonly) NSNumber *minValue;
@property (nonatomic, assign, readonly) NSNumber *maxValue;
@property (nonatomic, assign, readonly) BOOL inclusive;

+ (instancetype)ruleWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue inclusive:(BOOL)inclusive;
- (instancetype)initWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue inclusive:(BOOL)inclusive;

@end
