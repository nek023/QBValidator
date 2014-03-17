//
//  QBValidationPatternRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRegularExpressionRule.h"

typedef NS_ENUM(NSUInteger, QBValidationPatternType) {
    QBValidationPatternTypeEmail,
    QBValidationPatternTypeURI
};

@interface QBValidationPatternRule : QBValidationRegularExpressionRule

@property (nonatomic, assign, readonly) QBValidationPatternType type;

+ (NSString *)patternFromType:(QBValidationPatternType)type;

+ (instancetype)ruleWithPatternType:(QBValidationPatternType)type;
- (instancetype)initWithPatternType:(QBValidationPatternType)type;

@end
