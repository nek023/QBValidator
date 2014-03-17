//
//  QBValidationRegularExpressionRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@interface QBValidationRegularExpressionRule : QBValidationRule

@property (nonatomic, copy, readonly) NSString *pattern;

+ (instancetype)ruleWithPattern:(NSString *)pattern;
- (instancetype)initWithPattern:(NSString *)pattern;

@end
