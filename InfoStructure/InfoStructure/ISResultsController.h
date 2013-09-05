//
//  ISResultsController.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ISFetchedResultsSectionInfo : NSObject <NSFetchedResultsSectionInfo>

/* Name of the section
 */
@property (nonatomic, readonly) NSString *name;

@property (strong, nonatomic) NSString *defaultDisplayKey;

/* Title of the section (used when displaying the index)
 */
@property (nonatomic, readonly) NSString *indexTitle;

/* Number of objects in section
 */
@property (nonatomic, readonly) NSUInteger numberOfObjects;

/* Returns the array of objects in the section.
 */
@property (nonatomic, readonly) NSArray *objects;

@end


/**
 *	This specification is designed to closely mimic the NSFetchedResultsController
 *  but does NOT use nor require an NSFetchSpecification.
 */
@protocol ISResultsController <NSObject>

/* The keyPath on the fetched objects used to determine the section they belong to.
 */
@property (nonatomic, readonly) NSString *sectionNameKeyPath;

/* Name of the persistent cached section information. Use nil to disable persistent caching, or +deleteCacheWithName to clear a cache.
 */
@property (nonatomic, readonly) NSString *cacheName;

/* Delegate that is notified when the result set changes.
 */
@property(nonatomic, assign) NSObject* delegate;

/* Deletes the cached section information with the given name.
 If name is nil, then all caches are deleted.
 */
//+ (void)deleteCacheWithName:(NSString *)name;

/* ========================================================*/
/* ============= ACCESSING OBJECT RESULTS =================*/
/* ========================================================*/

/* Returns the results of the fetch.
 Returns nil if the performFetch: hasn't been called.
 */
@property  (nonatomic, readonly) NSArray *fetchedObjects;

/* Returns the fetched object at a given indexPath.
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/* Returns the indexPath of a given object.
 */
-(NSIndexPath *)indexPathForObject:(id)object;

/* ========================================================*/
/* =========== CONFIGURING SECTION INFORMATION ============*/
/* ========================================================*/
/*	These are meant to be optionally overridden by developers.
 */

/* Returns the corresponding section index entry for a given section name.
 Default implementation returns the capitalized first letter of the section name.
 Developers that need different behavior can implement the delegate method -(NSString*)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName
 Only needed if a section index is used.
 */
- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;

/* Returns the array of section index titles.
 It's expected that developers call this method when implementing UITableViewDataSource's
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
 
 The default implementation returns the array created by calling sectionIndexTitleForSectionName: on all the known sections.
 Developers should override this method if they wish to return a different array for the section index.
 Only needed if a section index is used.
 */
@property (nonatomic, readonly) NSArray *sectionIndexTitles;

/* ========================================================*/
/* =========== QUERYING SECTION INFORMATION ===============*/
/* ========================================================*/

/* Returns an array of objects that implement the NSFetchedResultsSectionInfo protocol.
 It's expected that developers use the returned array when implementing the following methods of the UITableViewDataSource protocol
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
 - (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section;
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
 
 */
@property (nonatomic, readonly) NSArray *sections;

/* Returns the section number for a given section title and index in the section index.
 It's expected that developers call this method when executing UITableViewDataSource's
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
 */
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)sectionIndex;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSString *defaultDisplayKey;

- (BOOL)performFetch:(NSError **)error;

@end


@interface ISResultsController : NSObject <ISResultsController>

@property (strong, nonatomic) NSString *sectionNameKeyPath;
@property (strong, nonatomic) NSString *cacheName;
@property (nonatomic, assign) NSObject *delegate;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) NSArray *sectionIndexTitles;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSString *defaultDisplayKey;

@end


/**
 *	This enables easy integration of the standard controller
 *  into the more general purpose variety
 */
@interface NSFetchedResultsController (ISResultsControllerCompatabity) <ISResultsController>

@end

