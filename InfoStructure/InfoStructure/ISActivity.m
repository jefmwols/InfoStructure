//
//  ISActivity.m
//  Pods
//
//  Created by Jobe,Jason on 10/1/13.
//
//

#import "ISActivity.h"
#import "ISRelay.h"


@implementation ISActivity

- (id)nextResponder
{
    return self.activityViewController;
}

- (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

-(void)activityDidFinish:(BOOL)completed
{
    [super activityDidFinish:completed];
    [[self relay] activity:self didFinish:completed];
}


@end

// We have to implement a method somewhere to insure its found in runtime lookups

@interface ISActivityResponder : NSObject <ISActivityResponder>
@end


@implementation ISActivityResponder

-(void)startActivityNamed:(NSString*)name withItems:(NSArray*)items {}
-(void)activity:(ISActivity*)activity didFinish:(BOOL)completed {}

@end

