//
//  QBValidationContainmentRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationContainmentRule.h"

@interface QBValidationContainmentRule ()

@property (nonatomic, copy, readwrite) NSArray *preferredValues;

@end

@implementation QBValidationContainmentRule

+ (instancetype)ruleWithPreferredValues:(NSArray *)preferredValues
{
    return [[self alloc] initWithPreferredValues:preferredValues];
}

- (instancetype)initWithPreferredValues:(NSArray *)preferredValues
{
    self = [super init];
    
    if (self) {
        self.preferredValues = preferredValues;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; preferredValues = %@>",
            NSStringFromClass([self class]),
            self,
            self.preferredValues
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    return [self.preferredValues containsObject:value];
}

@end
