//
//  SellerContainerViewController.m
//  Dome
//
//  Created by Anson on 15/5/25.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "SellerContainerViewController.h"
#import "qrencode.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"




@implementation SellerContainerViewController

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

@end
