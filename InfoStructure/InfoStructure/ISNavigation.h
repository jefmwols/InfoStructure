//
//  ISNavigation.h
//  Pods
//
//  Created by Jobe,Jason on 9/12/13.
//
//

#import <Foundation/Foundation.h>

@interface ISNavigation : NSObject

-(void)didPrepareForSegue:(UIStoryboardSegue*)segue withSelection:selection;
- (void)controller:(UIViewController*)controller didSelect:(id)selection sender:(id)sender;

@end
