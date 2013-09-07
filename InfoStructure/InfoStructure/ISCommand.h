//
//  ISCommand.h
//  InfoStructure
//
//  Created by Jobe,Jason on 9/6/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISCommand : NSObject

/**
 *	Typically target-action definition
 *
 *	@param	actionSelector	IBAction MethodSignature
 */
+ action:(SEL)actionSelector forTarget:target;

+ commandForTarget:target;
+ commandForTarget:target named:(NSString*)name;
+ commandForTarget:target named:(NSString*)name icon:imageOrImageName;

- (void)invoke;

@end
