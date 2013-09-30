//
//  ISIndexViewController.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import "ISIndexViewController.h"
#import <ISRelay.h>
#import <InfoStructure/ISNavigation.h>

@interface ISIndexViewController ()

@end


@implementation ISIndexViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (editing) {
        UIButton *plus = [UIButton buttonWithType:UIButtonTypeSystem];
        [plus setTitle:@"Add One" forState:UIControlStateNormal];
        [plus sizeToFit];
        [plus addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView setTableFooterView:plus];
    }
    else {
        [self.tableView setTableFooterView:nil];
    }
    [super setEditing:editing animated:animated];
}

- (IBAction)addItem:(id)sender
{
        NSLog(@"Add one");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self performFetch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseId = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell = [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.0;
//}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSString*)identifierForCellAtIndexPath:(NSIndexPath*)indexPath
{
    return @"DefaultCell";
}

- (NSString*)defaultDisplayPropertyKey
{
    return [self.fetchedResultsController valueForKey:@"defaultDisplayKey"];
}

- (UITableViewCell*)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
{
    if (cell == nil) {
        NSString *reuseId = [self identifierForCellAtIndexPath:indexPath];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    //Locate Object for given row
    id value = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setRepresentedObject:)]) {
        [(id)cell setRepresentedObject:value];
    }

    //Set the cell's textLabel text to the value of the property used for sorting.
    NSString *displayKey = [self defaultDisplayPropertyKey];
    cell.textLabel.text = (displayKey ? [[value valueForKey:displayKey] description] : [value description]);
    
    //Check if the viewable property is turned off, if so disallow selection from index
//    if (self.isViewable == NO) {
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id sender = [tableView cellForRowAtIndexPath:indexPath];
    id selection;
    
    //    trace();
    
    if ([sender respondsToSelector:@selector(representedObject)]) {
        selection = [sender representedObject];
    }
//    else if ([self respondsToSelector:@selector(representedObject)]) {
//        selection = [self performSelector:@selector(representedObject)];
//    }
    else {
        selection = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    [[self relay] controller:self didSelect:selection sender:sender];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
//    return (indexPath.row > 0);
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)setFetchedResultsController:(ISResultsController *)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    self.fetchedResultsController.delegate = self;
}

- (BOOL)performFetch
{
    NSError *error;
    return [self.fetchedResultsController performFetch:&error];
}

//Execute Fetch

#pragma mark - NSFetchedResultsControllerDelegate
/*
 Assume self has a property 'tableView' -- as is the case for an instance of a UITableViewController
 subclass -- and a method configureCell:atIndexPath: which updates the contents of a given cell
 with information from a managed object at the given index path in the fetched results controller.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] forRowAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *srcVC = [segue sourceViewController];
    UIViewController *destinationVC = [segue destinationViewController];
    id selection;
    
//    trace();
    
    if ([sender respondsToSelector:@selector(representedObject)]) {
        selection = [sender representedObject];
    }
    else if ([srcVC respondsToSelector:@selector(representedObject)]) {
        selection = [srcVC performSelector:@selector(representedObject)];
    }
    else {
        selection = nil;
    }
    
    if ([destinationVC respondsToSelector:@selector(setRepresentedObject:)]) {
        [(id)destinationVC setRepresentedObject:selection];
    }
    
    [[self relay] didPrepareForSegue:segue withSelection:selection];
    
}

@end
