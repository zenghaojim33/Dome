//
//  HomeViewController.m
//  Dome
//
//  Created by BTW on 14/12/22.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "HomeViewController.h"

#import "MyDomeViewController.h"
#import "GoodsViewController.h"
//#import "CommodityViewController.h"
#import "OrderManagementViewController.h"
#import "OrderViewController.h"
#import "RushOrdersViewController.h"
#import "MyIncomeViewController.h"
#import "CustomerViewController.h"
#import "ExtensionViewController.h"
#import "SettingViewController.h"
#import "MyInfoViewController.h"

#import "ChangInfoViewController.h"

#import "GuestModel.h"
@interface HomeViewController ()
{
    ShareInfo * shareInfo;
    MBProgressHUD * HUD;

}
@end

@implementation HomeViewController

#pragma mark ----- Life Cycle


-(void)viewDidLoad
{

    [super viewDidLoad];
    
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"登录成功" duration:1];

    
    if (shareInfo.userModel.shopname.length==0)
    {
        [self GetData];
    }

}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationBar];

}


#pragma ----- Private Method

-(void)GetData
{
    //获取用户的详细信息
    
    shareInfo = [ShareInfo shareInstance];
    
    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[shareInfo.userModel.userID] forKeys:@[@"id"]];
    
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    
    
    NSString * link = [[NSString stringWithFormat:GetInfo,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"link:%@",link);
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(NSDictionary *dict, NSError *error) {
        NSMutableDictionary * response = [NSMutableDictionary dictionaryWithDictionary:dict];
        [self GetInfoData:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        });

    }];
    

}
- (void)GetInfoData:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    NSMutableDictionary * info = [dict objectForKey:@"info"];
    
    shareInfo.userModel.shopname=[info objectForKey:@"shopname"];
    shareInfo.userModel.shopinfo=[info objectForKey:@"shopinfo"];
    shareInfo.userModel.acountname = info[@"acountname"];
    shareInfo.userModel.address = info[@"address"];
    shareInfo.userModel.area = info[@"area"];
    shareInfo.userModel.bank = info[@"bank"];
    shareInfo.userModel.bankno = info[@"bankno"];
    shareInfo.userModel.certificate = info[@"certificate"];
    shareInfo.userModel.city = info[@"city"];
    shareInfo.userModel.email = info[@"email"];
    shareInfo.userModel.provinces = info[@"provinces"];

}



#pragma mark 初始化 NavigationBar 属性
-(void)initNavigationBar
{

    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        
    {
        
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        
        
        self.navigationController.navigationBar.translucent = NO;
        
    }
    
    else
        
    {
        
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];

    }

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    

}
#pragma mark 我的都美
- (IBAction)TouchDome:(id)sender
{
    MyDomeViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyDomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 货品上架
- (IBAction)TouchGoods:(id)sender
{
    GoodsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsViewController"];
    vc.title = @"服装";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 销售管理
- (IBAction)TouchCommodity:(UIButton *)button
{
    OrderManagementViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderManagementViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 抢单广场
- (IBAction)TouchRushOrders:(UIButton *)button
{
    RushOrdersViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RushOrdersViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 我的财富
- (IBAction)TouchIncome:(UIButton *)button
{
    MyIncomeViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyIncomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 客户管理
- (IBAction)TouchCustomer:(UIButton *)button
{
    CustomerViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 我要推广
- (IBAction)TouchExtension:(UIButton *)button
{
    ExtensionViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExtensionViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 设置
- (IBAction)TouchSetting:(UIButton *)button
{
    SettingViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 订单
- (IBAction)TouchOrderButton:(UIButton *)button
{
    OrderViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 个人信息
- (IBAction)TouchInfoButton:(UIButton *)button
{
    ChangInfoViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangInfoViewController"];
    vc.isChange = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ShowAlertView
-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
}


/*
#pragma mark - Navigation'

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
