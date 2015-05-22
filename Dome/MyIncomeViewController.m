//
//  MyIncomeViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "MyIncomeViewController.h"
#import "ChangInfoViewController.h"
#import "myIncomTableViewCell.h"
#import "OrderModel.h"
#import "IncomeModel.h"
#define pagesize 25
@interface MyIncomeViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    MJRefreshBaseViewDelegate
>
{
    UIButton * button1;
    UIButton * button2;
    UIButton * button3;
    UIButton * button4;
    
    int status; // == 0  收入详情。  == 1 提现详情。
    
    ShareInfo * shareInfo;
    MBProgressHUD * HUD;
    
    long int page;
    
    MJRefreshFooterView *_footer;
    
}
@property (weak, nonatomic) IBOutlet UIView *BGView1;
@property (weak, nonatomic) IBOutlet UIView *BGView2;
@property (weak, nonatomic) IBOutlet UIView *BGView3;
@property (weak, nonatomic) IBOutlet UIView *BGView4;
@property (weak, nonatomic) IBOutlet UIView *buttonBGView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *Price1;
@property (weak, nonatomic) IBOutlet UILabel *Price2;
@property (weak, nonatomic) IBOutlet UILabel *Price3;
@property (weak, nonatomic) IBOutlet UILabel *Price4;

@property (strong, nonatomic) IBOutlet UIButton *bth1;
@property (strong, nonatomic) IBOutlet UIButton *bth2;
@property (strong, nonatomic)NSMutableArray * Incomes;
@property (strong, nonatomic)NSMutableArray * Withdrawals;
@property (strong, nonatomic) IBOutlet UIView *selectView;

@end

@implementation MyIncomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"我的财富";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInfo = [ShareInfo shareInstance];
    self.Incomes = [NSMutableArray array];
    self.Withdrawals = [NSMutableArray array];
    
    [self setExtraCellLineHidden:self.myTableView];
    [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"myIncomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.myTableView reloadData];
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.myTableView;
    _footer.delegate = self;
    
    page = 1;
    self.selectView.alpha = 0;
    [self GetBenefitAccount];
    
    [self GetBenefitList];
    
    [self initView];
    
}
-(void)initView
{
    self.BGView1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView1.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView1.layer.shadowOpacity = 0.2;
    
    self.BGView2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView2.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView2.layer.shadowOpacity = 0.2;
    
    self.BGView3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView3.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView3.layer.shadowOpacity = 0.2;
    
    self.BGView4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView4.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView4.layer.shadowOpacity = 0.2;
}
-(void)GetBenefitAccount
{
    NSString * userID = shareInfo.userModel.userID;
    userID = @"dome88888888";
    
    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[userID] forKeys:@[@"uid"]];

    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSString * link = [[NSString stringWithFormat:GetIncome,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        [self GetBenefitAccount:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];

}
-(void)GetBenefitAccount:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    NSString * statusStr = [dict objectForKey:@"status"];
    BOOL stasusInt = [statusStr boolValue];
    
    if (stasusInt == false)
    {
        NSString * text = [dict objectForKey:@"text"];
        [self showAlertViewForTitle:text AndMessage:nil];
    }else{
        NSArray * data = [dict objectForKey:@"data"];
        float price1 = 0;
        float price2 = 0;
        float price3 = 0;
        for (int i = 0 ; i < data.count; i++)
        {
            NSString * string  = [data objectAtIndex:i];
            NSLog(@"string --> %@",string);
            if(i==0)
            {
                //本店收入
                price1 = [string floatValue];
                self.Price1.text = [NSString stringWithFormat:@"¥%.2f",price1];
                
            }else if (i==1)
            {
                //一级分店收入
                price2 = [string floatValue];
                self.Price2.text = [NSString stringWithFormat:@"¥%.2f",price2];
            }else if (i==2)
            {
                //二级分店收入
                price3 = [string floatValue];
                self.Price3.text = [NSString stringWithFormat:@"¥%.2f",price3];
            }
        }
        
        self.Price4.text = [NSString stringWithFormat:@"¥%.2f",price1+price2+price3];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)GetBenefitList
{
    
    
    
    NSString * shopId = shareInfo.userModel.userID;
    shopId = @"dome88888888";
    NSNumber * pageStr = [NSNumber numberWithLong:page];
    NSNumber * pagesizeStr = [NSNumber numberWithInt:pagesize];

    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,pageStr,pagesizeStr] forKeys:@[@"uid",@"page",@"pagesize"]];
    
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSString * link = [[NSString stringWithFormat:GetBenefit,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        [self GetBenefitAccount:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];
}
-(void)GetBenefitList:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    
    NSString * statusStr = [dict objectForKey:@"status"];
    BOOL stasusInt = [statusStr boolValue];

    if (stasusInt == false)
    {
        NSString * text = [dict objectForKey:@"text"];
        [self showAlertViewForTitle:text AndMessage:nil];
    }else{
        
        if (page == 1)
        {
            self.Incomes = [NSMutableArray array];
        }
        
        NSArray * date = [dict objectForKey:@"date"];
        for (NSDictionary * dateDit in date)
        {
            IncomeModel * model = [[IncomeModel alloc]init];
            model.AddDateTime = [dateDit objectForKey:@"AddDateTime"];
            model.OrderNo = [dateDit objectForKey:@"OrderNo"];
            model.ShareResult = [dateDit objectForKey:@"ShareResult"];
            model.ShareTotal = [dateDit objectForKey:@"ShareTotal"];
            model.UserId = [dateDit objectForKey:@"UserId"];
            model.UserType = [dateDit objectForKey:@"UserType"];
            [self.Incomes addObject:model];
        }
        
        [self.myTableView reloadData];
    }
    [_footer endRefreshing];
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"加载完毕" duration:0.7];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (IBAction)TouchBth:(UIButton *)button
{
    page = 1;
    switch (button.tag) {
        case 0:
            [self.bth1 setTitleColor:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] forState:UIControlStateNormal];
            [self.bth2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            status = 0;
            [self GetBenefitList];
            break;
            
        default:
            [self.bth2 setTitleColor:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] forState:UIControlStateNormal];
            [self.bth1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            status = 1;
            [self.myTableView reloadData];
            break;
    }
}







#pragma mark ShowAlertView
-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)TouchButton:(id)sender
{
    ChangInfoViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangInfoViewController"];
    
    vc.isChange = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)TouchWithdrawal:(id)sender
{
    NSLog(@"提现到银行卡");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (status == 0) {
        return self.Incomes.count;
    }else{
        return self.Withdrawals.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    myIncomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (status == 0)
    {
        IncomeModel * model = [self.Incomes objectAtIndex:indexPath.row];
        cell.ShareResult.text = [NSString stringWithFormat:@"+¥%.2f",[model.ShareResult floatValue]];
        cell.OrderAndTotal.text = [NSString stringWithFormat:@"订单号:%@,合计:%.2f",model.OrderNo,[model.ShareTotal floatValue]];
        cell.AddDateTime.text = [NSString stringWithFormat:@"分润时间:%@",model.AddDateTime];

        switch ([model.UserType integerValue])
        {
            case 1:
                cell.name.text = @"";
                break;
            case 2:
                cell.name.text = @"一级分店收入";
                break;
            case 3:
                cell.name.text = @"二级分店收入";
                break;
            case 4:
                cell.name.text = @"供应商收入";
                break;
            case 5:
                cell.name.text = @"设计师收入";
                break;
            case 6:
                cell.name.text = @"投资人/业主收入";
                break;
                
            default:
                cell.name.text = @"";
                break;
        }
        
        cell.BGView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.BGView.layer.shadowOffset = CGSizeMake(1, 1);
        cell.BGView.layer.shadowOpacity = 0.2;
        
    }else{
    
        cell.name.text = [NSString stringWithFormat:@"二级分店%ld",indexPath.row+1];

    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)dealloc
{
    [ _footer free ];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"y:%.2f",offset.y);
    if (offset.y > 250.00)
    {
        self.selectView.alpha = 1;
    }else{
        self.selectView.alpha = 0;
    }
}



#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if (refreshView == _footer) { // 上拉加载更多
        
        
        
        
        page++;
        if (status == 0) {
            [self performSelector:@selector(GetBenefitList) withObject:nil afterDelay:0.5];
        }
        
        
        
    }
}
- (void)endRefreshing:(NSNumber *)value
{
    // 结束刷新状态
    [_footer endRefreshing];
    if ([value boolValue]) {
        [Tools showPromptToView:self.view atPoint:self.view.center withText:@"加载完毕" duration:0.7];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
