//
//  QBValidationComparisonRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationComparisonRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationComparisonRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testEqual
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58),
                                                   @"key2": @(168),
                                                   @"key3": @"kumano",
                                                   @"key4": @"suzuya",
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVEqualTo(@(58))],
                                                   @"key2": @[QBVEqualTo(@(58))],
                                                   @"key3": @[QBVEqualTo(@"kumano")],
                                                   @"key4": @[QBVEqualTo(@"kumano")]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 2, @"Two errors must be occured.");
}

- (void)testGreaterThan
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(168),
                                                   @"key2": @(19),
                                                   @"key3": @"mogami"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVGreaterThan(@(58))],
                                                   @"key2": @[QBVGreaterThan(@(58))],
                                                   @"key3": @[QBVGreaterThan(@"mikuma")]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
}

- (void)testGreaterThanOrEqual
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58),
                                                   @"key2": @(19)
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVGreaterThanOrEqualTo(@(58))],
                                                   @"key2": @[QBVGreaterThanOrEqualTo(@(58))]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
}

- (void)testLessThan
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(19),
                                                   @"key2": @(168),
                                                   @"key3": @"mikuma"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVLessThan(@(58))],
                                                   @"key2": @[QBVLessThan(@(58))],
                                                   @"key3": @[QBVLessThan(@"mogami")]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
}

- (void)testLessThanOrEqual
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58),
                                                   @"key2": @(168)
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVLessThanOrEqualTo(@(58))],
                                                   @"key2": @[QBVLessThanOrEqualTo(@(58))]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
}

@end
