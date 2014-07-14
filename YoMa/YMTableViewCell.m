//
//  YMTableViewCell.m
//  YoMa
//
//  Created by Sumedha Pramod on 7/13/14.
//  Copyright (c) 2014 Sumedha Pramod. All rights reserved.
//

#import "YMTableViewCell.h"

@implementation YMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
