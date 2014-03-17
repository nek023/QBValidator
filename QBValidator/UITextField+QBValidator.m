//
//  UITextField+QBValidator.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "UITextField+QBValidator.h"
#import <objc/runtime.h>

#import "QBValidator.h"

static char UITextFieldValidationRulesKey;

@implementation UITextField (QBValidator)

#pragma mark - Accessors

- (void)setValidationRules:(NSArray *)rules
{
    objc_setAssociatedObject(self, &UITextFieldValidationRulesKey, rules, OBJC_ASSOCIATION_COPY);
}

- (NSArray *)validationRules
{
    return (NSArray *)objc_getAssociatedObject(self, &UITextFieldValidationRulesKey);
}


#pragma mark - Validating Value

- (BOOL)validate:(NSArray * __autoreleasing *)errorMessages
{
    QBValidator *validator = [QBValidator validator];
    NSString *name = (self.placeholder != nil) ? self.placeholder : [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
    
    return [validator validateValue:self.text name:name rules:[self validationRules] errorMessages:errorMessages];
}

@end
