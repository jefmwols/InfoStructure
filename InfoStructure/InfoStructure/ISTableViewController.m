//
//  ISTableViewController.m
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import "ISTableViewController.h"

@interface ISTableViewController ()
@end

@implementation ISTableViewController

- (id)initWithEntityName:(NSString*)entityName representedObject:value context:(NSManagedObjectContext*)moc;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        //Setup Properties
        self.isDeletable = YES;
        self.isEditable = YES;
    
        //Setup properties
        self.entityName = entityName;
        self.managedObjectContext = moc;
        self.title = self.entityName;
//        self.title = [NSString stringWithFormat:@"Add %@",self.entityName.capitalizedString];
        
        //Create EntityDescription
        _entityDescription = [NSEntityDescription entityForName:self.entityName
                                         inManagedObjectContext:self.managedObjectContext];
        
        //Get Attributes from Entity
        _attributes = [[_entityDescription attributesByName] allValues];
        
        if (value) {
            self.representedObject = value;
        }
        else {
            self.representedObject = [NSMutableDictionary dictionaryWithCapacity:[_attributes count]];
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configure
{
    //Setup Properties
    self.isDeletable = YES;
    self.isEditable = YES;
    
}

- (void)setRepresentedObject:(id)representedObject
{
    [self willChangeValueForKey:@"reprsentedObject"];
    _representedObject = representedObject;
    //Setup properties
    if ([representedObject isKindOfClass:[NSManagedObject class]])
    {
        NSManagedObject *mo = (NSManagedObject*)representedObject;
        _entityDescription = [mo entity];
        _attributes = [[_entityDescription attributesByName] allValues];

        self.entityName = [_entityDescription name];
        self.managedObjectContext = [mo managedObjectContext];
        self.title = [self.entityName capitalizedString];
    }
    [self willChangeValueForKey:@"reprsentedObject"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSAttributeDescription*)propertyForIndexPath:(NSIndexPath*)indexPath
{
    return [_attributes objectAtIndex:[indexPath row]];
}

- valueForIndexPath:(NSIndexPath*)indexPath
{
    NSAttributeDescription *property = [self propertyForIndexPath:indexPath];
    [self.representedObject valueForKey:[property name]];
}

- (void)tableCell:(UITableViewCell*)cell updateValue:value atIndexPath:(NSIndexPath *)indexPath
{
    NSAttributeDescription *property = [self propertyForIndexPath:indexPath];
   [self.representedObject setValue:value forKey:[property name]];
}

- cellIndentifierForIndexPath:(NSIndexPath*)indexPath
{
    return @"DefaultCell";
}

#pragma mark - UIDatePicker Delegate

- (void)datePickerValueChanged:(UIDatePicker*)sender
{
    //Date has been picked
    UIDatePicker *datePicker = sender;
    
    //Create indexPath using DatePicker's tag to ensure correct row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:datePicker.tag inSection:0];
    
    //Reference cell to be updated
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self tableCell:cell updateValue:datePicker.date atIndexPath:indexPath];
    
    //Refresh to show changes
    [self.tableView reloadData];
}

- (UITableViewCell*)configureCell:(UITableViewCell*)cell withIdentifier:(NSString*)ident
                forRowAtIndexPath:(NSIndexPath*)indexPath;
{
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    NSAttributeDescription *property = [self propertyForIndexPath:indexPath];
    id value = [self valueForIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(setRepresentedObject:)]) {
        [(id)cell setRepresentedObject:value];
    }
    else {
        cell.textLabel.text = [value description];
        cell.detailTextLabel.text = property.name;
    }
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_attributes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self cellIndentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [self configureCell:cell withIdentifier:CellIdentifier forRowAtIndexPath:indexPath];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
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
*/

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
