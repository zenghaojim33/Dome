//
//  OrderTableViewCell.h
//  Dome
//
//  Created by BTW on 15/3/11.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *OrdersImageView;
@property (weak, nonatomic) IBOutlet UILabel *OrdersTitle;
@property (weak, nonatomic) IBOutlet UILabel *OrdersLabel;
@property (weak, nonatomic) IBOutlet UILabel *OrdersLastTime;
@property (weak, nonatomic) IBOutlet UILabel *OrdersPrice;


-(void)updateCellWithModel:(OrderModel *)model;
@end
