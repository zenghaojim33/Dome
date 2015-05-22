//
//  ProductViewController.m
//  Dome
//
//  Created by BTW on 15/3/5.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "ProductViewController.h"
#import "UIWebView+AFNetworking.h"
@interface ProductViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"商品预览";
    NSURL * url = [NSURL URLWithString:self.link];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    [self.myWebView loadRequest:request progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        [SVProgressHUD showProgress:totalBytesWritten/totalBytesExpectedToWrite status:@"加载中" maskType:SVProgressHUDMaskTypeNone];
        
    } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
        [SVProgressHUD dismiss];
        return HTML;
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        
    }];
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
