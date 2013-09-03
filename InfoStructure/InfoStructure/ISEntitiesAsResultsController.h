//
//  ISEntitiesAsResultsController.h
//  InfoStructure Framework
//
//  Created by Jobe,Jason on 9/1/13.
//  Copyright (c) 2013 WildThink, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ISResultsController.h"



@interface ISEntitiesAsResultsController : ISResultsController

- initWithManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

@end

/**
 *	This enables easy integration of the standard controller
 *  into the more general purpose variety
 */
@interface NSFetchedResultsController (ISResultsControllerCompatabity) <ISResultsController>

@end

