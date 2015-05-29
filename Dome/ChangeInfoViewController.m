//
//  ChangeInfoViewController.m
//  DoShop
//
//  Created by Anson on 15/4/21.
//  Copyright (c) 2015年 Anson Tsang. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "BankViewController.h"
#import "CNCityPickerView.h"
#import "RegExpValidate.h"
#import "UIAlertView+Blocks.h"
#import "ShareInfo.h"

@interface ChangeInfoViewController()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,BankDelegate>


@property (weak, nonatomic) IBOutlet UITextField *myNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *myDetailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *myEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *myAccountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myBankTextField;
@property (weak, nonatomic) IBOutlet UITextField *myBankNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectBankBtn;

@property (weak, nonatomic) IBOutlet UITextField *certificateTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopInfoTextField;


@end


@implementation ChangeInfoViewController{
    ShareInfo * _userInfoModel;
    NSString * _province;
    NSString * _city;
    NSString * _county;
    UIImage * selectedImage;
    MBProgressHUD * HUD;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
}


-(void)viewDidLoad{
    
    
    
    

    _userInfoModel = [ShareInfo shareInstance];
    CNCityPickerView * picker = [[CNCityPickerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    [picker setValueChangedCallback:^(NSString *province, NSString *city, NSString *area) {
        
        _province = province;
        _city = city;
        _county = area;
        self.myAddressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
        
    }];
    self.myAddressTextField.inputView = picker;
    picker.editingTextField = self.myAddressTextField;
    
    
    [self loadUserInfo];
    
    
}


#pragma mark ---load user info


-(void)loadUserInfo
{
    
    NSString * userid = _userInfoModel.userModel.userID;
    

    
    
    NSDictionary * postDict = @{@"id":userid};
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString *jsonData = [json stringWithObject:postDict];
    NSString * link = [[NSString stringWithFormat:@"http://app.dome123.com/Handler.ashx?Action=GetInfo&data=%@",jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(NSDictionary *dict, NSError *error) {
        NSMutableDictionary * response = [NSMutableDictionary dictionaryWithDictionary:dict];
        [self updateInfoData:response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];
    
    
}












-(void)updateInfoData:(NSDictionary *)dict{
    
    NSDictionary * info = dict[@"info"];
    _province = info[@"provinces"];
    _county = info[@"area"];
    _city = info[@"city"];
    self.myAddressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",_province,_city,_county];
    self.myDetailAddressTextField.text = info[@"address"];
    self.myEmailTextField.text = info[@"email"];
    self.myAccountNameTextField.text =info[@"acountname"];
    self.myBankTextField.text = info[@"bank"];
    self.myBankNumTextField.text = info[@"bankno"];
    self.myNameTextField.text = info[@"shopname"];
    self.certificateTextField.text = info[@"certificate"];
    self.shopInfoTextField.text = info[@"shopinfo"];

}


#pragma mark --点击头像




#pragma mark -- 确定
- (IBAction)confirmBtnClicked:(id)sender {
    if (![RegExpValidate validateBankAccountNumber:self.myBankNumTextField.text])
    {
        [UIAlertView showWithTitle:@"请输入正确的银行卡号"];
        return;
    }else if (![self noEmptyTextField]){
        [UIAlertView showWithTitle:@"请输入完整的个人信息"];
        return ;
    }
    
    
    NSString * userid = _userInfoModel.userModel.userID;
    
//                NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[userID,province,city,area,address,email,acountname,bank,bankno,certificate,shopname,shopinfo] forKeys:@[@"id",@"provinces",@"city",@"area",@"address",@"email",@"acountname",@"bank",@"bankno",@"certificate",@"shopname",@"shopinfo"]];
    
    NSDictionary * postDict = @{@"id":userid,
                                @"provinces":_province,
                                @"area":_county,
                                @"city":_city,
                                @"address":self.myDetailAddressTextField.text,
                                @"email":self.myEmailTextField.text,
                                @"acountname":self.myAccountNameTextField.text,
                                @"bank":self.myBankTextField.text,
                                @"bankno":self.myBankNumTextField.text,
                                @"certificate":self.certificateTextField.text,
                                @"shopname":self.myNameTextField.text,
                                @"shopinfo":self.shopInfoTextField.text
                                };
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:postDict];

    
    NSString * link = [[NSString stringWithFormat:ChangeInfo,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(NSDictionary *dict, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dict[@"status"] isEqualToNumber:@1])
            {
                [UIAlertView showWithTitle:@"修改成功"];
            }else{
                [UIAlertView showWithTitle:@"修改失败"];
            }
        });
        
    }];
    
}


- (IBAction)selectBank:(id)sender {
    
    BankViewController * bankVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BankViewController"];
    bankVC.delegate =self;
    [self.navigationController pushViewController:bankVC animated:YES];
}






-(BOOL)noEmptyTextField
{
    return self.myDetailAddressTextField.text.length>0 && self.myEmailTextField.text.length>0 && self.myAccountNameTextField.text.length > 0 && self.myBankNumTextField.text.length > 0 && self.myNameTextField.text.length > 0 && self.myBankTextField.text.length > 0;
}



-(void)setBankName:(NSString *)bankName
{
    self.myBankTextField.text = bankName;
}

@end
