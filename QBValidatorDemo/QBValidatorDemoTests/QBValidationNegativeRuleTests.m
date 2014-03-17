//
//  QBValidationNegativeRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationNegativeRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationNegativeRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(19),
                                                   @"key2": @(168),
                                                   @"key3": @"haguro"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVNot(QBVEqualTo(@(58)))],
                                                   @"key2": @[QBVNot(QBVInRange(1, 100))],
                                                   @"key3": @[QBVNot(QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"]))]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(58),
                                                   @"key2": @(58),
                                                   @"key3": @"kumano"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVNot(QBVEqualTo(@(58)))],
                                                   @"key2": @[QBVNot(QBVInRange(1, 100))],
                                                   @"key3": @[QBVNot(QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"]))]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 3, @"Three errors must be occured.");
}

@end
