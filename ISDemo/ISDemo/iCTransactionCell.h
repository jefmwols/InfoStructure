//
//  iCTransactionCell.h
//  ISDemo
//
//  Created by Jason Jobe on 9/27/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iCTransactionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImage *icon;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UILabel *byline;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
