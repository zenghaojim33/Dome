//
//  CustomerInfoViewController.m
//  Dome
//
//  Created by BTW on 14/12/24.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "CustomerInfoViewController.h"
#import "CustomerGoodsTableViewCell.h"

#import "OrderInfoViewController.h"
#import "OrderModel.h"
#import "UIImageView+FadeInEffect.h"
#import "OrderDetailModel.h"
#import "RushOrdersInfoTableViewCell.h"

#define kCellIdentifier @"Cell"
@interface CustomerInfoViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    MJRefreshBaseViewDelegate
>
{
    
    int page;
    ShareInfo * shareInfo;
    MBProgressHUD * HUD;
    //刷新
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    int totalCount;
    NSOperationQueue *queue;
    
    BOOL isSearch;

}
@property (weak, nonatomic) IBOutlet UITableView *MyTableView;
@property (weak, nonatomic) IBOutlet UIView *BGView1;
@property (weak, nonatomic) IBOutlet UILabel *BGView2;
@property (weak, nonatomic) IBOutlet UIButton *ContactBth;

@property (weak, nonatomic) IBOutlet UILabel *GuestName;
@property (weak, nonatomic) IBOutlet UILabel *GuestLastTime;
@property (weak, nonatomic) IBOutlet UILabel *GuestPrice;
@property (weak, nonatomic) IBOutlet UILabel *GuestPhone;

@property(nonatomic,strong)NSMutableArray * myData;
@end

@implementation CustomerInfoViewController



#pragma mark ------Life Cycle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"客户管理";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ContactBth.alpha = 0;
    
    self.BGView1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView1.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView1.layer.shadowOpacity = 0.2;
    
    self.BGView2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.BGView2.layer.shadowOffset = CGSizeMake(1, 1);
    self.BGView2.layer.shadowOpacity = 0.2;
    shareInfo = [ShareInfo shareInstance];
    page = 1;
    [self GetData];
    isSearch = NO;
    
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.MyTableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.MyTableView;
    _footer.delegate = self;
    
    // Do any additional setup after loading the view.
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    [self.MyTableView registerNib:[UINib nibWithNibName:@"RushOrdersInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.MyTableView reloadData];
    
    self.GuestName.text = self.guestModel.name;
    self.GuestLastTime.text = [NSString stringWithFormat:@"最后下单时间:%@",self.guestModel.createtime];
    float price = [self.guestModel.price floatValue];
    self.GuestPhone.text = [NSString stringWithFormat:@"手机号:%@",self.guestModel.phone];
    self.GuestPrice.text = [NSString stringWithFormat:@"总消费:¥%.2f",price];

}
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if (refreshView == _footer) { // 上拉加载更多

        page++;
        
        [self GetData];
        
    }else{
        page = 1;
        self.myData=[NSMutableArray array];
        [self GetData];
    }
}
- (void)endRefreshing:(NSNumber *)value
{
    // 结束刷新状态
    [_footer endRefreshing];
    if ([value boolValue]) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

-(void)GetData
{

    NSString * shopId = shareInfo.userModel.shopid;
    NSString * uid = self.guestModel.uid;
    NSNumber * number = [NSNumber numberWithInt:page];
   
    NSNumber * pagesize = [NSNumber numberWithInt:10];

    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,uid,number,pagesize] forKeys:@[@"shopid",@"uid",@"page",@"pagesize"]];
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSLog(@"jsonData:%@",jsonData);
    NSString * link = [[NSString stringWithFormat:GetCustomerInfo,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self UpGuestData:response];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];

}
-(void)UpGuestData:(NSMutableDictionary*)dict
{
    NSLog(@"dict:%@",dict);
    
    NSString * status = [dict objectForKey:@"status"];
    int stasusInt = [status intValue];
    
    [_header endRefreshing];
    [_footer endRefreshing];
    
    
    if (stasusInt == false)
    {
        NSString * text = [dict objectForKey:@"text"];
        [self showAlertViewForTitle:text AndMessage:nil];
    }else{
        
        NSMutableArray * orders = [NSMutableArray array];
        NSArray * array =[dict objectForKey:@"data"];
        for (NSDictionary * newDict in array)
        {
            OrderModel * model = [[OrderModel alloc]init];
            
            model.suborderid = [newDict objectForKey:@"suborderid"];
            model.productid = [newDict objectForKey:@"productid"];
            model.count = [newDict objectForKey:@"count"];
            model.price = [newDict objectForKey:@"price"];
            model.picture = [newDict objectForKey:@"picture"];
            model.status = [newDict objectForKey:@"status"];
            model.name = [newDict objectForKey:@"name"];
            model.createtime = [newDict objectForKey:@"createtime"];
            [orders addObject:model];
            
        }
        
        
        [Tools showPromptToView:self.view atPoint:self.view.center withText:@"加载完毕" duration:0.7];
        
        if (self.myData.count ==0)
        {
            self.myData = [NSMutableArray array];
        }
        
        for (OrderModel * model in orders)
        {
            [self.myData addObject:model];
        }
        
        
        [self.MyTableView reloadData];
        
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RushOrdersInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    OrderModel * model = [self.myData objectAtIndex:indexPath.row];
    
    [cell updateCellWithModel:model];

    return cell;

}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 140;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel * model = [self.myData objectAtIndex:indexPath.row];
    NSString * suborderid = model.suborderid;
    NSMutableDictionary *  data = [[NSMutableDictionary alloc]initWithObjects:@[suborderid] forKeys:@[@"orderid"]];
    
    
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSString * link = [[NSString stringWithFormat:OrderDetail,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self UpGetOrderDetailData:response];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];
    
}
- (void)UpGetOrderDetailData:(NSMutableDictionary*)detailData
{
    NSString * status =[detailData objectForKey:@"status"];
    int statusInt = [status intValue];
    if (statusInt == false)
    {
        NSString * text = [detailData objectForKey:@"text"];
        [self showAlertViewForTitle:text AndMessage:nil];
    }else{
        
        OrderDetailModel * model = [OrderDetailModel alloc];
        
        NSMutableArray * array = [detailData objectForKey:@"data"];
        NSMutableDictionary * dict = array[0];
        
        model.suborderid = [dict objectForKey:@"suborderid"];
        model.productid = [dict objectForKey:@"productid"];
        model.count = [dict objectForKey:@"count"];
        model.price = [dict objectForKey:@"price"];
        model.picture = [dict objectForKey:@"picture"];
        model.status = [dict objectForKey:@"status"];
        model.name = [dict objectForKey:@"name"];
        model.createtime = [dict objectForKey:@"createtime"];
        
        
        NSMutableDictionary * addressDic = [dict objectForKey:@"address"];
        model.linkname = [addressDic objectForKey:@"linkname"];
        model.phone = [addressDic objectForKey:@"phone"];
        model.zipcode = [addressDic objectForKey:@"zipcode"];
        model.addresstext = [addressDic objectForKey:@"addresstext"];
        
        
        model.allattr = [NSMutableArray array];
        NSArray * attributes = [dict objectForKey:@"attribute"];
        NSArray * allattrs = [dict objectForKey:@"allattr"];
        
        for (NSDictionary * attributesDict in attributes)
        {
            NSString * paid = [attributesDict objectForKey:@"paid"];
            
            for (NSDictionary * allattrsDict in allattrs)
            {
                NSString * idStr = [allattrsDict objectForKey:@"id"];
                if ([idStr isEqualToString:paid])
                {
                    NSString * value = [allattrsDict objectForKey:@"value"];
                    [model.allattr addObject:value];
                }
            }
        }
        
        for (NSString * str in model.allattr)
        {
            NSLog(@"%@",str);
        }
        
        OrderInfoViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderInfoViewController"];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark HttpGet


-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    [av show];
}
-(void)dealloc
{
    [ _header free ];
    [ _footer free ];
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
