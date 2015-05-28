//
//  RegisterViewController.m
//  Dome
//
//  Created by BTW on 14/12/25.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "RegisterViewController.h"
//发送短信验证码接口
#define sendSmsCode @"http://www.beautyway.cn/json/index.aspx?aim=sendmsg&number=%@&desc=欢迎使用都美,您的验证码是"


@interface RegisterViewController ()
<
    UITextFieldDelegate
>
{
    MBProgressHUD * HUD;
    UIColor * bthColor;
    NSString * smsCode;
    BOOL TF1;
    BOOL TF2;
    BOOL TF3;
    BOOL TF4;

}
@property (weak, nonatomic) IBOutlet UIImageView *BGView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *codeNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *passWord2TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID1TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID2TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID3TF;
@property (weak, nonatomic) IBOutlet UITextField *shopID4TF;
@property (weak, nonatomic) IBOutlet UIButton *codeBth;


@property(nonatomic)int times;
@property(nonatomic,weak)NSTimer * timer;
@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"注册";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (IBAction)TFExit:(UITextField *)sender {
    [sender resignFirstResponder];
}
#pragma mark 获取验证码
- (IBAction)GetCode:(UIButton*)sender
{
    
    
  
    
    
    
    NSString * phone = self.phoneNumberTF.text;

    BOOL isMobile =  [self isMobileNumber:phone];
    
    if (isMobile==NO)
    {
       
        [self showAlertViewForTitle:nil AndMessage:@"手机号码不正确"];
        
    }else{
        //  发送验证码短信：
        [self GetSmsCode];
//        [self GetSmsCode2];
        

    }
}
-(void)GetSmsCode
{
    
    
     NSString * phone = self.phoneNumberTF.text;
    
    
    [self.codeBth setBackgroundColor:[UIColor lightGrayColor]];
    self.codeBth.userInteractionEnabled = NO;

    
    
    
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBth setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.codeBth.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.codeBth setTitle:[NSString stringWithFormat:@"请等待%@秒",strTime] forState:UIControlStateNormal];
                self.codeBth.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(timer);
    
    
    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[phone] forKeys:@[@"phone"]];
    
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSLog(@"jsonData:%@",jsonData);
    NSString * link = [[NSString stringWithFormat:GetSmsCodel2,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",link);
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        [self UpCodeData:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];

}
- (void)UpCodeData:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    NSString * status =[dict objectForKey:@"status"];
    int statusInt = [status intValue];
    if (statusInt == true)
    {
        [self showAlertViewForTitle:@"发送成功" AndMessage:nil];
    }else{
        NSString * text = [dict objectForKey:@"text"];
        [self showAlertViewForTitle:text AndMessage:nil];
    }
    

}
#pragma mark ShowAlertView
-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.BGView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView.layer.shadowOpacity = 0.2;
    bthColor = self.codeBth.backgroundColor;
    // Do any additional setup after loading the view.
    
    self.shopID1TF.delegate = self;
    self.shopID2TF.delegate = self;
    self.shopID3TF.delegate = self;
    self.shopID4TF.delegate = self;
    self.phoneNumberTF.delegate = self;
    
    
//    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"50_phone1.png"]];
//    self.phoneNumberTF.leftView=image;
//    self.phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.shopID1TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID2TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID3TF.autocorrectionType=UITextAutocorrectionTypeNo;
    self.shopID4TF.autocorrectionType=UITextAutocorrectionTypeNo;
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
#pragma mark 注册
- (IBAction)TouchRegister:(UIButton *)sender
{
    
    
//    self.phoneNumberTF.text=@"13631432143";
//    self.passWordTF.text=@"123456";
//    self.passWord2TF.text=@"123456";
//    self.codeNumberTF.text=@"1111";
//    self.shopIDTF.text=@"54dac3d50006";
    
    
    if (self.codeNumberTF.text.length==0||self.phoneNumberTF.text.length==0||self.passWordTF.text.length==0||self.passWord2TF.text.length==0||self.shopID1TF.text.length==0||self.shopID2TF.text.length==0||self.shopID3TF.text.length==0||self.shopID4TF.text.length==0)
    {
        [self showAlertViewForTitle:@"注册信息不可为空" AndMessage:nil];
    }else{
        
        if (![self.passWordTF.text isEqualToString:self.passWord2TF.text])
        {
            [self showAlertViewForTitle:@"两次密码不相同" AndMessage:nil];
        }else{
            
          
            if (self.shopID1TF.text.length!=4||self.shopID2TF.text.length!=4||self.shopID3TF.text.length!=4||self.shopID4TF.text.length!=4) {
                [self showAlertViewForTitle:@"请输入正确的店ID" AndMessage:nil];
            }else{

                if(self.passWordTF.text.length<6||self.passWord2TF.text.length<6)
                {
                    [self showAlertViewForTitle:@"密码至少6位" AndMessage:nil];
                }else{
                
                NSString * phone = self.phoneNumberTF.text;
                NSString * password = self.passWordTF.text;
                NSString * code = self.codeNumberTF.text;
                NSString * shopid = [NSString stringWithFormat:@"%@-%@-%@-%@",self.shopID1TF.text,self.shopID2TF.text,self.shopID3TF.text,self.shopID4TF.text];
            

                NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[phone,password,code,shopid] forKeys:@[@"phone",@"password",@"code",@"shopid"]];

                SBJsonWriter * json = [[SBJsonWriter alloc]init];
                NSString * jsonData = [json stringWithObject:data];
                NSLog(@"jsonData:%@",jsonData);
                NSString * link = [[NSString stringWithFormat:Register,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
                    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    HUD.labelText = @"正在获取数据";
                    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
                        
                        NSMutableDictionary * response = [responseObject copy];
                        [self UpRegisterData:response];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                        });
                        
                    }];
                }
                
            }
            
        }
        
    }
}
-(void)UpRegisterData:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    NSString * status = [dict objectForKey:@"status"];
    NSString * text = [dict objectForKey:@"text"];
    NSLog(@"status:%@",status);
    NSLog(@"text:%@",text);
    
    int isStatus = [status intValue];
    if (isStatus == 0) {
        [self showAlertViewForTitle:text AndMessage:nil];
     
    }else{
        UIAlertView * av =[[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        av.tag = 999;
        [av show];
        
      
    }
}
- (void)stop
{
    self.codeBth.userInteractionEnabled = YES;
    [self.codeBth setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBth setBackgroundColor:bthColor];
    [self.timer invalidate];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self stop];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  判断手机号码格式是否合法
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     2015－4-30  新增 176,177,178
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|7[678]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,181,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[1278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大录地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }else
    {
        return NO;
    }
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
