//
//  QBValidationBlockRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationBlockRule : QBValidationRule

@property (nonatomic, copy, readonly) BOOL (^block)(id value);

+ (instancetype)ruleWithBlock:(BOOL (^)(id value))block;
- (instancetype)initWithBlock:(BOOL (^)(id value))block;

@end
