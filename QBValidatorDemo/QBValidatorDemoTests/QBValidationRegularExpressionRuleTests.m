//
//  QBValidationRegularExpressionRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationRegularExpressionRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationRegularExpressionRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"kumano",
                                                   @"key2": @"I-58"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVMatch(@"^kuma.*$")],
                                                   @"key2": @[QBVMatch(@"I-\\d+")]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"mikuma",
                                                   @"key2": @"RO-60"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVMatch(@"^kuma.*$")],
                                                   @"key2": @[QBVMatch(@"I-\\d+")]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 2, @"Only one error must be occured.");
}

@end
