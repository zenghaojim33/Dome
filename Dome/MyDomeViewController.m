//
//  MyDomeViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "MyDomeViewController.h"
#import "ChangInfoViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "MyDomeTableViewCell.h"
#import "ProductModel.h"
#import "BlocksKit.h"
#import "UIImageView+WebCache.h"
#import "SDWebImage/SDWebImageManager.h"
#import "ProductViewController.h"
#import "GoodsViewController.h"
#import "DVSwitch.h"
@interface MyDomeViewController ()
<
    UMSocialUIDelegate,
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate,
    MJRefreshBaseViewDelegate,
    MyDomeTableViewCellDelegate
>
{
    MBProgressHUD * HUD;
    int pageindex;
    
    MJRefreshFooterView *_footer;
    int totalCount;
    NSOperationQueue *queue;
    
    BOOL isSearch;
    
    ShareInfo * shareInfo;
    
    UIColor  * switchColor;
    BOOL isPrice;
    
    NSString * _sequence;
}
@property (strong, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *ShopUrl;
@property (weak, nonatomic) IBOutlet UILabel *ShopName;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIView *ButtonView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) NSMutableArray * searchArray;
@property (weak, nonatomic) IBOutlet UIButton *SwitchButton1;
@property (weak, nonatomic) IBOutlet UIButton *SwitchButton2;
@property (weak, nonatomic) IBOutlet UIView *SwitchView;
@property (strong, nonatomic) NSMutableArray * SelectArray;
@end


#define kCellIdentifier @"Cell"

@implementation MyDomeViewController
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
   if (refreshView == _footer) { // 上拉加载更多
        
     

           
        pageindex++;
     
       [self UpData];
       
       
       
    }
}
- (void)endRefreshing:(NSNumber *)value
{
    // 结束刷新状态
    [_footer endRefreshing];
    if ([value boolValue]) {
        [Tools showPromptToView:self.view atPoint:self.view.center withText:@"加载完毕" duration:0.5];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}
-(void)UpData
{
    NSString * uid = shareInfo.userModel.userID;
    NSString * link = [[NSString stringWithFormat:Getbycategoryandvalueid,self.valueids,self.categoryid,pageindex,self.sort,_sequence,uid,@1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        NSMutableArray * response = [responseObject copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self GetByCategoryData:response];

            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
 
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInfo = [ShareInfo shareInstance];
    switchColor = self.SwitchButton1.tintColor;
    //搜索
    isPrice = YES;
    isSearch = NO;
    _sequence = @"desc";
    
    self.SelectArray = [NSMutableArray array];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.myTableView.tableHeaderView = [[UIView alloc] init];
    self.myTableView.tableFooterView = [[UIView alloc] init];
    
    self.myTableView.tableHeaderView = self.userView;
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyDomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.myTableView;
    _footer.delegate = self;
    
    [self.myTableView reloadData];
    // Do any additional setup after loading the view.
    
    self.myTextField.delegate = self;
    
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    pageindex = 1;
    if (self.Products.count == 0)
    {
        
        // self.key = @"护肤,彩妆,美发,美体,香氛";
        self.key = @"";
        self.valueids = @"";
        self.categoryid = @"";
        self.seachtype = @"n";
        self.sort = @"price";
        
        
        
        [self UpData];
        
        
    }
    
    
    
    
    self.selectView.alpha = 0;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"我的店铺";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
    
    if(self.Products.count != 0)
    {
        [self.myTableView reloadData];

    }
    
    shareInfo = [ShareInfo shareInstance];
    self.ShopName.text= shareInfo.userModel.shopname;
    
    self.ShopUrl.text = shareInfo.userModel.shopinfo;

}
- (IBAction)TouchSwitchButton:(UIButton *)sender {
    
    if (sender.tag == 0)
    {
        [self.SwitchButton1 setTitleColor:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] forState:UIControlStateNormal];
        [self.SwitchButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.sort = @"price";
    }else{
        [self.SwitchButton2 setTitleColor:[UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1] forState:UIControlStateNormal];
        [self.SwitchButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          self.sort = @"sales";
    }
    self.Products = [NSMutableArray array];
    if ([_sequence isEqualToString:@"desc"])
    {
        _sequence = @"asc";
    }else{
        _sequence = @"desc";
    }
    [self UpData];
    
    NSLog(@"sort:%@ sequence:%@",self.sort,_sequence);
    

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearch == YES)
    {
        return  self.searchArray.count;
    }else{
        return self.Products.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    MyDomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    ProductModel * model;
    
    if (isSearch == YES)
    {
        model = [self.searchArray objectAtIndex:indexPath.row];
    }else{
        model = [self.Products objectAtIndex:indexPath.row];
    }
    
    [cell updateCellWithModel:model];
    cell.isMyDome = YES;
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}
#pragma mark - CellDelegate
-(void)TouchDownForTag:(long int)tag
{
    ProductModel * model = [self.Products objectAtIndex:tag];
    if (model.isSelect == YES)
    {
        model.isSelect = NO;
        for (int i = 0; i<self.SelectArray.count; i++)
        {
            ProductModel * SelectModel = [self.SelectArray objectAtIndex:i];
            if ([model.categoryId isEqualToString:SelectModel.categoryId])
            {
                [self.SelectArray removeObjectAtIndex:i];
            }
        }
    }else{
        model.isSelect = YES;
        [self.SelectArray addObject:model];
    }
    self.Products[tag] = model;
    [self.myTableView reloadData];
    NSLog(@"selectarray.count ---> %lu",(unsigned long)self.SelectArray.count);
    if (self.SelectArray.count == 0 )
    {
        [self.DoneButton setTitle:@"下架" forState:UIControlStateNormal];
        
    }else{
        [self.DoneButton setTitle:[NSString stringWithFormat:@"下架(%lu)",(unsigned long)self.SelectArray.count] forState:UIControlStateNormal];
    }
}






- (IBAction)TouchDone:(id)sender
{
    if (self.SelectArray.count ==0)
    {
        [self showAlertViewForTitle:@"请选择货品" AndMessage:nil];
    }else{
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在下架商品";
        NSMutableString * selectedProductString = [NSMutableString stringWithString:@""];
        for (ProductModel * model in self.SelectArray){
            [selectedProductString appendFormat:@"%@,",model.productId];
        }
        //删除最后一个逗号
        [selectedProductString substringToIndex:(selectedProductString.length -1)];
        
        NSDictionary * postDict = @{@"uid":shareInfo.userModel.userID,
                                    @"pidlist":selectedProductString,
                                    @"isshow":@"0"};
    
        [HTTPRequestManager postURL:OnOffSaleAPI andParameter:postDict onCompletion:^(id responseObject, NSError *error) {
           
            if ([responseObject[@"errormsg"] isEqualToString:@""]){
                
                UIAlertView * alertView = [[UIAlertView alloc]init];
                alertView.message = @"下架成功";
                [alertView addButtonWithTitle:@"确定"];
                [alertView show];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self UpData];
                    
                });
            }
            
        }];
        
        
        
        
    }
}
- (void)TouchCopyForTag:(long)tag
{
    ProductModel * model = [self.Products objectAtIndex:tag];
    NSString * link = [NSString stringWithFormat:CopyProduct,model.productId,shareInfo.userModel.userID];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = link;
    
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"复制成功" duration:1.5];
}
- (void)TouchShareForTag:(long)tag
{
    //微信网页类型
    
    BOOL isInstalledWeixin = [WXApi isWXAppInstalled];
    
    if (isInstalledWeixin){
        
        
        ProductModel * model = [self.Products objectAtIndex:tag];
        
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
        NSString *shareText = model.productName;             //分享内嵌文字
        NSString * path = model.TitleImages[0];
        NSString * Link;
        NSString * http = [path substringToIndex:4];
        if ([http isEqualToString:@"http"]) {
            Link = path;
        }else{
            Link = [NSString stringWithFormat:@"http://dome123.com%@",path];
        }
        UIImage * shareImage =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:Link];
        
        NSString * link = [NSString stringWithFormat:CopyProduct,model.productId,shareInfo.userModel.userID];
        
        [UMSocialData defaultData].extConfig.wechatSessionData.url = link;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = link;
        
        //如果得到分享完成回调，需要设置delegate为self
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54a350bffd98c51f0900012d" shareText:shareText shareImage:shareImage shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline] delegate:self];
        
    }else{
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"你的设备尚未安装微信" message:@"暂时无法使用分享功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
        av.tag = 999;
        [av show];
    }

}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel * model = [self.Products objectAtIndex:indexPath.row];

    NSString * link = [NSString stringWithFormat:ProductInfo,model.productId];
    
    ProductViewController * vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
    
    vc.link = link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

#pragma GetByCategoryData
-(void)GetByCategoryData:(NSMutableArray*)array
{
    


    self.Products = [NSMutableArray array];
    
    for (NSMutableDictionary * dict in array)
    {
            ProductModel * model = [[ProductModel alloc]init];
            model.productId = [dict objectForKey:@"productId"];
            model.categoryId = [dict objectForKey:@"categoryId"];
            model.categoryName = [dict objectForKey:@"categoryName"];
            model.productName = [dict objectForKey:@"productName"];
            model.price = [dict objectForKey:@"price"];
            model.brandid = [dict objectForKey:@"brandid"];
            model.brandname = [dict objectForKey:@"brandname"];
            model.inPrice = dict[@"inPrice"];
            model.shopPrice = dict[@"shopPrice"];
            NSMutableArray * TitleImages = [dict objectForKey:@"TitleImages"];
            model.TitleImages = [NSMutableArray array];
            for (NSMutableDictionary * imagesDict in TitleImages)
            {
                NSString * path = [imagesDict objectForKey:@"path"];
                [model.TitleImages addObject:path];
            }
            if(model.price.length != 0)
            {
                [self.Products addObject:model];
            }
    }
        
    [_footer endRefreshing];
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"加载完毕" duration:0.7];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    NSLog(@"self.products.count:%lu",(unsigned long)self.Products.count);
    [self.myTableView reloadData];

        
    

    
}
- (IBAction)TouchEditorButton:(UIButton*)button
{
    ChangInfoViewController * vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangInfoViewController"];
    vc.isChange = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 点击店铺复制
- (IBAction)TouchCopyButton:(UIButton*)button
{
    NSString * link = [NSString stringWithFormat:CopyShop,shareInfo.userModel.shopid];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = link;
    
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"复制成功" duration:1.5];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [av show];
        
        //Because November is luck month
    }
}
#pragma mark 点击店铺分享
- (IBAction)TouchShareButton:(UIButton*)button
{
    //微信网页类型
    
    BOOL isInstalledWeixin = [WXApi isWXAppInstalled];
    
    if (isInstalledWeixin){
        
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
        NSString *shareText = @"我的都美";             //分享内嵌文字
        UIImage *shareImage =[UIImage imageNamed:@"dome123.png"];  //分享内嵌图片
        
        
        NSString * link = [NSString stringWithFormat:CopyShop,shareInfo.userModel.shopid];
        NSLog(@"link:%@",link);
        [UMSocialData defaultData].extConfig.wechatSessionData.url = link;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = link;
        
        //如果得到分享完成回调，需要设置delegate为self
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54a350bffd98c51f0900012d" shareText:shareText shareImage:shareImage shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline] delegate:self];
        
    }else{
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"你的设备尚未安装微信" message:@"暂时无法使用分享功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
        av.tag = 999;
        [av show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==999&&buttonIndex==1)
    {
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://appsto.re/cn/S8gTy.i"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 搜索产品
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    
    if (textField.tag== 999)
    {
        
    }
}
- (IBAction)TextFieldExit:(UITextField *)sender {
    
    self.searchArray = [NSMutableArray array];
    
    if (sender.text.length == 0) {
        isSearch = NO;
    }else{
        isSearch = YES;
       
        for (int i = 0;i<self.Products.count; i++)
        {
            ProductModel * model = [self.Products objectAtIndex:i];
            NSRange range = [model.productName rangeOfString:sender.text];
            if (range.location!=NSNotFound) {
                [self.searchArray addObject:model];
            }else {
            }

        }
    }
    
    [sender resignFirstResponder];
    [self.myTableView reloadData];
    
}

-(void)SetKey:(NSString *)key Seachtype:(NSString *)seachtype Sort:(NSString *)sort
{
    NSLog(@"key2:%@ seachtype2:%@ sort2:%@",key,seachtype,sort);
    self.categoryid = key;
    self.key = key;
    self.seachtype = seachtype;
    self.sort = sort;
    pageindex =1;
    self.Products = [NSMutableArray array];
    [self UpData];
}



-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    [av show];
}
-(void)dealloc
{
    [ _footer free ];
}
- (IBAction)TouchCategory:(UIButton *)sender
{
    NSString * title;
    switch (sender.tag)
    {
        case 0:
            title = @"服装";
            break;
        case 1:
            title = @"美妆";
            break;
        case 2:
            title = @"包袋";
            break;
        case 3:
            title = @"配饰";
            break;
        default:
            title = @"鞋履";
            break;
    }
    
    GoodsViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsViewController"];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark tableview 悬浮
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"y:%.2f",offset.y);
    if (offset.y > 157)
    {
        self.selectView.alpha = 1;
    }else{
        self.selectView.alpha = 0;
    }
}

@end
