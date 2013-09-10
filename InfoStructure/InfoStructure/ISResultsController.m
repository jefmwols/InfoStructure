//
//  ISResultsController.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import "ISResultsController.h"

@interface ISResultsController ()

@end

@implementation ISResultsController

@synthesize sectionNameKeyPath;
@synthesize cacheName;
@synthesize delegate;
@synthesize fetchedObjects;
@synthesize sectionIndexTitles;
@synthesize sections;
//@synthesize managedObjectContext;
@synthesize defaultDisplayKey;
@synthesize representedObject;


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

