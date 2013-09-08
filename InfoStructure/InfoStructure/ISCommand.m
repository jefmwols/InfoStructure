//
//  ISCommand.m
//  InfoStructure
//
//  Created by Jobe,Jason on 9/6/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import "ISCommand.h"
//#import "EXTRuntimeExtensions.h"

@interface ISCommand()
    @property (strong, nonatomic) id target;
    @property (strong, nonatomic) NSString *name;
    @property (strong, nonatomic) id icon;
    @property (strong, nonatomic) NSInvocation *invocation;
@end


@implementation ISCommand

+ action:(SEL)actionSelector forTarget:target;
{
    return nil;
}

+ commandForTarget:target {
    return [self commandForTarget:target named:nil icon:nil];
}

+ commandForTarget:target named:(NSString*)name {
    return [self commandForTarget:target named:nil icon:nil];
}

+ commandForTarget:target named:(NSString*)name icon:imageOrImageName;
{
    ISCommand *cmd = [[ISCommand alloc] init];
    cmd.name = name;
    cmd.target = target;
    cmd.icon = imageOrImageName;
    return cmd;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (self.invocation) {
        // Raise ???
        return;
    }
    self.invocation = anInvocation;
    // We nil out the target to give us the option of doing a weak
    // retain on it at a futre date. No harm in including it now as
    // we rely on the invokeWithTarget in self.invoke
    self.invocation.target = nil;
    [self.invocation retainArguments];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.target methodSignatureForSelector:selector];
    //    return ext_globalMethodSignatureForSelector(selector);
}
- (void)invoke
{
    [self.invocation invokeWithTarget:self.target];
}

@end
