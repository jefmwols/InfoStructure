//
//  NSAttributeDescription+ValueCoercion.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//
#ifdef TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#import <CoreData/CoreData.h>

@interface NSAttributeDescription (ValueCoercion)

- valueForStorageFrom:value;

#ifdef TARGET_OS_IPHONE
- (UIView*)defaultKeyboardView;
- (UIKeyboardType)defaultKeyboardType;
#endif

@end
