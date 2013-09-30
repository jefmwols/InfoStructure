//
//  AppDelegate.h
//  ISDemo
//
//  Created by Jason Jobe on 9/7/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  REMenu;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) REMenu *menu;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
