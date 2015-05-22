//
//  OrderViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "OrderViewController.h"
//#import "RushOrdersInfoTableViewCell.h"
#import "OrderTableViewCell.h"
#import "StartTimeViewController.h"
#import "EndTimeViewController.h"

#import "OrderInfoViewController.h"
#import "OrderModel.h"
#import "SDWebImage/SDWebImageManager.h"
#import "OrderDetailModel.h"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH self.view.feame.size.wicth
#define CELL_CONTENT_MARGIN 10.0f

@interface OrderViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    StartTimeDelegate,
    EndTimeDelegate,
    UIScrollViewDelegate,
    MJRefreshBaseViewDelegate
>
{
    NSString * selectStartTime;
    NSString * selectEndTime;
    NSString * type;
    
    
    
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
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) UIButton *DateEndBth;
@property (strong, nonatomic) UIButton *DateBth;
@property (weak, nonatomic) IBOutlet UIView *DateButtonBGView;

@property (weak, nonatomic) IBOutlet UIView *ButtonBGView;

@property (strong, nonatomic) UIButton *selectButton1;
@property (strong, nonatomic) UIButton *selectButton2;
@property (strong, nonatomic) UIButton *selectButton3;
@property (strong, nonatomic) UIButton *selectButton4;
@property (strong, nonatomic) UIButton *selectButton5;
@property (strong, nonatomic) UIButton *selectButton6;
@property (strong, nonatomic) UIButton *selectButton7;
@property (strong, nonatomic) UIButton *selectButton8;
@property (strong, nonatomic) UIButton *selectButton9;
@property (strong, nonatomic) UIButton *selectButton10;
@property(nonatomic,strong)NSMutableArray *ButtonArray;
@property (weak, nonatomic) IBOutlet UITableView *MyTableView;

@property (nonatomic,strong)NSMutableArray * myData;



@end


#define kCellIdentifier @"Cell"
@implementation OrderViewController
- (IBAction)TFExit:(UITextField *)sender
{
    [self.myTextField resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"订单查询";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    

    [self.myTextField resignFirstResponder];
    
    
}
-(void)initDateButton
{
    self.DateBth = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2-1, 40)];
    [self.DateBth setTitle:@"请选择开始日期" forState:UIControlStateNormal];
    [self.DateBth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.DateBth setBackgroundColor:[UIColor whiteColor]];
    [self.DateBth addTarget:self action:@selector(TouchData:) forControlEvents:UIControlEventTouchUpInside];
     self.DateBth.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.DateButtonBGView addSubview:self.DateBth];
    
    self.DateEndBth = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 40)];
    [self.DateEndBth setTitle:@"请选择结束日期" forState:UIControlStateNormal];
    [self.DateEndBth setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    [self.DateEndBth setBackgroundColor:[UIColor whiteColor]];
    [self.DateEndBth addTarget:self action:@selector(TouchEndData:) forControlEvents:UIControlEventTouchUpInside];
     self.DateEndBth.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.DateButtonBGView addSubview:self.DateEndBth];
    
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30+3, 10, 17, 17)];
    [button1 addTarget:self action:@selector(TouchDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"Delete.png"] forState:UIControlStateNormal];
    [self.DateButtonBGView addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30+3+self.view.frame.size.width/2, 10, 17, 17)];
    [button2 addTarget:self action:@selector(TouchDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:[UIImage imageNamed:@"Delete.png"] forState:UIControlStateNormal];
    [self.DateButtonBGView addSubview:button2];
    
}
-(void)TouchDeleteButton:(UIButton*)button
{
    [self.DateBth setTitle:@"请选择开始日期" forState:UIControlStateNormal];
    [self.DateEndBth setTitle:@"请选择结束日期" forState:UIControlStateNormal];
    
    selectStartTime = @"";
    selectEndTime = @"";
    self.myData = [NSMutableArray array];
    [self GetData];
}
-(void)initSelectButton
{
    float width = 90-1;

    self.ButtonArray = [NSMutableArray array];

    
    self.selectButton1 = [[UIButton alloc]initWithFrame:CGRectMake(width*0, 0, width, 33)];
    [self.selectButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectButton1 setTitle:@"待付款" forState:UIControlStateNormal];
         self.selectButton1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.selectButton1 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton1.tag = 0;
    [self.selectButton1 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton1];
    [self.ButtonArray addObject:self.selectButton1];
    
    self.selectButton2 = [[UIButton alloc]initWithFrame:CGRectMake(width*1+1, 0, width, 33)];
    [self.selectButton2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton2 setTitle:@"待发货" forState:UIControlStateNormal];
    [self.selectButton2 setBackgroundColor:[UIColor whiteColor]];
     self.selectButton2.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton2.tag = 1;
    [self.selectButton2 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton2];
    [self.ButtonArray addObject:self.selectButton2];
    
    self.selectButton3 = [[UIButton alloc]initWithFrame:CGRectMake(width*2+2, 0, width, 33)];
    [self.selectButton3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton3 setTitle:@"待签收" forState:UIControlStateNormal];
    [self.selectButton3 setBackgroundColor:[UIColor whiteColor]];
     self.selectButton3.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton3.tag = 2;
    [self.selectButton3 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton3];
    [self.ButtonArray addObject:self.selectButton3];
    
    self.selectButton4 = [[UIButton alloc]initWithFrame:CGRectMake(width*3+3, 0, width, 33)];
    [self.selectButton4 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton4 setTitle:@"签收中" forState:UIControlStateNormal];
    [self.selectButton4 setBackgroundColor:[UIColor whiteColor]];
     self.selectButton4.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton4.tag = 3;
    [self.selectButton4 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton4];
    [self.ButtonArray addObject:self.selectButton4];
    
    self.selectButton5 = [[UIButton alloc]initWithFrame:CGRectMake(width*4+4, 0, width, 33)];
    [self.selectButton5 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton5 setTitle:@"申请退货" forState:UIControlStateNormal];
    [self.selectButton5 setBackgroundColor:[UIColor whiteColor]];
     self.selectButton5.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton5.tag = 4;
    [self.selectButton5 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton5];
    [self.ButtonArray addObject:self.selectButton5];

    
    self.selectButton6 = [[UIButton alloc]initWithFrame:CGRectMake(width*5+5, 0, width, 33)];
    [self.selectButton6 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton6 setTitle:@"同意退货" forState:UIControlStateNormal];
    [self.selectButton6 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton6.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton6.tag = 5;
    [self.selectButton6 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton6];
    [self.ButtonArray addObject:self.selectButton6];
    
    self.selectButton7 = [[UIButton alloc]initWithFrame:CGRectMake(width*6+6, 0, width, 33)];
    [self.selectButton7 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton7 setTitle:@"不同意退货" forState:UIControlStateNormal];
    [self.selectButton7 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton7.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton7.tag = 6;
    [self.selectButton7 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton7];
    [self.ButtonArray addObject:self.selectButton7];
    
    self.selectButton8 = [[UIButton alloc]initWithFrame:CGRectMake(width*7+7, 0, width, 33)];
    [self.selectButton8 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton8 setTitle:@"退货成功" forState:UIControlStateNormal];
    [self.selectButton8 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton8.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton8.tag = 7;
    [self.selectButton8 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton8];
    [self.ButtonArray addObject:self.selectButton8];
    
    self.selectButton9 = [[UIButton alloc]initWithFrame:CGRectMake(width*9+9, 0, width, 33)];
    [self.selectButton9 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton9 setTitle:@"已完成" forState:UIControlStateNormal];
    [self.selectButton9 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton9.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton9.tag = 8;
    [self.selectButton9 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton9];
    [self.ButtonArray addObject:self.selectButton9];
    
    self.selectButton10 = [[UIButton alloc]initWithFrame:CGRectMake(width*8+8, 0, width, 33)];
    [self.selectButton10 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.selectButton10 setTitle:@"退货中" forState:UIControlStateNormal];
    [self.selectButton10 setBackgroundColor:[UIColor whiteColor]];
    self.selectButton10.titleLabel.font = [UIFont systemFontOfSize:15];
    self.selectButton10.tag = 9;
    [self.selectButton10 addTarget:self action:@selector(TouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.selectButton10];
    [self.ButtonArray addObject:self.selectButton10];
    
    
    self.myScrollView.delegate = self;
    [self.myScrollView setContentSize:CGSizeMake(width*10, self.myScrollView.frame.size.height)];
   

}
- (void)TouchSelectButton:(UIButton *)button
{
    
    
    NSLog(@"button:%ld",(long)button.tag);
    self.myData = [NSMutableArray array];
    page = 1;
    for (int i = 0; i<self.ButtonArray.count; i++) {
    UIButton * SelectButton  = [self.ButtonArray objectAtIndex:i];
    [SelectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    }
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    type = [NSString stringWithFormat:@"%ld",(long)button.tag];
    
    if (button.tag == 2)
    {
        [self.myScrollView setContentOffset:CGPointMake(40, 0)animated:YES];
    }else if(button.tag == 3)
    {
        [self.myScrollView setContentOffset:CGPointMake(130, 0)animated:YES];
    }else if(button.tag == 4){
        [self.myScrollView setContentOffset:CGPointMake(222, 0)animated:YES];
    }else if(button.tag == 5){
        [self.myScrollView setContentOffset:CGPointMake(307, 0)animated:YES];
    }else if(button.tag == 6){
        [self.myScrollView setContentOffset:CGPointMake(398, 0)animated:YES];
    }else if(button.tag == 7){
        [self.myScrollView setContentOffset:CGPointMake(486, 0)animated:YES];
    }else if(button.tag > 7){
        [self.myScrollView setContentOffset:CGPointMake(self.selectButton7.frame.origin.x, 0)animated:YES];
    }else{
        [self.myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }


    
    [self GetData];
    

    
    
}


-(void)SetStartTimeString:(NSString *)startTime
{
    

    selectStartTime = startTime;
    
    [self.DateBth setTitle:[NSString stringWithFormat:@"%@",startTime] forState:UIControlStateNormal];
    
    [self.DateEndBth setTitle:@"请选择结束日期" forState:UIControlStateNormal];
}
- (void)TouchData:(UIButton *)sender {
    
    NSLog(@"TouchData");
    
    StartTimeViewController *vc = [[StartTimeViewController alloc]init];
    vc.delegate =self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)TouchEndData:(id)sender
{
    if (selectStartTime.length ==0) {
        [self showAlertViewForTitle:@"请选择开始日期" AndMessage:nil];
    }else{
        
        EndTimeViewController * vc = [[EndTimeViewController alloc]init];
        vc.StartTimeStr = selectStartTime;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}

-(void)SetEndTimeString:(NSString *)EndTime
{
    [self.DateEndBth setTitle:[NSString stringWithFormat:@"%@",EndTime] forState:UIControlStateNormal];
    
    selectEndTime = EndTime;
    
    NSLog(@"selectEndTime:%@",selectEndTime);
    self.myData = [NSMutableArray array];
    [self GetData];
}

//委托方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"x:%.2f",offset.x);
}
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if (refreshView == _footer) { // 上拉加载更多
        
        
        
        
        page++;
        
        [self performSelector:@selector(GetData) withObject:nil afterDelay:0.5];
        
    }else{
        page = 1;
//        self.myData=[NSMutableArray array];
        [self performSelector:@selector(GetData) withObject:nil afterDelay:0.5];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shareInfo = [ShareInfo shareInstance];
    
    [self initDateButton];
    [self initSelectButton];
    isSearch = NO;
    page = 1;
    type = @"0";
    [self GetData];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.MyTableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.MyTableView;
    _footer.delegate = self;
    
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    [self.MyTableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.MyTableView reloadData];
}
-(void)GetData
{

    
    NSString * shopId = shareInfo.userModel.shopid;
    NSNumber * number = [NSNumber numberWithInt:page];
    NSNumber * pagesize = [NSNumber numberWithInt:10];
    
    NSString * begin;
    if (selectStartTime.length!=0)
    {
        begin = selectStartTime;
    }else{
        begin = @"";
    }
    
    NSString * end;
    if (selectEndTime.length!=0)
    {
        end = selectEndTime;
    }else{
        end = @"";
    }
    
    NSString * status = type;
    NSMutableDictionary * data;
    if (selectEndTime.length==0)
    {
       data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,number,pagesize,status] forKeys:@[@"shopid",@"page",@"pagesize",@"status"]];
    }else{
       data = [[NSMutableDictionary alloc]initWithObjects:@[shopId,number,pagesize,begin,end,status] forKeys:@[@"shopid",@"page",@"pagesize",@"begin",@"end",@"status"]];
    }
    
    
    SBJsonWriter * json = [[SBJsonWriter alloc]init];
    NSString * jsonData = [json stringWithObject:data];
    NSString * link = [[NSString stringWithFormat:GetShopOrderList,jsonData] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSMutableDictionary * response = [responseObject copy];
        [self UpGuestData:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
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

        if (page == 1)
        {
            self.myData = [NSMutableArray array];
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
    
    
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    OrderModel * model = [self.myData objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 120;
    
//    return 120;
}
#pragma mark - Table view delegate
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
        [self UpGetOrderDetailData:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
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
#pragma mark ShowAlertView
-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
}


-(void)dealloc
{
    [_header free];
    [_footer free];
    
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