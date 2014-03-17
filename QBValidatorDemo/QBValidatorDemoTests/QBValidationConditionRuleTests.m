//
//  QBValidationConditionRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/16.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationConditionRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationConditionRuleTests

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
                                                   @"key2": @"goya"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVIf(QBVEqualTo(@(58)), @{@"key2": @[QBVEqualTo(@"goya")]})]
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
                                                   @"key2": @"goya"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVIf(QBVEqualTo(@(168)), @{@"key2": @[QBVEqualTo(@"imuya")]})]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
    XCTAssertTrue([(NSArray *)errorMessages[@"key2"] count] == 1, @"The error must be due to key2.");
}

- (void)testFailure2
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @(168),
                                                   @"key2": @"goya"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVIf(QBVEqualTo(@(168)), @{@"key2": @[QBVEqualTo(@"imuya")]})],
                                                   @"key2": @[QBVContainedIn(@[@"mogami", @"mikuma", @"suzuya", @"kumano"])]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Two errors must be occured.");
    XCTAssertTrue([(NSArray *)errorMessages[@"key2"] count] == 2, @"The errors must be due to key2.");
}

@end
