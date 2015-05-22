//
//  RushOrdersTableViewCell.h
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//
@protocol RushOrdersDelegate;
#import <UIKit/UIKit.h>

@interface RushOrdersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *OrdersTitle;
@property (weak, nonatomic) IBOutlet UILabel *OrdersInfo;
@property (weak, nonatomic) IBOutlet UILabel *OrdersIntegral;
@property (nonatomic,strong)id<RushOrdersDelegate>delegate;
@end
@protocol RushOrdersDelegate <NSObject>

-(void)TouchButtonForTag:(long int)tag;

@end
