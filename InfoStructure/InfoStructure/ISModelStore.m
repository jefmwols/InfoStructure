//
//  ISModelStore.m
//  InfoStructure
//
//  Created by Jason Jobe on 9/7/13.
//  Copyright (c) 2013 Jobe,Jason. All rights reserved.
//

#import "ISModelStore.h"


NSString * const ISModelIncrementalStoreType = @"ISModelIncrementalStoreType";
NSString * const ISStoreConfigureDebugEnabled = @"ISStoreConfigureDebugEnabled";

@interface ISModelStore ()
    @property BOOL debugEnabled;
@end


@implementation ISModelStore

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator
                       configurationName:(NSString *)name
                                     URL:(NSURL *)url
                                 options:(NSDictionary *)options
{
    self = [super initWithPersistentStoreCoordinator:coordinator configurationName:name URL:url options:options];
    
    if (self) {
        NSNumber *debugEnabled = options[ISStoreConfigureDebugEnabled];
        self.debugEnabled = [debugEnabled boolValue];
    }
    return self;
}

#pragma mark - NSIncrementalStore Subclass Methods

- (BOOL)loadMetadata:(NSError **)error
{
    // This store is pretty forgiving because keys it doesn't know about are
    // ignored so there is no "schema" to check that we are compatible with
    // at this point.
    [self setMetadata:@{
                        NSStoreUUIDKey: @"1",
                        NSStoreTypeKey: ISModelIncrementalStoreType
                        }];
    return YES;
}

- (id)executeRequest:(NSPersistentStoreRequest *)request
         withContext:(NSManagedObjectContext *)context
               error:(NSError **)error
{
    NSString *errorMessage = nil;
    
    switch (request.requestType) {
        case NSFetchRequestType:
            return nil;
            break;
            
        case NSSaveRequestType:
            
        default:
            errorMessage = [NSString stringWithFormat:@"Unsupported request type %d", request.requestType];
            *error = [NSError errorWithDomain:@"ISModelStore"
                                         code:0
                                     userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
            return nil;
    }
}

- (NSIncrementalStoreNode *)newValuesForObjectWithID:(NSManagedObjectID *)objectID
                                         withContext:(NSManagedObjectContext *)context
                                               error:(NSError **)error
{
    NSDictionary *values = @{};
    if (!values) return nil;
    return [[NSIncrementalStoreNode alloc] initWithObjectID:objectID withValues:values version:0];
}

- (id)newValueForRelationship:(NSRelationshipDescription *)relationship
              forObjectWithID:(NSManagedObjectID *)objectID
                  withContext:(NSManagedObjectContext *)context
                        error:(NSError **)error {
    
    NSAssert(false, @"Relationships are not supported yet");
    return nil;
}

- (NSArray *)obtainPermanentIDsForObjects:(NSArray *)objects
                                    error:(NSError **)error
{
    NSMutableArray *ids = [NSMutableArray array];
    
    for (NSManagedObject *object in objects) {
        NSString *referenceObject = [[NSProcessInfo processInfo] globallyUniqueString];
        [ids addObject:[self newObjectIDForEntity:object.entity referenceObject:referenceObject]];
    }
    return ids;
}

+(NSString *)newUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    return uuidString;
}

@end
