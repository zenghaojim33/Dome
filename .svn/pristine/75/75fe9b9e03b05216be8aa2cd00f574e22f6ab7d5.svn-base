//
//  OrderManagementViewController.m
//  Dome
//
//  Created by BTW on 15/4/22.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "CommodityTableViewCell.h"
#import "JenkButton.h"
#import "BWMLineChartView.h"

@interface OrderManagementViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    BWMLineChartViewDelegate
>
{
    long int index;
    ShareInfo * shareInfo;
    MBProgressHUD * HUD;
}
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth1;
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth2;
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth3;
@property (strong, nonatomic) IBOutlet UIView *chartView;
@property (strong, nonatomic) BWMLineChartView * lineChartView;
@property (strong, nonatomic) IBOutlet UITableView *MyTableView;
@property(nonatomic,strong) NSMutableArray *dateArray;
@property (strong, nonatomic) IBOutlet UIView *BGView;

@end

@implementation OrderManagementViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"销售管理";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)TouchButton:(JenkButton *)sender
{
    
    if (index != sender.tag+1)
    {

    if (sender.tag==0)
        {
        
            [self changeButton:self.JenkBth1 ForIsSelect:YES];
            [self changeButton:self.JenkBth2 ForIsSelect:NO];
            [self changeButton:self.JenkBth3 ForIsSelect:NO];

        
            [self.JenkBth1 setButtinImage:[UIImage imageNamed:@"50_plan2.png"] ButtonTitle:@"每日订单" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth2 setButtinImage:[UIImage imageNamed:@"50_sale1.png"] ButtonTitle:@"成交金额" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth3 setButtinImage:[UIImage imageNamed:@"50_female1.png"] ButtonTitle:@"每日访客" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
        
        }else if (sender.tag==1){
        
        
            [self changeButton:self.JenkBth1 ForIsSelect:NO];
            [self changeButton:self.JenkBth2 ForIsSelect:YES];
            [self changeButton:self.JenkBth3 ForIsSelect:NO];
        
        
            [self.JenkBth1 setButtinImage:[UIImage imageNamed:@"50_plan1.png"] ButtonTitle:@"每日订单" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth2 setButtinImage:[UIImage imageNamed:@"50_sale2.png"] ButtonTitle:@"成交金额" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth3 setButtinImage:[UIImage imageNamed:@"50_female1.png"] ButtonTitle:@"每日访客" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
        }else if(sender.tag==2){
        
        
            [self changeButton:self.JenkBth1 ForIsSelect:NO];
            [self changeButton:self.JenkBth2 ForIsSelect:NO];
            [self changeButton:self.JenkBth3 ForIsSelect:YES];
        
        
            [self.JenkBth1 setButtinImage:[UIImage imageNamed:@"50_plan1.png"] ButtonTitle:@"每日订单" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth2 setButtinImage:[UIImage imageNamed:@"50_sale1.png"] ButtonTitle:@"成交金额" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth3 setButtinImage:[UIImage imageNamed:@"50_female2.png"] ButtonTitle:@"每日访客" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
        }
        index = sender.tag+1;
         [self UpData];
        [self InItLineChart];
        [self.MyTableView reloadData];

        
        
    }
   
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = [NSMutableArray array];
    shareInfo = [ShareInfo shareInstance];
    for (int i = 0; i<31; i++)
    {
        NSDate * date= [NSDate new];
        NSTimeInterval secondsPerDay1 = i*(24*60*60);
        NSDate *newDay = [date addTimeInterval:-secondsPerDay1];
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString* dateString = [fmt stringFromDate:newDay];
        NSLog(@"selectedDate:%@", dateString);
        [self.dateArray addObject:dateString];
    }
    
    
   
    [self.JenkBth1 setButtinImage:[UIImage imageNamed:@"50_plan2.png"] ButtonTitle:@"每日订单" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
    [self.JenkBth1 setBackgroundColor:[UIColor redColor]];
    self.JenkBth1.tag = 0;
    [self.JenkBth1 addTarget:self action:@selector(TouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self changeButton:self.JenkBth1 ForIsSelect:YES];

    
    
    [self.JenkBth2 setButtinImage:[UIImage imageNamed:@"50_sale1.png"] ButtonTitle:@"成交金额" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
    [self.JenkBth2 setBackgroundColor:[UIColor whiteColor]];
    self.JenkBth2.tag = 1;
    [self.JenkBth2 addTarget:self action:@selector(TouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self changeButton:self.JenkBth2 ForIsSelect:NO];

    
  
    [self.JenkBth3 setButtinImage:[UIImage imageNamed:@"50_female1.png"] ButtonTitle:@"每日访客" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
    [self.JenkBth3 setBackgroundColor:[UIColor whiteColor]];
    self.JenkBth3.tag = 2;
    [self.JenkBth3 addTarget:self action:@selector(TouchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self changeButton:self.JenkBth3 ForIsSelect:NO];
    
    
    
    index = 1;
    
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
//    self.MyTableView.tableFooterView = [[UIView alloc]init];
//    self.MyTableView.tableHeaderView = [[UIView alloc]init];
    [self.MyTableView registerNib:[UINib nibWithNibName:@"CommodityTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.MyTableView reloadData];
    [self InItLineChart];
    // Do any additional setup after loading the view.
 
    [self UpData];
}
- (NSString*)getTaday
{
    NSDate * date= [NSDate new];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:date];
    return dateString;
}
- (NSString*)getEnd
{
    NSDate * date= [NSDate new];
    NSTimeInterval secondsPerDay1 = 31*(24*60*60);
    NSDate *newDay = [date addTimeInterval:-secondsPerDay1];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:newDay];
    return dateString;
}
- (void)UpData
{
    NSString * shopId = shareInfo.userModel.shopid;
    NSNumber * number = [NSNumber numberWithInt:1];
    NSNumber * pagesize = [NSNumber numberWithInt:50];
    
    NSString * begin = [self getTaday];
    NSString * end = [self getEnd];
    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,number,pagesize,begin,end,@"1"] forKeys:@[@"shopid",@"page",@"pagesize",@"begin",@"end",@"status"]];
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSString * link = [NSString stringWithFormat:@"http://app.dome123.com/Handler.ashx?Action=GetShopOrderList&data=%@",jsonData];
    [self dataRequest:link SucceedSelector:@selector(UpGuestData:)];

}
-(void)UpGuestData:(NSMutableDictionary*)dict
{
    NSLog(@"dict::::::%@",dict);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 31;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell" ;
    
    
    CommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString * date = [self.dateArray objectAtIndex:indexPath.row];
    cell.date.text = [NSString stringWithFormat:@"%@",date];
    
    
    switch (index) {
        case 1:
            cell.number.text = [NSString stringWithFormat:@"%d",0];
            break;
        case 2:
            cell.number.text = [NSString stringWithFormat:@"%d",0];
            break;
        default:
            cell.number.text = [NSString stringWithFormat:@"%d",0];
            break;
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}


-(void)changeButton:(JenkButton*)button ForIsSelect:(BOOL)isSelect
{
    if (isSelect==YES)
    {
        button.backgroundColor = [UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1];
        
        button.ButtonTitleLabel.textColor = [UIColor whiteColor];
        button.TodayTitleLabel.textColor = [UIColor whiteColor];
        button.TodayNumberLabel.textColor = [UIColor whiteColor];
        
        button.YesterDayTitleLabel.textColor = [UIColor whiteColor];
        button.YesterDayNumberLabel.textColor = [UIColor whiteColor];
    }else{
        button.backgroundColor = [UIColor whiteColor];
        
        button.ButtonTitleLabel.textColor = [UIColor darkGrayColor];
        button.TodayTitleLabel.textColor = [UIColor darkGrayColor];
        button.TodayNumberLabel.textColor = [UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1];
        
        button.YesterDayTitleLabel.textColor = [UIColor darkGrayColor];
        button.YesterDayNumberLabel.textColor = [UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1];
        
    }
}
- (void)InItLineChart
{
    [self.lineChartView removeFromSuperview];
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
    {
        NSString * date = [self.dateArray objectAtIndex:30-(i*3)];
        date= [date substringFromIndex:5];
        [xVals addObject:date];
    }
    
    for (int y = 0; y< 10; y++)
    {
         [yVals addObject:[@(0) stringValue]];
    }
    
    self.lineChartView = [[BWMLineChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-32, self.chartView.frame.size.height) color:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] hasFloat:YES delegate:self];
    self.lineChartView.userInteractionEnabled = NO;
    NSString * title;
    if (index == 1)
    {
        title = @"每日订单";
    }else if (index == 2)
    {
        title = @"成交金额";
    }else
    {
        title = @"每日访客";
    }
    [self.lineChartView updateWithTitle:title XVals:xVals YVals:yVals];
    
    [self.chartView addSubview:self.lineChartView];
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
- (void)dataRequest:(NSString *)url SucceedSelector:(SEL)selector{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        id jsonObject = [JSONData JSONDataValue:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *message = nil;
            if(jsonObject==nil)
            {
                
                message = @"获取数据失败请检查你的网络";
                [self showAlertViewForTitle:message AndMessage:nil];
            }
            else
            {
                
                [self performSelector:selector withObject:jsonObject afterDelay:0.2f];
                
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    });
    
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
