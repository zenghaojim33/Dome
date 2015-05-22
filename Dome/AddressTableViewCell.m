//
//  AddressTableViewCell.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)TouchChangeButton:(id)sender {
    [self.delegate TouchChangeButtonForTag:self.tag];
}
- (IBAction)TouchDeleteButton:(id)sender {
    [self.delegate TouchDeleteButtonForTag:self.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
