//
//  iCTransactionCell.m
//  ISDemo
//
//  Created by Jason Jobe on 9/27/13.
//  Copyright (c) 2013 Jason Jobe. All rights reserved.
//

#import "iCTransactionCell.h"

@implementation iCTransactionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
