//
//  QBValidator.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>

// Categories
#import "UITextField+QBValidator.h"

// Functions
#import "QBValidationRuleFunctions.h"

@interface QBValidator : NSObject

+ (instancetype)validator;

- (BOOL)validateValues:(NSDictionary *)values rules:(NSDictionary *)ruleDictionary errorMessages:(NSDictionary * __autoreleasing *)errorMessagesPointer;
- (BOOL)validateValue:(id)value name:(NSString *)name rules:(NSArray *)rules errorMessages:(NSArray * __autoreleasing *)errorMessagesPointer;

@end
