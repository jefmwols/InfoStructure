//
//  InfoStructureTests.m
//  InfoStructureTests
//
//  Created by Jobe,Jason on 9/2/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ISRelay.h"
#import "EXTNil.h"
#import "ISCommand.h"


@interface BogusStuff : NSObject
- (id)baddemo:(NSString*)name with:(NSString*)msg;
@end

/**
 *	Any method expecting a runtime lookup has to implemented
 *  somewhere to actally show up in the runtime.
 */
@implementation BogusStuff
- (id)baddemo:(NSString*)name with:(NSString*)msg
{
    return @"hi there";
}
@end


@interface InfoStructureTests : XCTestCase
@property id delegate;
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

- (void)testCommand
{
    id command = [ISCommand commandForTarget:self];
    [command  demo:@"Fred" with:@"Yaba-daba do"];
    [command invoke];
}


- (void)testRelay
{
    id relay = [ISRelay relayFor:self];
    id val = [relay demo:@"Tom" with:@"hello"];
    XCTAssertEqualObjects(val, @"Tom:hello", @"");
    
    val = [[self relay] baddemo:@"Tom" with:@"hello"];
    XCTAssertNil(val, @"");
    
    self.delegate = [[BogusStuff alloc] init];
    val = [[self relay] baddemo:@"Tom" with:@"hello"];
    XCTAssertNotNil(val, @"");
    self.delegate = nil;
 }

- (void)testEXTNil
{
    id val = [[EXTNil null] valueForKey:@"fh"];
    XCTAssertNil(val, @"");
}

@end
