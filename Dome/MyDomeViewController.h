//
//  MyDomeViewController.h
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDomeViewController : UIViewController
@property(nonatomic,strong)NSMutableArray * Products;
@property(nonatomic,strong)NSString * key;
@property(nonatomic,strong)NSString * seachtype;
@property(nonatomic,strong)NSString * sort;
@property(nonatomic,strong)NSString * valueids;
@property(nonatomic,strong)NSString * categoryid;
@property(nonatomic,strong)NSString * sequence;
@property (strong, nonatomic) IBOutlet UIButton *DoneButton;
@end
