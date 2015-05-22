//
//  FeedbackViewController.m
//  Dome
//
//  Created by BTW on 15/1/4.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
<
    UITextViewDelegate
>
{
    UIBarButtonItem * barbutton;
    NSString * myText;
}
@property (weak, nonatomic) IBOutlet UIButton *SendButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, .5 });
    
    [self.textView.layer setMasksToBounds:YES];
    [self.textView.layer setCornerRadius:10.0];
    [self.textView.layer setBorderWidth:1.0];
    [self.textView.layer setBorderColor:colorref];
    [self.textView becomeFirstResponder];
    
    self.textView.delegate = self;
    
    //软件版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //设备型号
    NSString * Device = [[NSUserDefaults standardUserDefaults]objectForKey:@"Device"];

    //系统版本
    float Version = [[UIDevice currentDevice].systemVersion floatValue];
    
    //网络状态
    NSString * state = [self getNetWorkStates];
    myText= [NSString stringWithFormat:@"软件信息: 都商 (v%@) \n设备信息: %@ (IOS%.1f)\n网络状态: %@\n反馈内容:\n",appCurVersion,Device,Version,state];
 
    self.textView.text = myText;
    [self.SendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.SendButton.userInteractionEnabled = NO;
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (textView.text.length <= myText.length)
//    {
//        return NO;
//    }
//    return YES;
//}
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textView.length:%lu",(unsigned long)textView.text.length);
    if(textView.text.length == 0||[textView.text isEqualToString:myText])
    {
        //禁止
        [self.SendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.SendButton.userInteractionEnabled = NO;

        
    }else{

        [self.SendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.SendButton.userInteractionEnabled = YES;
        
    }
}
-(IBAction)TouchRightBarButton:(UIButton*)button
{
    NSLog(@"TouchRightBarButton");
    UIAlertView * av =[[UIAlertView alloc]initWithTitle:@"提交成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    av.tag = 888;
    [av show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==888) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 获取网络状态
-(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];

            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    if (netType == 0) {
        state = @"无网络";
    }
    //根据状态选择
    return state;
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
