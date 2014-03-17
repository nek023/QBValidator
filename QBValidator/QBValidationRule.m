//
//  QBValidationRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

@implementation QBValidationRule

+ (instancetype)rule
{
    return [[self alloc] init];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p>",
            NSStringFromClass([self class]),
            self
            ];
}


#pragma mark - Localization

- (NSString *)localizationTableName
{
    return @"QBValidator";
}

- (NSString *)localizationKey
{
    return NSStringFromClass([self class]);
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    return NO;
}

@end
