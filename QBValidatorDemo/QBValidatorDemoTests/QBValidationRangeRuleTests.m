//
//  QBValidationRangeRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationRangeRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationRangeRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58),
                                                   @"key2": @"password"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVInRange(1, 100)],
                                                   @"key2": @[QBVInRange(8, 16)]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(168),
                                                   @"key2": @"passwd"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVInRange(1, 100)],
                                                   @"key2": @[QBVInRange(8, 16)]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 2, @"Two errors must be occured.");
}

- (void)testParameterRobustness
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58)
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVInRange(100, 1)]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

@end
