//
//  CustomerTableViewCell.h
//  Dome
//
//  Created by BTW on 14/12/24.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *GuestName;
@property (weak, nonatomic) IBOutlet UILabel *LastTime;
@property (weak, nonatomic) IBOutlet UILabel *AllPrice;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end
