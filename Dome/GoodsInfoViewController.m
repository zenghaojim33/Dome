//
//  GoodsInfoViewController.m
//  Dome
//
//  Created by BTW on 15/4/29.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "ProductModel.h"
#import "MyDomeTableViewCell.h"
#import "SDWebImage/SDWebImageManager.h"
#import "UMSocialSnsService.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "MJRefresh.h"
#import "ProductViewController.h"
@interface GoodsInfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    MyDomeTableViewCellDelegate,
    UMSocialUIDelegate
>
{
    MBProgressHUD * HUD;
    ShareInfo * shareInfo;
}
@property (strong, nonatomic) IBOutlet UITableView *MyTableView;
@property (strong, nonatomic) NSMutableArray * MyData;
@property (strong, nonatomic) NSMutableArray * SelectArray;
@end


#define kCellIdentifier @"Cell"
@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    shareInfo = [ShareInfo shareInstance];
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    self.MyTableView.tableFooterView = [[UIView alloc]init];
    self.MyTableView.tableHeaderView = [[UIView alloc]init];
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyDomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.SelectArray = [NSMutableArray array];
    [self GetData];
    // Do any additional setup after loading the view.
}
- (void)GetData
{
    
    NSString * link = [self.link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
        
        NSArray * response = [responseObject copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self GetData:response];

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
    }];
}
- (void)GetData:(NSArray*)goods
{
    self.MyData = [NSMutableArray array];
    for (NSDictionary * dict in goods)
    {
        ProductModel * model = [[ProductModel alloc]init];
        model.productId = [dict objectForKey:@"productId"];
        model.categoryId = [dict objectForKey:@"categoryId"];
        model.categoryName = [dict objectForKey:@"categoryName"];
        model.productName = [dict objectForKey:@"productName"];
        model.price = [dict objectForKey:@"price"];
        model.brandid = [dict objectForKey:@"brandid"];
        model.brandname = [dict objectForKey:@"brandname"];
        model.TitleImages = [NSMutableArray array];
        NSArray * TitleImages = [dict objectForKey:@"TitleImages"];
        for (NSDictionary * path in TitleImages)
        {
            [model.TitleImages addObject:[path objectForKey:@"path"]];
        }
        
        [self.MyData addObject:model];
    }
    
    [self.MyTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyDomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    
    ProductModel * model = [self.MyData objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    

    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.isMyDome = NO;
    return cell;
}


#pragma mark - CellDelegate


-(void)TouchDownForTag:(long int)tag
{
    ProductModel * model = [self.MyData objectAtIndex:tag];
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
    self.MyData[tag] = model;
    [self.MyTableView reloadData];
    NSLog(@"selectarray.count ---> %lu",(unsigned long)self.SelectArray.count);
    if (self.SelectArray.count == 0 )
    {
        [self.DoneButton setTitle:@"确定" forState:UIControlStateNormal];

    }else{
        [self.DoneButton setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.SelectArray.count] forState:UIControlStateNormal];
    }
}
- (IBAction)TouchDone:(id)sender
{
    if (self.SelectArray.count ==0)
    {
        [self showAlertViewForTitle:@"请选择货品" AndMessage:nil];
    }else{
        
        if (self.SelectArray.count ==0)
        {
            [self showAlertViewForTitle:@"请选择货品" AndMessage:nil];
        }else{
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.labelText = @"正在上架商品";
            NSMutableString * selectedProductString = [NSMutableString stringWithString:@""];
            for (ProductModel * model in self.SelectArray){
                [selectedProductString appendFormat:@"%@,",model.productId];
            }
            //删除最后一个逗号
            [selectedProductString substringToIndex:(selectedProductString.length -1)];
            
            NSDictionary * postDict = @{@"uid":shareInfo.userModel.userID,
                                        @"pidlist":selectedProductString,
                                        @"isshow":@"1"};
            
            [HTTPRequestManager postURL:OnOffSaleAPI andParameter:postDict onCompletion:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"errormsg"] isEqualToString:@""]){
                    
                    UIAlertView * alertView = [[UIAlertView alloc]init];
                    alertView.message = @"上架成功";
                    [alertView addButtonWithTitle:@"确定"];
                    [alertView show];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self GetData];
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    });
                    
                }
                
            }];
            
            
            
            
        }
        
        
        
        
        
        
    }
}
- (void)TouchCopyForTag:(long)tag
{
    ProductModel * model = [self.MyData objectAtIndex:tag];
    NSString * link = [NSString stringWithFormat:@"http://weixin.dome123.com/AllBeauty/ProudtDetail.html?productID=%@&id=%@",model.productId,shareInfo.userModel.userID];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = link;
    
    [Tools showPromptToView:self.view atPoint:self.view.center withText:@"复制成功" duration:1.5];
}
- (void)TouchShareForTag:(long)tag
{
    //微信网页类型
    
    BOOL isInstalledWeixin = [WXApi isWXAppInstalled];
    
    if (isInstalledWeixin){
        
        
        ProductModel * model = [self.MyData objectAtIndex:tag];
        
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
        NSString * link = [NSString stringWithFormat:@"http://weixin.dome123.com/AllBeauty/ProudtDetail.html?productID=%@&id=%@",model.productId,shareInfo.userModel.userID];
        
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
#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel * model = [self.MyData objectAtIndex:indexPath.row];
    //    NSString * link = [NSString stringWithFormat:@"http://weixin.dome123.com/AllBeauty/ProudtDetail.html?productID=%@&id=%@",model.productId,shareInfo.userModel.userID];
    
    NSString * link = [NSString stringWithFormat:@"http://weixin.dome123.com/AllBeauty/PreviewPage.html?productID=%@&id=null",model.productId];
    
    ProductViewController * vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
    
    vc.link = link;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showAlertViewForTitle:(NSString*)title AndMessage:(NSString*)message
{
    UIAlertView * av = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==999&&buttonIndex==1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://appsto.re/cn/S8gTy.i"]];
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
