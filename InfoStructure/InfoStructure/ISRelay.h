//
//  ISRelay.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

/*
 *	The ISRelay tries to find a target that can respond to arbitrary messages
 *  (selectors). It looks for a target starting with one given and then
 *  looks to see if the object has a delegate property. If it does then it checks
 *  it as well. If the initial target isKindOfClass:UIResponder, then it
 *  continues on up the responder chain, checking for delegates along the way
 *  as well.
 *
 *  Once found it returns it to the runtime, which, in turn, executes the method
 *  on the newly found target;
 *
 *	@param	aSelector	an arbitrary message
 *
 *	@return	an object that can perform the message
 */

#import <Foundation/Foundation.h>

@interface ISRelay : NSObject

+ relayFor:target;
+ relayFor:target conformingToProtocol:(Protocol*)protocol;

@end


@interface NSObject (ISRelayTarget)

- relay;
- relayConformingToProtocol:(Protocol*)protocol;

@end