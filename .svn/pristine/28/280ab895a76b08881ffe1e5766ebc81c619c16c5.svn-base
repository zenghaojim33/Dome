//
//  MyInfoViewController.m
//  Dome
//
//  Created by BTW on 14/12/22.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *BGView1;
@property (weak, nonatomic) IBOutlet UIView *BGView2;
@property (weak, nonatomic) IBOutlet UIView *BGView3;
@property (weak, nonatomic) IBOutlet UIView *BGView4;
@property (weak, nonatomic) IBOutlet UIView *BGView5;

@end

@implementation MyInfoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"个人信息";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BGView1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView1.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView1.layer.shadowOpacity = 0.2;
    
    self.BGView2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView2.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView2.layer.shadowOpacity = 0.2;
    
    self.BGView3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView3.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView3.layer.shadowOpacity = 0.2;
    
    self.BGView4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView4.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView4.layer.shadowOpacity = 0.2;
    
    self.BGView5.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView5.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView5.layer.shadowOpacity = 0.2;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
