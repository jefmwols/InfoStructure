//
//  ISCommandList.m
//  InfoStructure
//
//  Created by Jobe,Jason on 9/6/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import "ISCommandList.h"
#import "ISCommand.h"

@interface ISCommandList ()
@property (strong, nonatomic) NSMutableArray *commands;
@end


@implementation ISCommandList

- init
{
    self.commands = [NSMutableArray array];
    return self;
}

- addCommandForTarget:target {
    return [self addCommandForTarget:target named:nil icon:nil];
}

- addCommandForTarget:target named:(NSString*)name {
    return [self addCommandForTarget:target named:name icon:nil];
}

- addCommandForTarget:target named:(NSString*)name icon:imageOrImageName;
{
    ISCommand *command = [ISCommand commandForTarget:target named:name icon:imageOrImageName];
    [self.commands addObject:command];
    return command;
}

#pragma mark - NSArray
- (id)objectAtIndex:(NSUInteger)index
{
    return [self.commands objectAtIndex:index];
}

- (NSUInteger)count {
    return [self.commands count];
}

#pragma mark - NSMutableArray



@end
