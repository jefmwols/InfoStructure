//
//  ISEntitiesAsResultsController.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import "ISStaticResultsController.h"

@interface ISFetchedResultsSectionInfo ()
    @property (nonatomic, readwrite) NSString *name;
    @property (nonatomic, readwrite) NSString *indexTitle;
    @property (nonatomic, readwrite) NSUInteger numberOfObjects;
    @property (nonatomic, readwrite) NSArray *objects;
@end

@implementation ISFetchedResultsSectionInfo
@end


@interface ISStaticResultsController ()
    @property (nonatomic, readwrite) NSArray *sections;
//    @property (nonatomic, readwrite) NSArray *objects;
@end

@implementation ISStaticResultsController


//- initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
- initWithObjects:(NSArray*)objects
{
    self = [super init];
//    self.managedObjectContext = managedObjectContext;
    
    self.fetchedObjects = objects;
    
    // Build a simple single section
    ISFetchedResultsSectionInfo *section = [[ISFetchedResultsSectionInfo alloc] init];
    section.indexTitle = nil;
    section.objects = objects;
    section.numberOfObjects = [section.objects count];
    
    self.sections = @[section];
    
    return self;
}

- objectAtIndexPath:(NSIndexPath*)indexPath
{
    return [self.fetchedObjects objectAtIndex:[indexPath row]];
}

- (BOOL)performFetch:(NSError **)error;
{
    id target = self.delegate;
    
    if ([target respondsToSelector:@selector(controllerWillChangeContent:)]) {
        [target controllerWillChangeContent:(id)self];
    }
    if ([target respondsToSelector:@selector(controllerDidChangeContent:)]) {
        [target controllerDidChangeContent:(id)self];
    }
    return YES;
}

//- (NSArray *)fetchedObjects
//{
//    return self.objects;
////    NSManagedObjectModel *model = self.managedObjectContext.persistentStoreCoordinator.managedObjectModel;
////    return [model entities];
//}

/* Returns the indexPath of a given object.
 */
-(NSIndexPath *)indexPathForObject:(id)object;
{
    return nil;
}

- (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
{
    return [sectionName capitalizedString];
}


/* Returns the section number for a given section title and index in the section index.
 It's expected that developers call this method when executing UITableViewDataSource's
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
 */
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)sectionIndex;
{
    return 0;
}

@end
