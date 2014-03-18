//
//  QBValidationBlockRuleTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface QBValidationBlockRuleTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation QBValidationBlockRuleTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"kumano"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVBlock(^BOOL(id value) { return ![value isEqual:@"yukikaze"]; })]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @"yukikaze"
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVBlock(^BOOL(id value) { return ![value isEqual:@"yukikaze"]; })]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    XCTAssertTrue(errorMessages.count == 1, @"Only one error must be occured.");
}

@end
