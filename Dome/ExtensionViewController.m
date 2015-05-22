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
    shareInfo = [ShareInfo shareInstance];
    // Do any additional setup after loading the view.
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(16, 5, self.view.frame.size.width-32, 60)];
    textView.userInteractionEnabled = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = @"把都美推荐给您的朋友，成功推荐朋友注册开都美，您将获得他的都美销售额的6%分润哦。";
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:textView];
    
    self.BGView = [[UIView alloc]initWithFrame:CGRectMake(16, 60, self.view.frame.size.width - 32, self.view.frame.size.width - 32)];
    self.BGView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView.layer.shadowOpacity = 0.2;
    
    [self initCode];
    [self.view addSubview:self.BGView];
    
    UIButton * ShareButton = [[UIButton alloc]initWithFrame:CGRectMake(16,60+self.view.frame.size.width-32+10, self.view.frame.size.width/2-32-10, 40)];
    [ShareButton setBackgroundImage:[UIImage imageNamed:@"ButtonBGView.jpg"] forState:UIControlStateNormal];
    [ShareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ShareButton setTitle:@"分享链接" forState:UIControlStateNormal];
    [ShareButton addTarget:self action:@selector(TouchShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ShareButton];
    
    UIButton * QRCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(16+self.view.frame.size.width/2+10,60+self.view.frame.size.width-32+10, self.view.frame.size.width/2-32-10, 40)];
    [QRCodeButton setBackgroundImage:[UIImage imageNamed:@"ButtonBGView.jpg"] forState:UIControlStateNormal];
    [QRCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [QRCodeButton setTitle:@"分享二维码" forState:UIControlStateNormal];
    [QRCodeButton addTarget:self action:@selector(TouchQRCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QRCodeButton];

    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
           [Tools showPromptToView:self.view atPoint:self.view.center withText:@"分享成功" duration:0.7];
        
        //Because November is luck month
    }
}
#pragma mark 分享链接
-(void)TouchShareButton:(UIButton*)button
{
    //微信网页类型
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    NSString *shareText = @"都商二维码";             //分享内嵌文字
    UIImage *shareImage =self.ImageView.image;          //分享内嵌图片
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = codeStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = codeStr;
    [UMSocialData defaultData].extConfig.qqData.url = codeStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = codeStr;
    
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54a350bffd98c51f0900012d" shareText:shareText shareImage:shareImage shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms] delegate:self];

}
#pragma mark 分享二维码
-(void)TouchQRCodeButton:(UIButton*)button
{
    
//    UIImage * iamge = [self getImageFromView:self.ImageView];

    
    //微信图片类型
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;

    NSString *shareText = @"都商二维码";             //分享内嵌文字
    UIImage *shareImage = [self getImageFromView:self.ImageView];          //分享内嵌图片
    [UMSocialData defaultData].extConfig.qqData.url = codeStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = codeStr;
    
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54a350bffd98c51f0900012d" shareText:shareText shareImage:shareImage shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms] delegate:self];

}
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark 初始化二维码
-(void)initCode
{
    
    
    self.ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.BGView.frame.size.width, self.BGView.frame.size.height)];

    
    codeStr = [NSString stringWithFormat:RQCode,shareInfo.userModel.userID];
    
    UIImage * Code = [ExtensionViewController qrImageForString:codeStr imageSize:self.ImageView.frame.size.width];
    QRCodeIMG = [self addImage:[UIImage imageNamed:@"CodeBG288.jpg"] toImage:Code];




    self.ImageView.image = QRCodeIMG;

    [self.BGView addSubview:self.ImageView];
}
+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [ExtensionViewController drawQRCode:code context:ctx size:size];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
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
