//
//  ISActivity.h
//  Pods
//
//  Created by Jobe,Jason on 10/1/13.
//
//

#import <Foundation/Foundation.h>


@interface ISActivity : UIActivity

@property (strong, nonatomic) UIImage *activityImage;
@property (strong, nonatomic) NSString *activityTitle;

@end



@protocol ISActivityResponder <NSObject>

// The startActivity methods thread from the single into the array version
-(void)startActivityNamed:(NSString*)name withItem:item;
-(void)startActivityNamed:(NSString*)name withItems:(NSArray*)items;

-(void)activity:(ISActivity*)activity didFinish:(BOOL)completed;

@end

