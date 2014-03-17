//
//  UITextField+QBValidator.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (QBValidator)

- (void)setValidationRules:(NSArray *)rules;
- (NSArray *)validationRules;

- (BOOL)validate:(NSArray * __autoreleasing *)errorMessages;

@end
