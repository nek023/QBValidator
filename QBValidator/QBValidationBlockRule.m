//
//  QBValidationBlockRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationBlockRule.h"

@interface QBValidationBlockRule ()

@property (nonatomic, copy, readwrite) BOOL (^block)(id value);

@end

@implementation QBValidationBlockRule

+ (instancetype)ruleWithBlock:(BOOL (^)(id value))block
{
    return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(BOOL (^)(id value))block
{
    self = [super init];
    
    if (self) {
        self.block = block;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; block = %@>",
            NSStringFromClass([self class]),
            self,
            self.block
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    if (self.block) {
        return self.block(value);
    }
    
    return NO;
}

@end
