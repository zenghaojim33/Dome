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
#import "OrderModel.h"
#import "OrderManageModel.h"
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
    BOOL isOrder;
}
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth1;
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth2;
@property (weak, nonatomic) IBOutlet JenkButton *JenkBth3;
@property (strong, nonatomic) IBOutlet UIView *chartView;
@property (strong, nonatomic) BWMLineChartView * lineChartView;
@property (strong, nonatomic) IBOutlet UITableView *MyTableView;
@property(nonatomic,strong) NSMutableArray *dateArray;

@property (strong, nonatomic) NSMutableArray *AllOrders;
@property (strong, nonatomic) NSMutableArray * Orders;

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
        
            isOrder = YES;
            [self changeButton:self.JenkBth1 ForIsSelect:YES];
            [self changeButton:self.JenkBth2 ForIsSelect:NO];
            [self changeButton:self.JenkBth3 ForIsSelect:NO];

        
            [self.JenkBth1 setButtinImage:[UIImage imageNamed:@"50_plan2.png"] ButtonTitle:@"每日订单" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth2 setButtinImage:[UIImage imageNamed:@"50_sale1.png"] ButtonTitle:@"成交金额" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
            [self.JenkBth3 setButtinImage:[UIImage imageNamed:@"50_female1.png"] ButtonTitle:@"每日访客" TodayTitle:nil TodayNumber:@"0" YesterDayTitleLabel:nil YesterDayNumberLabel:@"0"];
        
        }else if (sender.tag==1){
        
            isOrder = NO;
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
//        [self InItLineChart];
        [self.MyTableView reloadData];

        
        
    }
   
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateArray = [NSMutableArray array];
    isOrder = YES;
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
//    [self InItLineChart];
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
    if (index == 3)
    {
        //暂时没有访客接口
        //做假数据
        
        self.Orders = [NSMutableArray array];
        for (int i = 0; i<self.dateArray.count; i++)
        {
            OrderManageModel * model = [[OrderManageModel alloc]init];
            model.date = [self.dateArray objectAtIndex:i];
            long int count = arc4random() % 30;
            model.count = [NSString stringWithFormat:@"%ld",count];
            [self.Orders addObject:model];
        }
        
        [self InItLineChart];
    }else{
    
        NSString * shopId = shareInfo.userModel.shopid;
        NSNumber * number = [NSNumber numberWithInt:1];
        NSNumber * pagesize = [NSNumber numberWithInt:2000000];
    
        NSString * begin = [self getTaday];
        NSString * end = [self getEnd];
        NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,number,pagesize,end,begin] forKeys:@[@"shopid",@"page",@"pagesize",@"begin",@"end"]];
        SBJsonWriter * json = [[SBJsonWriter alloc]init];
        NSString * jsonData = [json stringWithObject:data];
        NSString * link = [[NSString stringWithFormat:@"http://app.dome123.com/Handler.ashx?Action=GetShopOrderList&data=%@",jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"url:%@",link);
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在获取数据";
        [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
            
            NSMutableDictionary * response = [responseObject copy];
            [self UpGuestData:response];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            });
            
        }];    }

}
-(void)UpGuestData:(NSMutableDictionary*)dict
{
    if ([[dict objectForKey:@"status"]integerValue] == true)
    {
        self.AllOrders = [NSMutableArray array];
        NSArray * data = [dict objectForKey:@"data"];
        for (NSDictionary * dic in data)
        {
            OrderModel * model = [[OrderModel alloc]init];
            model.suborderid = [dic objectForKey:@"suborderid"];
            model.productid = [dic objectForKey:@"productid"];
            model.count = [dic objectForKey:@"count"];
            model.price = [dic objectForKey:@"price"];
            model.picture = [dic objectForKey:@"picture"];
            model.status = [dic objectForKey:@"status"];
            model.name = [dic objectForKey:@"name"];
            model.createtime = [dic objectForKey:@"createtime"];
            [self.AllOrders addObject:model];
        }

        if (index == 1)
        {
            [self ChangeOrder];
        }else if (index == 2)
        {
            [self ChangePrice];
        }
        
        
        
    }else{
        [self showAlertViewForTitle:[dict objectForKey:@"text"] AndMessage:nil];
    }
    
}
- (void)ChangeOrder
{
    //遍历日期
    self.Orders = [NSMutableArray array];
    for (int i = 0; i<self.dateArray.count; i++)
    {
        OrderManageModel * mangeModel = [[OrderManageModel alloc]init];
        //获取日期
        NSString * dateString = [self.dateArray objectAtIndex:i];
        mangeModel.date = dateString;
        long int count = 0;
        for (OrderModel * model in self.AllOrders)
        {
            NSString * createtime = model.createtime;//2015-05-17 12:18
            //截取
            createtime = [createtime substringWithRange:NSMakeRange(0, 10)];
            NSLog(@"%@ --- %@",dateString,createtime);
            if ([dateString isEqualToString:createtime])
            {
                NSLog(@"同一天:%@ --- %@",dateString,createtime);
                count += 1;
            }
        }
        
        mangeModel.count = [NSString stringWithFormat:@"%ld",count];
        [self.Orders addObject:mangeModel];
    }
    [self InItLineChart];
}
- (void)ChangePrice
{
    //遍历日期
    self.Orders = [NSMutableArray array];
    for (int i = 0; i<self.dateArray.count; i++)
    {
        OrderManageModel * mangeModel = [[OrderManageModel alloc]init];
        //获取日期
        NSString * dateString = [self.dateArray objectAtIndex:i];
        mangeModel.date = dateString;
        float count = 0.00;
        for (OrderModel * model in self.AllOrders)
        {
            NSString * createtime = model.createtime;//2015-05-17 12:18
            //截取
            createtime = [createtime substringWithRange:NSMakeRange(0, 10)];
            if ([dateString isEqualToString:createtime])
            {
                NSLog(@"同一天:%@ --- %@",dateString,createtime);
                NSLog(@"price:%@",model.price);
                float price = [model.price floatValue];
                count += price;
            }
        }
        
        mangeModel.count = [NSString stringWithFormat:@"%.2f",count];
        [self.Orders addObject:mangeModel];
    }
    [self InItLineChart];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.Orders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell" ;
    
    CommodityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

//    NSString * date = [self.dateArray objectAtIndex:indexPath.row];
    OrderManageModel * manage = [self.Orders objectAtIndex:indexPath.row];
    cell.date.text = manage.date;
    
    switch (index) {
        case 1:
            cell.number.text = [NSString stringWithFormat:@"%@",manage.count];
            break;
        case 2:
            cell.number.text = [NSString stringWithFormat:@"%@",manage.count];
            break;
        default:
            cell.number.text = [NSString stringWithFormat:@"%@",manage.count];
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
        OrderManageModel * manage = [self.Orders objectAtIndex:i];
        [xVals addObject:[manage.date substringWithRange:NSMakeRange(5, 5)]];
    }
    
    for (int y = 0; y< 10; y++)
    {
        OrderManageModel * manage = [self.Orders objectAtIndex:y];
         [yVals addObject:manage.count];
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
    
    [self.MyTableView reloadData];
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
