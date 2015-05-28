//
//  AppDelegate.m
//  Dome
//
//  Created by BTW on 14/12/18.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置全局Nav样式
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial-Black" size:20.0f],NSFontAttributeName,nil];
    [[UINavigationBar appearance]setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [UINavigationBar appearance].barStyle = UIStatusBarStyleDefault;
    
    
    //判断当前设备
    [self deviceString];
    
    //推送
    [self initPush:application];
    
    //修改状态栏
    [self changeStatusBar:application];
    
    //友盟分享
    [self setUMSocia];
    
    [IQKeyboardManager load];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
//    [[PgyManager sharedPgyManager] startManagerWithAppId:@"93ea3d890734653a42977d022e4fec02"];
//    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
//    [[PgyManager sharedPgyManager] checkUpdate];

    return YES;
}
//- (void)updateMethod:(NSDictionary *)response
//{
//    NSLog(@"Response is %@", response);
//    
//    //  调用checkUpdateWithDelegete后可用此方法来更新本地的版本号，如果有更新的话，在调用了此方法后再次调用将不提示更新信息。
//    [[PgyManager sharedPgyManager] updateLocalBuildNumber];
//}
#pragma mark 友盟分享
-(void)setUMSocia
{

    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //    //打开调试log的开关
    //    [UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx2f715ea59b2f5af0" appSecret:@"f3d78a77261c4280a9938f74fdcc82e7" url:@"http://www.dome123.com"];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://api.weibo.com/oauth2/default.html"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1104266642" appKey:@"TbOZRpjCrV9OPVYN" url:@"http://www.dome123.com"];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //设置易信Appkey和分享url地址
    [UMSocialYixinHandler setYixinAppKey:@"yxcfb28b2226914d48ab32df1e9ada6f79" url:@"http://www.dome123.com"];
    
    //设置facebook应用ID，和分享纯文字用到的url地址
    [UMSocialFacebookHandler setFacebookAppID:@"91136964205" shareFacebookWithURL:@"http://www.umeng.com/social"];
    
    //下面打开Instagram的开关
    [UMSocialInstagramHandler openInstagramWithScale:NO paddingColor:[UIColor blackColor]];
    [UMSocialTwitterHandler openTwitter];
    
    //打开whatsapp
    [UMSocialWhatsappHandler openWhatsapp:UMSocialWhatsappMessageTypeImage];
    
    //打开Tumblr
    [UMSocialTumblrHandler openTumblr];
    
    //打开line
    [UMSocialLineHandler openLineShare:UMSocialLineMessageTypeImage];

}
#pragma mark 新浪微博回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"新浪微博回调：%@",url.description);
    return  [UMSocialSnsService handleOpenURL:url];
    
}


#pragma mark 推送
-(void)initPush:(UIApplication *)application
{
 
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    
    else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    
}
#pragma mark 修改状态栏
-(void)changeStatusBar:(UIApplication*)application
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        self.window.clipsToBounds =YES;
    }
}
#pragma mark 判断当前设备
// #import "sys/utsname.h"
- (void)deviceString
{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    deviceString = @"iPhone1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    deviceString = @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    deviceString = @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    deviceString = @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    deviceString = @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    deviceString = @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    deviceString = @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    deviceString = @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone6,2"])    deviceString = @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone7,2"])    deviceString = @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"])    deviceString = @"iPhone6Plus";
    
    //iPod
    
    if ([deviceString isEqualToString:@"iPod1,1"])      deviceString = @"iPod Touch1";
    if ([deviceString isEqualToString:@"iPod2,1"])      deviceString = @"iPod Touch2";
    if ([deviceString isEqualToString:@"iPod3,1"])      deviceString = @"iPod Touch3";
    if ([deviceString isEqualToString:@"iPod4,1"])      deviceString = @"iPod Touch4";
    if ([deviceString isEqualToString:@"iPod5,1"])      deviceString = @"iPod Touch5";
    
    //iPad
    
    if ([deviceString isEqualToString:@"iPad1,1"])      deviceString = @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      deviceString = @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,2"])      deviceString = @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,3"])      deviceString = @"iPad2";
    if ([deviceString isEqualToString:@"iPad3,1"])      deviceString = @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,2"])      deviceString = @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,3"])      deviceString = @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,4"])      deviceString = @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,5"])      deviceString = @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,6"])      deviceString = @"iPad4";
    if ([deviceString isEqualToString:@"iPad4,1"])      deviceString = @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,2"])      deviceString = @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,3"])      deviceString = @"iPadAir";
    if ([deviceString isEqualToString:@"iPad5,1"])      deviceString = @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,2"])      deviceString = @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,3"])      deviceString = @"iPadAir2";
    
    //iPad mini

    if ([deviceString isEqualToString:@"iPad2,5"])      deviceString = @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,6"])      deviceString = @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      deviceString = @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad4,4"])      deviceString = @"iPad Mini2";
    if ([deviceString isEqualToString:@"iPad4,5"])      deviceString = @"iPad Mini2";
    if ([deviceString isEqualToString:@"iPad4,6"])      deviceString = @"iPad Mini2";
    if ([deviceString isEqualToString:@"iPad4,7"])      deviceString = @"iPad Mini3";
    if ([deviceString isEqualToString:@"iPad4,8"])      deviceString = @"iPad Mini3";
    if ([deviceString isEqualToString:@"iPad4,9"])      deviceString = @"iPad Mini3";
    
    //Simulator
    
    if ([deviceString isEqualToString:@"i386"])         deviceString = @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       deviceString = @"Simulator";
    
    
    float Version = [[UIDevice currentDevice].systemVersion floatValue];
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceString forKey:@"Device"];
    
    [[NSUserDefaults standardUserDefaults] setFloat:Version forKey:@"Version"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
 
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
