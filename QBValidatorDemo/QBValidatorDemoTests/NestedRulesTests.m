//
//  NestedRulesTests.m
//  QBValidatorDemo
//
//  Created by Tanaka Katsuma on 2014/03/18.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QBValidator.h"

@interface NestedRulesTests : XCTestCase

@property (nonatomic, strong) QBValidator *validator;

@end

@implementation NestedRulesTests

- (void)setUp
{
    [super setUp];
    
    self.validator = [QBValidator validator];
}

- (void)testSuccess
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @{
                                                           @"subkey1": @"subvalue1",
                                                           @"subkey2": @{
                                                                   @"subsubkey1": @"subsubvalue1"
                                                                   }
                                                           }
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVRequired, @{
                                                                  @"subkey1": @[QBVEqualTo(@"subvalue1")],
                                                                  @"subkey2": @[QBVRequired, @{
                                                                                    @"subsubkey1": @[QBVEqualTo(@"subsubvalue1")]
                                                                                    }]
                                                                  }
                                                              ]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertTrue(result, @"The result must be valid.");
    XCTAssertTrue(errorMessages.count == 0, @"No errors must be occured.");
}

- (void)testFailure
{
    NSDictionary *errorMessages = nil;
    BOOL result = [self.validator validateValues:@{
                                                   @"key1": @{
                                                           @"subkey1": @"subvalue2",
                                                           @"subkey2": @{
                                                                   @"subsubkey1": @"subsubvalue2"
                                                                   }
                                                           }
                                                   }
                                           rules:@{
                                                   @"key1": @[QBVRequired, @{
                                                                  @"subkey1": @[QBVEqualTo(@"subvalue1")],
                                                                  @"subkey2": @[QBVRequired, @{
                                                                                    @"subsubkey1": @[QBVEqualTo(@"subsubvalue1")]
                                                                                    }]
                                                                  }
                                                              ]
                                                   }
                                   errorMessages:&errorMessages];
    
    XCTAssertFalse(result, @"The result must be invalid.");
    
    NSArray *key1ErrorMessages = errorMessages[@"key1"];
    XCTAssertTrue(key1ErrorMessages.count == 1);
    
    NSArray *subkey1ErrorMessages = key1ErrorMessages[0][@"subkey1"];
    XCTAssertTrue(subkey1ErrorMessages.count == 1);
    
    NSArray *subkey2ErrorMessages = key1ErrorMessages[0][@"subkey2"];
    XCTAssertTrue(subkey2ErrorMessages.count == 1);
    
    NSArray *subsubkey1ErrorMessages = subkey2ErrorMessages[0][@"subsubkey1"];
    XCTAssertTrue(subsubkey1ErrorMessages.count == 1);
}

@end
