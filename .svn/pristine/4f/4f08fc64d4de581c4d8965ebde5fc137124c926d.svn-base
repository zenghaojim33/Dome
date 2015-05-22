//
//  AddressTableViewCell.h
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//
@protocol AddressCellDelegate;
#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property(nonatomic,strong)id<AddressCellDelegate>delegate;
@end
@protocol AddressCellDelegate <NSObject>

-(void)TouchChangeButtonForTag:(long int)tag;
-(void)TouchDeleteButtonForTag:(long int)tag;
@end