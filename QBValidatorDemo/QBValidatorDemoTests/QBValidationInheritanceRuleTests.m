//
//  QBValidationInheritanceRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface MyClassA : NSObject

@end

@implementation MyClassA

@end


@interface MyClassB : MyClassA

@end

@implementation MyClassB

@end


@interface MyClassC : NSObject

@end

@implementation MyClassC

@end


@interface QBValidationInheritanceRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationInheritanceRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": [MyClassB new],
                                                   @"key2": [MyClassB new],
                                                   @"key3": [MyClassB new]
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVKindOfClass([MyClassA class])],
                                                   @"key2": @[QBVMemberOfClass([MyClassB class])],
                                                   @"key3": @[QBVSubclassOfClass([MyClassA class])]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": [MyClassC new],
                                                   @"key2": [MyClassC new],
                                                   @"key3": [MyClassC new]
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVKindOfClass([MyClassA class])],
                                                   @"key2": @[QBVMemberOfClass([MyClassB class])],
                                                   @"key3": @[QBVSubclassOfClass([MyClassA class])]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 3, @"Three errors must be occured.");
    
    NSLog(@"%@", errorMessages);
}

@end
