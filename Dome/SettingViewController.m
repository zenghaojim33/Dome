//
//  SettingViewController.m
//  Dome
//
//  Created by BTW on 14/12/22.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
<
UIActionSheetDelegate
>
{
    int count;
    MBProgressHUD * HUD;
}
@property (weak, nonatomic) IBOutlet UIView *BGView1;
@property (weak, nonatomic) IBOutlet UIView *BGView2;
@property (weak, nonatomic) IBOutlet UIView *BGView3;
@property (weak, nonatomic) IBOutlet UIView *BGView4;


@property(nonatomic,weak)NSTimer * timer;
@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"设置";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";

    self.navigationItem.backBarButtonItem = backItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BGView1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView1.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView1.layer.shadowOpacity = 0.1;
    
    self.BGView2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView2.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView2.layer.shadowOpacity = 0.1;
    
    self.BGView3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView3.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView3.layer.shadowOpacity = 0.1;
    
    self.BGView4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView4.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView4.layer.shadowOpacity = 0.1;
    
    // Do any additional setup after loading the view.
}
#pragma mark 检查更新
- (IBAction)TouchUpDates:(id)sender
{
     HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     HUD.labelText = @"正在检查更新";
    
    count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(time:)
                                           userInfo:nil
                                            repeats:YES];
    
}
-(void)time:(id)sender
{
    

    count++;
    if (count == 1)
    {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.timer timeInterval];
        UIAlertView * av =[[UIAlertView alloc]initWithTitle:@"当前是最新版本" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [av show];
        [self.timer invalidate];
        
    }
    
}
#pragma mark 退出当前账号
- (IBAction)TouchQuit:(UIButton *)sender
{
    UIActionSheet * actionSheet =
    [[UIActionSheet alloc]initWithTitle:nil
                               delegate:nil
                      cancelButtonTitle:@"取消"
                 destructiveButtonTitle:@"退出"
                      otherButtonTitles:nil];
    actionSheet.delegate=self;//有时不调用时需要输入这句话
    [actionSheet showInView:self.view];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"%d",buttonIndex);
    if (buttonIndex==0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{ NSLog(@"您选择了取消");}
};
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
