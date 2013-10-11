//
//  ISModelStore.h
//  InfoStructure
//
//  Created by Jason Jobe on 9/7/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import <CoreData/CoreData.h>

extern NSString * const ISModelIncrementalStoreType;
extern NSString * const ISStoreConfigureDebugEnabled;


@interface ISModelStore : NSIncrementalStore

@property (strong, nonatomic) NSManagedObjectModel *model;

@end
