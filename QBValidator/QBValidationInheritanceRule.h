//
//  QBValidationInheritanceRule.h
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationRule.h"

typedef NS_ENUM(NSUInteger, QBValidationInheritanceType) {
    QBValidationInheritanceTypeKindOfClass,
    QBValidationInheritanceTypeMemberOfClass,
    QBValidationInheritanceTypeSubclassOfClass
};

@interface QBValidationInheritanceRule : QBValidationRule

@property (nonatomic, copy, readonly) NSString *className;
@property (nonatomic, assign, readonly) QBValidationInheritanceType type;

+ (instancetype)ruleWithClass:(Class)class type:(QBValidationInheritanceType)type;
- (instancetype)initWithClass:(Class)class type:(QBValidationInheritanceType)type;

@end
