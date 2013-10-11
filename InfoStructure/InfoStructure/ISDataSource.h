//
//  ISDataSource.h
//  Pods
//
//  Created by Jobe,Jason on 10/1/13.
//
//

#import "ISActivity.h"

@interface ISDataSource : ISActivity

@end



@protocol ISDataSourceResponder <NSObject>

- (void)sender:sender requestsInsertOf:(NSString*)entityName;
- (void)sender:sender requestsEditObject:nob;

@end
