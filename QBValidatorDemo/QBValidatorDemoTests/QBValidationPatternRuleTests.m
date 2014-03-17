//
//  QBValidationPatternRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationPatternRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationPatternRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testEmailPattern
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"nobody@example.com",
                                                   @"key2": @"nobody+alias@example.com",
                                                   @"key3": @"no.body..@example.com"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVEmail],
                                                   @"key2": @[QBVEmail],
                                                   @"key3": @[QBVNot(QBVEmail)]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testURIPattern
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"http://example.com/",
                                                   @"key2": @"javascript:exploit_code();/*\n" "http://hi.com\n" "*/"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVURI],
                                                   @"key2": @[QBVNot(QBVURI)]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

@end
