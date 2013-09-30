//
//  ISNavigation.m
//  Pods
//
//  Created by Jobe,Jason on 9/12/13.
//
//

#import "ISNavigation.h"

@implementation ISNavigation

/**
  We require an actuall implemenation on some object so the NSMethodSignature
  will be available from the runtime.
*/
-(void)didPrepareForSegue:(UIStoryboardSegue*)segue withSelection:selection
{}

- (void)controller:(UIViewController*)controller didSelect:(id)selection sender:(id)sender;
{}

@end
