//
//  ISRelay.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "ISRelay.h"
#import "EXTNil.h"


static inline BOOL CanDo (id target, SEL selector, Protocol *protocol)
{
    if ([target respondsToSelector:selector]) {
        if (protocol == nil) {
            return YES;;
        }
        else if ([target conformsToProtocol:protocol]) {
                return YES;
        }
    }
    return NO;
}

@interface ISRelay ()
    @property (strong, nonatomic) Protocol *protocol;
    @property (weak, nonatomic) id target;

- nextResponder;

@end


@implementation ISRelay

+ relayFor:target {
    return [[[self class] alloc] initWithTarget:target conformingToProtocol:nil];
}

+ relayFor:target conformingToProtocol:(Protocol*)protocol {
    return [[[self class] alloc] initWithTarget:target conformingToProtocol:protocol];
}

- initWithTarget:target conformingToProtocol:(Protocol*)protocol {
    self.target = target;
    self.protocol = protocol;
    return self;
}

- (id)nextResponder
{
    return nil;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if (CanDo (self.target, aSelector, self.protocol))
    {
        return self.target;
    }
    if ([self.target respondsToSelector:@selector(delegate)])
    {
        id delegate = [self.target delegate];
        if (CanDo (delegate, aSelector, self.protocol)) {
            return delegate;
        }
    }
    if ([self.target respondsToSelector:@selector(nextResponder)])
    {
        id responder = self.target;
        while ((responder = [responder nextResponder])) {
            if (CanDo (responder, aSelector, self.protocol)) {
                return responder;
            }
            if ([responder respondsToSelector:@selector(delegate)]) {
                id delegate = [(id)responder delegate];
                if (CanDo (delegate, aSelector, self.protocol)) {
                    return delegate;
                }
            }
        }
    }
    // else
    // return EXTNil gives us the behavior of nil as a target to the orginal method call
    // returning an actual nil at this point tells the runtime we got nothing resulting
    // in an exception
    return [EXTNil null];
}

@end


@implementation NSObject (ISRelayTarget)

- relay {
    return [ISRelay relayFor:self];
}

- relayConformingToProtocol:(Protocol*)protocol {
    return [ISRelay relayFor:self conformingToProtocol:protocol];
}

@end