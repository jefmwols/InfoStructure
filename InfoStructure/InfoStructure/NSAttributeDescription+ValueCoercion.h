//
//  NSAttributeDescription+ValueCoercion.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NSAttributeDescription (ValueCoercion)

- (UIView*)defaultKeyboardView;
- (UIKeyboardType)defaultKeyboardType;
- valueForStorageFrom:value;

@end
