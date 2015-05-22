//
//  ExpressViewController.m
//  Dome
//
//  Created by BTW on 15/1/4.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "ExpressViewController.h"

@interface ExpressViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation ExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"物流信息";
    NSString * link =@"http://m.kuaidi100.com/index_all.html?type=全峰快递&postid=123456";
    NSLog(@"link:%@",link);
    link = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:link];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    
    
    //禁止上下滑动
    for (id subview in self.myWebView.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    self.myWebView.scrollView.bounces = NO;

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
