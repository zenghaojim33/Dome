//
//  RushOrdersInfoTableViewCell.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "RushOrdersInfoTableViewCell.h"
#import "UIImageView+FadeInEffect.h"
@implementation RushOrdersInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateCellWithModel:(OrderModel *)model
{
    
    int labelHeight;
    CGRect frame = self.OrdersTitle.frame;
    
    self.OrdersTitle.text = model.name;
    self.OrdersTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.OrdersTitle.numberOfLines = 0;
    labelHeight = [self.OrdersTitle getAttributedStringHeightWidthValue:290];
    frame.size.height = labelHeight;
    self.OrdersTitle.frame = frame;
    
    model.labelHeight = labelHeight;
    
    self.OrdersTitle.text = model.name;
    self.OrdersLastTime.text = [NSString stringWithFormat:@"下单时间:%@",model.createtime];
    self.OrdersPrice.text  = [NSString stringWithFormat:@"¥ %.2f",[model.price floatValue]];
    self.OrdersLabel.text = [NSString stringWithFormat:@"数量:%@",model.count];
    [self.OrdersImageView setImageUrlWithFadeInEffect:model.picture];
    self.selectionStyle = UITableViewCellAccessoryNone;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.2;
}

@end
