//
//  RushOrdersInfoTableViewCell.h
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLUILabel.h"
#import "OrderModel.h"
@interface RushOrdersInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *OrdersImageView;
@property (weak, nonatomic) IBOutlet SHLUILabel *OrdersTitle;
@property (weak, nonatomic) IBOutlet UILabel *OrdersLabel;
@property (weak, nonatomic) IBOutlet UILabel *OrdersLastTime;
@property (weak, nonatomic) IBOutlet UILabel *OrdersPrice;


-(void)updateCellWithModel:(OrderModel *)model;


@end