//
//  QBValidationContainmentRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationContainmentRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationContainmentRuleTests

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
                                                   @"key2": @"kumano"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVContainedIn(@[@(8), @(19), @(168), @(401)])],
                                                   @"key2": @[QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"])]
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
                                                   @"key2": @"haguro"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVContainedIn(@[@(8), @(19), @(168), @(401)])],
                                                   @"key2": @[QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"])]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 2, @"Two errors must be occured.");
}

@end
