//
//  QBValidationRequirementRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRequirementRule.h"

@implementation QBValidationRequirementRule

#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    if ([value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)value;
        
        if (string.length == 0) {
            return NO;
        }
    }
    
    return (value != nil);
}

@end
