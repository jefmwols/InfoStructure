//
//  ISIndexViewController.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISResultsController.h"

@interface ISIndexViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSObject <ISResultsController> *fetchedResultsController;
@property (strong, nonatomic) NSObject *representedObject;
@property (assign, nonatomic) BOOL isEditable;

- (UITableViewCell*)configureCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

- (BOOL)performFetch;

@end
