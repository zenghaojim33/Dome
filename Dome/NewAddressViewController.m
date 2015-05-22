//
//  NewAddressViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "NewAddressViewController.h"

@interface NewAddressViewController ()
<
    UITextFieldDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>
{
    //省、市、县
    NSMutableArray *provinces, *cities, *areas;
    
    NSString *provincesString,*citiesString,*areasString;
    
    int touchPickInt;

}
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property(nonatomic,strong)UITextField * UserNameTF;
@property(nonatomic,strong)UITextField * ProvinceTF;
@property(nonatomic,strong)UITextField * CityTF;
@property(nonatomic,strong)UITextField * AreaTF;
@property(nonatomic,strong)UITextField * AddressTF;
@property(nonatomic,strong)UITextField * PostCodeTF;
@property(nonatomic,strong)UITextField * PhoneTF;
@property(nonatomic,strong)UITextField * TelePhoneTF;

//TableView
@property(nonatomic,strong)UITableView * ProvinceTableView;
@property(nonatomic,strong)UITableView * CityTableView;
@property(nonatomic,strong)UITableView * AreaTableView;
@end

@implementation NewAddressViewController
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if(textField.tag == 1||textField.tag == 2||textField.tag == 3)
    {
        [textField resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self AllTextFieldExit];
    return YES;
}
- (void)AllTextFieldExit
{
    [self.UserNameTF resignFirstResponder];
    [self.ProvinceTF resignFirstResponder];
    [self.CityTF resignFirstResponder];
    [self.AreaTF resignFirstResponder];
    [self.AddressTF resignFirstResponder];
    [self.PostCodeTF resignFirstResponder];
    [self.PhoneTF resignFirstResponder];
    [self.TelePhoneTF resignFirstResponder];
}
- (IBAction)TouchView:(id)sender
{
    [self AllTextFieldExit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.BGView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView.layer.shadowOpacity = 0.2;
    
    /******************************************************************/
    
    UIImageView * BGImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BGView.jpg"]];
    BGImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.BGView.frame.size.height);
    [self.BGView addSubview:BGImage];
    
    /******************************************************************/
    
    CGRect frame = CGRectMake(16, 8, self.view.frame.size.width-32, 30);
    
    self.UserNameTF = [[UITextField alloc]initWithFrame:frame];
    self.UserNameTF.placeholder = @"收货人";
    self.UserNameTF.clearButtonMode = UITextFieldViewModeAlways;
    self.UserNameTF.borderStyle = UITextBorderStyleBezel;
    self.UserNameTF.returnKeyType = UIReturnKeyDone;
    self.UserNameTF.delegate = self;
    self.UserNameTF.tag = 0;
    [self.BGView addSubview:self.UserNameTF];
    
    /******************************************************************/
    
    frame.origin.y+=40;
    frame.size.width = (self.view.frame.size.width-32)/3-10;
    
    /******************************************************************/
    
    self.ProvinceTF = [[UITextField alloc]initWithFrame:frame];
    self.ProvinceTF.placeholder = @"省";
    self.ProvinceTF.borderStyle = UITextBorderStyleBezel;
//    self.ProvinceTF.userInteractionEnabled = NO;
    self.ProvinceTF.returnKeyType = UIReturnKeyDone;
    self.ProvinceTF.delegate = self;
    self.ProvinceTF.tag = 1;
    [self.BGView addSubview:self.ProvinceTF];
    
    UIButton * pickButton1 = [[UIButton alloc]initWithFrame:CGRectMake(self.ProvinceTF.frame.size.width-30, 2, 26, 26)];
    [pickButton1 setBackgroundImage:[UIImage imageNamed:@"PickerBGView.jpg"] forState:UIControlStateNormal];
    [pickButton1 addTarget:self action:@selector(TouchPickButton:) forControlEvents:UIControlEventTouchUpInside];
    pickButton1.tag = 1;
    [self.ProvinceTF addSubview:pickButton1];
    
    /******************************************************************/

    frame.origin.x += (self.view.frame.size.width-32)/3*1+5;
    
    /******************************************************************/
    
    self.CityTF = [[UITextField alloc]initWithFrame:frame];
    self.CityTF.placeholder = @"市";
    self.CityTF.borderStyle = UITextBorderStyleBezel;
//    self.CityTF.userInteractionEnabled = NO;
    self.CityTF.returnKeyType = UIReturnKeyDone;
    self.CityTF.delegate = self;
    self.CityTF.tag = 2;
    [self.BGView addSubview:self.CityTF];
    
    UIButton * pickButton2 = [[UIButton alloc]initWithFrame:CGRectMake(self.CityTF.frame.size.width-30, 2, 26, 26)];
    [pickButton2 setBackgroundImage:[UIImage imageNamed:@"PickerBGView.jpg"] forState:UIControlStateNormal];
    [pickButton2 addTarget:self action:@selector(TouchPickButton:) forControlEvents:UIControlEventTouchUpInside];
    pickButton2.tag = 2;
    [self.CityTF addSubview:pickButton2];
    
    /******************************************************************/

    frame.origin.x += (self.view.frame.size.width-32)/3*1+5;
    
    /******************************************************************/
    
    self.AreaTF = [[UITextField alloc]initWithFrame:frame];
    self.AreaTF.placeholder = @"区";
    self.AreaTF.borderStyle = UITextBorderStyleBezel;
//    self.AreaTF.userInteractionEnabled = NO;
    self.AreaTF.returnKeyType = UIReturnKeyDone;
    self.AreaTF.delegate = self;
    self.AreaTF.tag = 3;
    [self.BGView addSubview:self.AreaTF];
    
    UIButton * pickButton3 = [[UIButton alloc]initWithFrame:CGRectMake(self.AreaTF.frame.size.width-30, 2, 26, 26)];
    [pickButton3 setBackgroundImage:[UIImage imageNamed:@"PickerBGView.jpg"] forState:UIControlStateNormal];
    [pickButton3 addTarget:self action:@selector(TouchPickButton:) forControlEvents:UIControlEventTouchUpInside];
    pickButton3.tag = 3;
    [self.AreaTF addSubview:pickButton3];
    
    /******************************************************************/
    
    frame.origin.x = 16;
    frame.origin.y += 40;
    frame.size.width = self.view.frame.size.width-32;
    
    /******************************************************************/
    
    self.AddressTF = [[UITextField alloc]initWithFrame:frame];
    self.AddressTF.placeholder = @"详细地址";
    self.AddressTF.clearButtonMode = UITextFieldViewModeAlways;
    self.AddressTF.borderStyle = UITextBorderStyleBezel;
    self.AddressTF.returnKeyType = UIReturnKeyDone;
    self.AddressTF.delegate = self;
    self.AddressTF.tag = 4;
    [self.BGView addSubview:self.AddressTF];
    
    /******************************************************************/
    
    frame.origin.y+=40;
    
    /******************************************************************/
    
    self.PostCodeTF = [[UITextField alloc]initWithFrame:frame];
    self.PostCodeTF.placeholder = @"邮编";
    self.PostCodeTF.clearButtonMode = UITextFieldViewModeAlways;
    self.PostCodeTF.borderStyle = UITextBorderStyleBezel;
    self.PostCodeTF.returnKeyType = UIReturnKeyDone;
    self.PostCodeTF.delegate = self;
    self.PostCodeTF.tag = 5;
    [self.BGView addSubview:self.PostCodeTF];
    
    /******************************************************************/
    
    frame.origin.y+=40;
    
    /******************************************************************/
    
    self.PhoneTF = [[UITextField alloc]initWithFrame:frame];
    self.PhoneTF.placeholder = @"移动电话";
    self.PhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.PhoneTF.borderStyle = UITextBorderStyleBezel;
    self.PhoneTF.returnKeyType = UIReturnKeyDone;
    self.PhoneTF.delegate = self;
    self.PhoneTF.tag = 6;
    [self.BGView addSubview:self.PhoneTF];
    
    /******************************************************************/
    
    frame.origin.y+=40;
    
    /******************************************************************/
    
    self.TelePhoneTF = [[UITextField alloc]initWithFrame:frame];
    self.TelePhoneTF.placeholder = @"固定电话";
    self.TelePhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    self.TelePhoneTF.borderStyle = UITextBorderStyleBezel;
    self.TelePhoneTF.returnKeyType = UIReturnKeyDone;
    self.TelePhoneTF.delegate = self;
    self.TelePhoneTF.tag = 7;
    [self.BGView addSubview:self.TelePhoneTF];
    
    /******************************************************************/
    
    frame.origin.y+=40;
    frame.size.height = 30;
    
    /******************************************************************/
    
    UIButton * DoneButton = [[UIButton alloc]initWithFrame:frame];
    [DoneButton setTitle:@"确定" forState:UIControlStateNormal];
    [DoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [DoneButton setBackgroundImage:[UIImage imageNamed:@"ButtonBGView.jpg"] forState:UIControlStateNormal];
    [DoneButton addTarget:self action:@selector(TouchDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.BGView addSubview:DoneButton];
    
    /******************************************************************/
    
    if (self.isChange == YES) {
        self.title = @"修改地址";
        self.UserNameTF.text = @"Jenk";
        self.ProvinceTF.text = @"广东省";
        self.CityTF.text = @"广州市";
        self.AreaTF.text = @"越秀区";
        self.AddressTF.text = @"芳村码头xxxxx";
        self.PostCodeTF.text = @"518000";
        self.PhoneTF.text = @"134502243061";
        self.TelePhoneTF.text = @"020-86374739";
    }else{
        self.title = @"添加地址";
    }
    
    
    provinces = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
    
}
- (void)TouchDoneButton:(UIButton*)button
{
    [self AllTextFieldExit];
    
    
    
    if (
        self.UserNameTF.text.length == 0||
        self.ProvinceTF.text.length == 0||
        self.CityTF.text.length == 0||
        self.AreaTF.text.length == 0||
        self.AddressTF.text.length == 0||
        self.PostCodeTF.text.length == 0||
        self.PhoneTF.text.length == 0||
        self.TelePhoneTF.text.length == 0
        ){
        
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"信息不可为空" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [av show];
        
    }else{
    
        BOOL number = [self isMobileNumber:self.PhoneTF.text];
        
        if (number == false) {
            
            UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"手机号码格式不合法" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [av show];
            
        }else{
            
            NSString * TitleString;
            if (self.isChange==true)
            {
                TitleString = @"修改成功";
            }else{
                TitleString = @"新增成功";
            }
            UIAlertView * av = [[UIAlertView alloc]initWithTitle:TitleString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            av.tag= 888;
            [av show];
            
        }

    }
    
       
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==888) {
        [self.navigationController popViewControllerAnimated:YES];
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
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
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
    
    if (([regextestmobile evaluateWithObject:mobileNum] == true)
        || ([regextestcm evaluateWithObject:mobileNum] == true)
        || ([regextestct evaluateWithObject:mobileNum] == true)
        || ([regextestcu evaluateWithObject:mobileNum] == true))
    {
        return true;
    }else
    {
        return false;
    }
}
-(void)TouchPickButton:(UIButton*)pickButton
{
    [self AllTextFieldExit];
    NSLog(@"pickButton.tag -> %ld",(long)pickButton.tag);
    
    [self.ProvinceTableView removeFromSuperview];
    [self.CityTableView removeFromSuperview];
    [self.AreaTableView removeFromSuperview];
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });

    CGRect frame = pickButton.superview.frame;
    if (pickButton.tag==1) {
        

        self.ProvinceTableView= [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x,frame.origin.y+30,frame.size.width,180)];

        self.ProvinceTableView.delegate = self;
        self.ProvinceTableView.dataSource = self;
        [self.ProvinceTableView.layer setMasksToBounds:YES];
        [self.ProvinceTableView.layer setBorderWidth:1.0];
        [self.ProvinceTableView.layer setBorderColor:colorref];
        self.ProvinceTableView.tableFooterView = [[UIView alloc] init];
        touchPickInt = 0;
        [self.view addSubview:self.ProvinceTableView];
    }else if (pickButton.tag==2){

 
        self.CityTableView = [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x,frame.origin.y+30,frame.size.width,180)];
        self.CityTableView.delegate = self;
        self.CityTableView.dataSource = self;
        [self.CityTableView.layer setMasksToBounds:YES];
        [self.CityTableView.layer setBorderWidth:1.0];
        [self.CityTableView.layer setBorderColor:colorref];
        self.CityTableView.tableFooterView = [[UIView alloc] init];
        touchPickInt = 1;
        [self.view addSubview:self.CityTableView];

    }else{
    
        self.AreaTableView= [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x,frame.origin.y+30,frame.size.width,180)];
        self.AreaTableView.delegate = self;
        self.AreaTableView.dataSource = self;
        [self.AreaTableView.layer setMasksToBounds:YES];
        [self.AreaTableView.layer setBorderWidth:1.0];
        [self.AreaTableView.layer setBorderColor:colorref];
        self.AreaTableView.tableFooterView = [[UIView alloc] init];
        touchPickInt = 2;
        [self.view addSubview: self.AreaTableView];
    }

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (touchPickInt==0)
    {
        return provinces.count;
    }else if (touchPickInt==1){
        return cities.count;
    }else{
        return areas.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (touchPickInt==0)
    {
        cell.textLabel.text = [[provinces objectAtIndex:indexPath.row] objectForKey:@"state"];
    }else if (touchPickInt==1){
        cell.textLabel.text = [[cities objectAtIndex:indexPath.row] objectForKey:@"state"];
    }else if(touchPickInt==2){
        cell.textLabel.text = [areas objectAtIndex:indexPath.row];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self AllTextFieldExit];
    if (touchPickInt==0)
    {
        provincesString = [[provinces objectAtIndex:indexPath.row] objectForKey:@"state"];
        self.ProvinceTF.text = provincesString;
        cities = [[provinces objectAtIndex:indexPath.row] objectForKey:@"cities"];
        areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
        areasString = [areas objectAtIndex:0];
        citiesString = [[cities objectAtIndex:0] objectForKey:@"state"];
        self.CityTF.text = citiesString;
        self.AreaTF.text =areasString;
        
        
    }else if(touchPickInt==1){
        citiesString = [[cities objectAtIndex:indexPath.row] objectForKey:@"state"];
        self.CityTF.text = citiesString;
        areas = [[cities objectAtIndex:indexPath.row] objectForKey:@"areas"];
        
        self.AreaTF.text = [areas objectAtIndex:0];
    }else if(touchPickInt==2){
        areasString = [areas objectAtIndex:indexPath.row];
        self.AreaTF.text =areasString;
        
    }
    [tableView removeFromSuperview];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
