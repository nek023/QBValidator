//
//  QBValidationRangeRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/15.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRangeRule.h"

@interface QBValidationRangeRule ()

@property (nonatomic, assign, readwrite) NSNumber *minValue;
@property (nonatomic, assign, readwrite) NSNumber *maxValue;
@property (nonatomic, assign, readwrite) BOOL inclusive;

@end

@implementation QBValidationRangeRule

+ (instancetype)ruleWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue inclusive:(BOOL)inclusive
{
    return [[self alloc] initWithMinValue:minValue maxValue:maxValue inclusive:inclusive];
}

- (instancetype)initWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue inclusive:(BOOL)inclusive
{
    self = [super init];
    
    if (self) {
        self.minValue = minValue;
        self.maxValue = maxValue;
        self.inclusive = inclusive;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; minValue = %@; maxValue = %@; inclusive = %@>",
            NSStringFromClass([self class]),
            self,
            self.minValue,
            self.maxValue,
            self.inclusive ? @"YES" : @"NO"
            ];
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        if ([value isKindOfClass:[NSString class]]) {
            value = @([(NSString *)value length]);
        }
        
        // Adjust min and max value
        NSNumber *minValue = self.minValue;
        NSNumber *maxValue = self.maxValue;
        
        if ([minValue compare:maxValue] == NSOrderedDescending) {
            minValue = self.maxValue;
            maxValue = self.minValue;
        }
        
        // Compare
        NSComparisonResult resultOfComparisonToMin = [value compare:minValue];
        NSComparisonResult resultOfComparisonToMax = [value compare:maxValue];
        
        if (self.inclusive) {
            return ((resultOfComparisonToMin == NSOrderedDescending || resultOfComparisonToMin == NSOrderedSame) &&
                    (resultOfComparisonToMax == NSOrderedAscending || resultOfComparisonToMax == NSOrderedSame));
        } else {
            return (resultOfComparisonToMin == NSOrderedDescending && resultOfComparisonToMax == NSOrderedAscending);
        }
    }
    
    return NO;
}

@end
