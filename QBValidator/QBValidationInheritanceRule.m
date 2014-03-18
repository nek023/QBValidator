//
//  QBValidationInheritanceRule.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import "QBValidationInheritanceRule.h"
#import <objc/runtime.h>

@interface QBValidationInheritanceRule ()

@property (nonatomic, copy, readwrite) NSString *className;
@property (nonatomic, assign, readwrite) QBValidationInheritanceType type;

@end

@implementation QBValidationInheritanceRule

+ (instancetype)ruleWithClass:(Class)class type:(QBValidationInheritanceType)type
{
    return [[self alloc] initWithClass:class type:type];
}

- (instancetype)initWithClass:(Class)class type:(QBValidationInheritanceType)type
{
    self = [super init];
    
    if (self) {
        self.className = NSStringFromClass(class);
        self.type = type;
    }
    
    return self;
}

- (NSString *)description
{
    NSString *typeString = nil;
    
    switch (self.type) {
        case QBValidationInheritanceTypeKindOfClass:
            typeString = @"QBValidationInheritanceTypeKindOfClass";
            break;
            
        case QBValidationInheritanceTypeMemberOfClass:
            typeString = @"QBValidationInheritanceTypeMemberOfClass";
            
        case QBValidationInheritanceTypeSubclassOfClass:
            typeString = @"QBValidationInheritanceTypeSubclassOfClass";
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"<%@: %p; className = %@; type = %@>",
            NSStringFromClass([self class]),
            self,
            self.className,
            typeString
            ];
}


#pragma mark - Localization

- (NSString *)localizationKey
{
    switch (self.type) {
        case QBValidationInheritanceTypeKindOfClass:
            return [NSStringFromClass([self class]) stringByAppendingString:@"KindOfClass"];
            break;
            
        case QBValidationInheritanceTypeMemberOfClass:
            return [NSStringFromClass([self class]) stringByAppendingString:@"MemberOfClass"];
            break;
            
        case QBValidationInheritanceTypeSubclassOfClass:
            return [NSStringFromClass([self class]) stringByAppendingString:@"SubclassOfClass"];
            break;
            
        default:
            break;
    }
    
    return nil;
}


#pragma mark - Validating Value

- (BOOL)validateValue:(id)value
{
    Class class = NSClassFromString(self.className);
    
    switch (self.type) {
        case QBValidationInheritanceTypeKindOfClass:
        {
            return [value isKindOfClass:class];
        }
            break;
            
        case QBValidationInheritanceTypeMemberOfClass:
        {
            return [value isMemberOfClass:class];
        }
            break;
            
        case QBValidationInheritanceTypeSubclassOfClass:
        {
            if (class_isMetaClass(object_getClass(value))) {
                return [value isSubclassOfClass:class];
            } else {
                return [[value class] isSubclassOfClass:class];
            }
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}

@end
