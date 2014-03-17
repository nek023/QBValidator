//
//  QBValidationRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBValidationRule : NSObject

+ (instancetype)rule;

- (NSString *)localizationTableName;
- (NSString *)localizationKey;

- (BOOL)validateValue:(id)value;

@end
