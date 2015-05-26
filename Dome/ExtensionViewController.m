//
//  ExtensionViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "ExtensionViewController.h"
#import "qrencode.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
@interface ExtensionViewController ()
<
    UMSocialUIDelegate
>
{
    NSString * codeStr;
    UIImage * QRCodeIMG;
    ShareInfo * shareInfo;
}
@property (strong, nonatomic) UIImageView *ImageView;
enum {
    qr_margin = 3
};
@property (strong, nonatomic) UIView *BGView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *QRCodeSwitch;
@property (weak, nonatomic) IBOutlet UIView *sellerContainerView;
@property (weak, nonatomic) IBOutlet UIView *buyerContainerView;




@end

@implementation ExtensionViewController


#pragma mark 弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"我要推广";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    shareInfo = [ShareInfo shareInstance];
//    // Do any additional setup after loading the view.
//    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(16, 5, self.view.frame.size.width-32, 60)];
//    textView.userInteractionEnabled = NO;
//    textView.backgroundColor = [UIColor clearColor];
//    textView.text = @"把都美推荐给您的朋友，成功推荐朋友注册开都美，您将获得他的都美销售额的6%分润哦。";
//    textView.textAlignment = NSTextAlignmentCenter;
//    textView.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:textView];
//    
//    self.BGView = [[UIView alloc]initWithFrame:CGRectMake(16, 60, self.view.frame.size.width - 32, self.view.frame.size.width - 32)];
//    self.BGView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.BGView.layer.shadowOffset = CGSizeMake(1, 1);
//    self.BGView.layer.shadowOpacity = 0.2;
//    
//    [self initCode];
//    [self.view addSubview:self.BGView];
//    
//    UIButton * ShareButton = [[UIButton alloc]initWithFrame:CGRectMake(16,60+self.view.frame.size.width-32+10, self.view.frame.size.width/2-32-10, 40)];
//    [ShareButton setBackgroundImage:[UIImage imageNamed:@"ButtonBGView.jpg"] forState:UIControlStateNormal];
//    [ShareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [ShareButton setTitle:@"分享链接" forState:UIControlStateNormal];
//    [ShareButton addTarget:self action:@selector(TouchShareButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:ShareButton];
//    
//    UIButton * QRCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(16+self.view.frame.size.width/2+10,60+self.view.frame.size.width-32+10, self.view.frame.size.width/2-32-10, 40)];
//    [QRCodeButton setBackgroundImage:[UIImage imageNamed:@"ButtonBGView.jpg"] forState:UIControlStateNormal];
//    [QRCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [QRCodeButton setTitle:@"分享二维码" forState:UIControlStateNormal];
//    [QRCodeButton addTarget:self action:@selector(TouchQRCodeButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:QRCodeButton];
    
    self.sellerContainerView.hidden = NO;
    self.buyerContainerView.hidden = YES;
    
    

    
}

- (IBAction)switchContainerView:(id)sender {
    
    
    switch (self.QRCodeSwitch.selectedSegmentIndex) {
        case 0:
            self.buyerContainerView.hidden = YES;
            self.sellerContainerView.hidden = NO;
            break;
        case 1:
            self.buyerContainerView.hidden = NO;
            self.sellerContainerView.hidden = YES;
            break;
        default:
            break;
    }
    
    
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
