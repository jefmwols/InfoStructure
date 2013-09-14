//
//  ModelerTests.m
//  ModelerTests
//
//  Created by Jason Jobe on 9/7/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ModelerTests : XCTestCase

@end

@implementation ModelerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPredicates
{
    NSArray *list = @[
                      @{@"flag": @YES, @"switch": @YES, @"num": @23 },
                      @{@"flag": @YES, @"switch": @NO, @"num": @23 },
                      @{@"flag": @NO,  @"switch": @YES, @"num": @23 },
                      @{@"flag": @NO,  @"switch": @NO, @"num": @23 },
                      ];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"flag = YES AND switch = YES"];
    NSArray *filtered = [list filteredArrayUsingPredicate:pred];
    
    NSLog(@"filtered is %@", filtered);
}

@end
