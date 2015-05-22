//
//  AboutDomeViewController.m
//  Dome
//
//  Created by BTW on 15/1/4.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "AboutDomeViewController.h"

@interface AboutDomeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *Version;

@end

@implementation AboutDomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于都美";
    
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 10, 80, 80)];
    imageView.image= [UIImage imageNamed:@"1024.png"];
    [self.view addSubview:imageView];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    [self.textView.layer setMasksToBounds:YES];
    [self.textView.layer setBorderWidth:1.0];
    [self.textView.layer setBorderColor:colorref];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *nameString = [infoDictionary objectForKey:@"CFBundleName"];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.Version.text = [NSString stringWithFormat:@"%@(v%@)",nameString,version];
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
