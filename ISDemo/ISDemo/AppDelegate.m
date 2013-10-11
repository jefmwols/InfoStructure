//
//  AppDelegate.m
//  ISDemo
//
//  Created by Jason Jobe on 9/7/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import "AppDelegate.h"
#import <InfoStructure/ISTableViewController.h>
#import <InfoStructure/ISStaticResultsController.h>
#import <InfoStructure/ISIndexViewController.h>
#import <InfoStructure/ISNavigation.h>
#import <InfoStructure/ISModelStore.h>
#import <ISRelay.h>
#import <ISDataSource.h>

#import <REMenu.h>
#import <REMenuItem.h>


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)willPerformSegue:(UIStoryboardSegue*)segue
{
    return YES;
}

-(void)didPrepareForSegue:(UIStoryboardSegue*)segue withSelection:selection;
{
    
}

- (void)controller:(UIViewController*)controller list:entity
{
    
}

- (void)sender:sender requestsInsertOf:entity
{
    NSString* entityName = [entity isKindOfClass:[NSEntityDescription class]] ? [entity name] : entity;
    id nob = [NSEntityDescription
                        insertNewObjectForEntityForName:entityName
                        inManagedObjectContext:self.managedObjectContext];
    
    [[sender relay] sender:sender requestsEditObject:nob];
}

- (void)controller:(ISIndexViewController*)controller requestsFetch:(NSFetchRequest*)fetch
{
    if ([fetch.entityName isEqualToString:@"entities"]) {
        ISStaticResultsController *results = [[ISStaticResultsController alloc]
                                              initWithObjects:[self.managedObjectModel entities]];
        results.defaultDisplayKey = @"name";
        controller.fetchedResultsController = results;
        [controller setRepresentedObject:results];
        [results performFetch:NULL];
    }
    else {
        controller.isEditable = YES;
    }
}

- (void)controller:(UIViewController*)controller didSelect:(id)selection sender:(id)sender
{
    NSLog(@"selected %@", selection);
    
    UINavigationController *nav = (UINavigationController*)self.window.rootViewController;
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[selection name]];
    [req setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    ISIndexViewController *newController = [[ISIndexViewController alloc] init];

    newController.title = [selection name];
    newController.isEditable = YES;
    newController.fetchedResultsController = results;
    [newController setRepresentedObject:results];
    [results performFetch:NULL];
    [nav pushViewController:newController animated:YES];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSPersistentStoreCoordinator registerStoreClass:[ISModelStore class]
                                        forStoreType:ISModelIncrementalStoreType];
    
    UINavigationController *nav = (UINavigationController*)self.window.rootViewController;
    ISIndexViewController *controller = (ISIndexViewController*)nav.topViewController;

    [[controller relay] controller:controller
                     requestsFetch:[NSFetchRequest fetchRequestWithEntityName:@"entities"]];
    return YES;
}

- (void)configure
{
//    (UINavigationController)
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ISDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ISDemo.sqlite"];
    NSDictionary *options = @{
        NSMigratePersistentStoresAutomaticallyOption:@YES,
        NSInferMappingModelAutomaticallyOption:@YES
        };
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    ISModelStore *store =
    (ISModelStore*)[_persistentStoreCoordinator addPersistentStoreWithType:ISModelIncrementalStoreType
                                                             configuration:@"Type"
                                                                       URL:[NSURL URLWithString:@"storeA"]
                                                                   options:options
                                                                     error:&error];
    
    store.model = [self managedObjectModel];

//    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                              configuration:@"Default" URL:storeURL options:options error:&error]
    if (!store)
    {
         /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

- (void)cancelActionsForController:(UIViewController*)controller
{
    [self.menu close];
}

- (void)showMenuForController:(UIViewController*)controller
{

REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
                                                subtitle:@"Return to Home Screen"
                                                   image:[UIImage imageNamed:@"Icon_Home"]
                                        highlightedImage:nil
                                                  action:^(REMenuItem *item) {
                                                      NSLog(@"Item: %@", item);
                                                  }];

REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Explore"
                                                   subtitle:@"Explore 47 additional options"
                                                      image:[UIImage imageNamed:@"Icon_Explore"]
                                           highlightedImage:nil
                                                     action:^(REMenuItem *item) {
                                                         NSLog(@"Item: %@", item);
                                                     }];

REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Activity"
                                                    subtitle:@"Perform 3 additional activities"
                                                       image:[UIImage imageNamed:@"Icon_Activity"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];

REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"Profile"
                                                      image:[UIImage imageNamed:@"Icon_Profile"]
                                           highlightedImage:nil
                                                     action:^(REMenuItem *item) {
                                                         NSLog(@"Item: %@", item);
                                                     }];

    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    
    UINavigationController *nav = (UINavigationController*)self.window.rootViewController;
    [self.menu showFromNavigationController:nav];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
