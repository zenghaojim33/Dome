//
//  OrderTableViewCell.m
//  Dome
//
//  Created by BTW on 15/3/11.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "UIImageView+FadeInEffect.h"
@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)updateCellWithModel:(OrderModel *)model
{
    
    self.OrdersTitle.text = [NSString stringWithFormat:@"订单号:%@",model.suborderid];
    
    self.OrdersLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.OrdersLastTime.text = [NSString stringWithFormat:@"下单时间:%@",model.createtime];
    float price = [model.price floatValue];
    self.OrdersPrice.text  = [NSString stringWithFormat:@"¥ %.2f x %@",price,model.count];
    
    NSString * path = model.picture;

    [self.OrdersImageView setImageUrlWithFadeInEffect:path];
    
    
    self.selectionStyle = UITableViewCellAccessoryNone;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.2;
    
    

    
    
}



@end
