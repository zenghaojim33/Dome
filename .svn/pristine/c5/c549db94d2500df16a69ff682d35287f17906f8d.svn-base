//
//  MyDomeTableViewCell.h
//  Dome
//
//  Created by BTW on 15/1/28.
//  Copyright (c) 2015年 jenk. All rights reserved.
//
@protocol MyDomeTableViewCellDelegate;
#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface MyDomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ButtonView;
@property (weak, nonatomic) IBOutlet UIImageView *TitleImages;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIButton *CellButton;
@property (strong,nonatomic)id<MyDomeTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *inPrice;
@property (nonatomic) BOOL isMyDome;
@property (nonatomic) BOOL isSelect;

-(void)updateCellWithModel:(ProductModel *)model;


@end
@protocol MyDomeTableViewCellDelegate <NSObject>

-(void)TouchDownForTag:(long int)tag;
-(void)TouchCopyForTag:(long int)tag;
-(void)TouchShareForTag:(long int)tag;

@end