//
//  UpGradeViewController.m
//  Dome
//
//  Created by BTW on 15/5/14.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "UpGradeViewController.h"

@interface UpGradeViewController ()
<
    UITextFieldDelegate
>
{
    MBProgressHUD * HUD;
    ShareInfo * shareInfo;
    BOOL TF1;
    BOOL TF2;
    BOOL TF3;
    BOOL TF4;
}
@property (weak, nonatomic) IBOutlet UITextField *shopID1TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID2TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID3TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID4TF;
@end

@implementation UpGradeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"升级卖家";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    self.shopID1TF.delegate = self;
    self.shopID2TF.delegate = self;
    self.shopID3TF.delegate = self;
    self.shopID4TF.delegate = self;
    
    self.shopID1TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID2TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID3TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID4TF.autocorrectionType=UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view.
}
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (string.length>4)
    {
        NSLog(@"粘贴 string:%@",string);
        
        if (textField.tag == 0)
        {
            self.shopID1TF.text =  [string substringWithRange:NSMakeRange(0, 4)];
            self.shopID2TF.text =  [string substringWithRange:NSMakeRange(4, 4)];
            self.shopID3TF.text =  [string substringWithRange:NSMakeRange(8, 4)];
            self.shopID4TF.text =  [string substringWithRange:NSMakeRange(12, 4)];
        }else if (textField.tag == 1)
        {
            self.shopID2TF.text =  [string substringWithRange:NSMakeRange(4, 4)];
            self.shopID3TF.text =  [string substringWithRange:NSMakeRange(8, 4)];
            self.shopID4TF.text =  [string substringWithRange:NSMakeRange(12, 4)];
        }else if (textField.tag == 2)
        {
            self.shopID3TF.text =  [string substringWithRange:NSMakeRange(8, 4)];
            self.shopID4TF.text =  [string substringWithRange:NSMakeRange(12, 4)];
        }else{
            self.shopID4TF.text =  [string substringWithRange:NSMakeRange(12, 4)];
            
        }
        [self.shopID4TF becomeFirstResponder];
        TF1 = YES;
        TF2 = YES;
        TF3 = YES;
        TF4 = YES;
        return NO;
    }else{
        
        if (textField.tag == 88)
        {
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength > 11)
            {
                return NO;
            }
        }
        
        
        if(textField.text.length==1)
        {
            if (textField.tag != 0)
            {
                
                if (self.shopID1TF.text.length>=4&&self.shopID2TF.text.length>=4&&self.shopID3TF.text.length>=4&&self.shopID4TF.text.length==1&&TF1==YES    &&TF2==YES&&TF3==YES&&TF4==YES)
                {
                    TF4 = NO;
                    self.shopID4TF.text = @"";
                    [self.shopID3TF becomeFirstResponder];
                }
                if (self.shopID1TF.text.length>=4&&self.shopID2TF.text.length>=4&&self.shopID3TF.text.length==1&&TF1==YES&&TF2==YES&&TF3==YES)
                {
                    TF3 = NO;
                    self.shopID3TF.text = @"";
                    [self.shopID2TF becomeFirstResponder];
                }
                if (self.shopID1TF.text.length>=4&&self.shopID2TF.text.length==1&&TF1==YES&&TF2==YES)
                {
                    TF2 = NO;
                    self.shopID2TF.text = @"";
                    [self.shopID1TF becomeFirstResponder];
                }
            }
            return YES;
        }else{
            
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength > 4)
            {
                if (textField == self.shopID1TF)
                {
                    [self.shopID1TF resignFirstResponder];
                    [self.shopID2TF becomeFirstResponder];
                    TF1 = YES;
                    return YES;
                }
                if (textField == self.shopID2TF)
                {
                    [self.shopID2TF resignFirstResponder];
                    [self.shopID3TF becomeFirstResponder];
                    TF2 = YES;
                    return YES;
                }
                if (textField == self.shopID3TF)
                {
                    [self.shopID3TF resignFirstResponder];
                    [self.shopID4TF becomeFirstResponder];
                    TF3 = YES;
                    return YES;
                }
                if (textField == self.shopID4TF)
                {
                    TF4 = YES;
                    return NO;
                }
            }
            return YES;
        }
    }
    
}
- (IBAction)TouchGrade:(id)sender
{
    NSString * uid = [NSString stringWithFormat:@"%@%@%@%@",self.shopID1TF.text,self.shopID2TF.text,self.shopID3TF.text,self.shopID4TF.text];
    if (uid.length != 16)
    {
        [self showAlertViewForTitle:@"请输入正确的店ID" AndMessage:nil];
    }else{
        shareInfo = [ShareInfo shareInstance];
       self.shopid = shareInfo.userModel.userID;
        NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[self.shopid,uid] forKeys:@[@"uid",@"shopid"]];

        SBJsonWriter * json = [[SBJsonWriter alloc]init];
        NSString * jsonData = [json stringWithObject:data];
        NSString * link = [[NSString stringWithFormat:UpGrade,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在获取数据";
        [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
            
            NSMutableDictionary * response = [responseObject copy];
            [self UpData:response];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            });
            
        }];    }
}
- (void)UpData:(NSDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    if ([[dict objectForKey:@"status"]integerValue]==0)
    {
        [self showAlertViewForTitle:[dict objectForKey:@"text"] AndMessage:nil];
    }else{
        [self showAlertViewForTitle:@"升级成功" AndMessage:nil];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"升级成功"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
