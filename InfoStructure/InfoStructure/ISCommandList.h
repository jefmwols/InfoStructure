//
//  ISCommandList.h
//  InfoStructure
//
//  Created by Jobe,Jason on 9/6/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	The CommandList subclasses NSArray in order to provide
 *  standardized indexed and enumeration calls
 *
 *  for (ISCommand *cmd in myCommandList) {
 *    ...
 *  }
 */

@interface ISCommandList : NSArray

- addCommandForTarget:target;
- addCommandForTarget:target named:(NSString*)name;
- addCommandForTarget:target named:(NSString*)name icon:imageOrImageName;

@end
