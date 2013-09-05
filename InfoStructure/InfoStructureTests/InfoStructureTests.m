//
//  InfoStructureTests.m
//  InfoStructureTests
//
//  Created by Jobe,Jason on 9/2/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISRelay.h"


@interface InfoStructureTests : XCTestCase

@end

@implementation InfoStructureTests

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

- (id)demo:(NSString*)name with:(NSString*)msg
{
    NSLog (@"Demo %@ says '%@'", name, msg);
    return [NSString stringWithFormat:@"%@:%@", name, msg];
}

- (void)testRelay
{
    id relay = [ISRelay relayFor:self];
    id val = [relay demo:@"Tom" with:@"hello"];
    NSLog (@"value = %@", val);
    //    [[self relay] demo:@"Tom" with:@"hello"];
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
