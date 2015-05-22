//
//  BankViewController.m
//  Dome
//
//  Created by BTW on 15/1/4.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "BankViewController.h"
@interface BankViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isSearch;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITextField *MyTF;
@property(nonatomic,strong)NSMutableArray*BanksArray;
@property(nonatomic,strong)NSMutableArray*searchArray;
@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"选择银行";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    
    
    isSearch = NO;
    self.navigationItem.backBarButtonItem = backItem;
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (IBAction)MyTextFieldDidEndOnExit:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length==0)
    {
        isSearch = NO;
        [self.myTableView reloadData];
        
    }else{
        isSearch = YES;
        self.searchArray = [NSMutableArray array];
        
        for (int i = 0; i<self.BanksArray.count; i++)
        {
            NSString * bank = [self.BanksArray objectAtIndex:i];
            NSRange range = [bank rangeOfString:textField.text];
            if (range.location!=NSNotFound) {
                [self.searchArray addObject:bank];
            }else {
            }
            
        }
        
        [self.myTableView reloadData];
        
        
    }
}
#pragma 银行列表
-(void)initView
{
    
    self.BanksArray = [NSMutableArray arrayWithObjects:@"中国农业银行",@"中国银行",@"中国建设银行",@"中国工商银行",@"国家开发银行",@"中国进出口银行",@"中国农业发展银行",@"交通银行",@"中信银行",@"中国光大银行",@"华夏银行",@"中国民生银行",@"广东发展银行",@"平安银行",@"招商银行",@"兴业银行",@"上海浦东发展银行",@"北京银行",@"天津银行",@"杭州银行",@"大连银行",@"盛京银行",@"南京银行",@"江苏银行",@"上海银行",@"锦州银行",@"河北银行",@"唐山市商业银行",@"秦皇岛市商业银行",@"邯郸市商业银行",@"邢台市商业银行",@"保定市商业银行",@"张家口市商业银行",@"承德银行",@"沧州银行",@"廊坊银行",@"衡水市商业银行",@"晋商银行",@"大同市商业银行",@"阳泉市商业银行",@"长治市商业银行",@"晋城市商业银行",@"晋中市商业银行",@"内蒙古银行",@"包商银行",@"乌海银行",@"鄂尔多斯银行",@"哈尔滨银行",@"鞍山市商业银行",@"抚顺市商业银行",@"本溪市商业银行",@"丹东市商业银行",@"葫芦岛银行",@"营口银行",@"阜新银行",@"辽阳银行",@"盘锦市商业银行",@"铁岭市商业银行",@"朝阳市商业银行",@"吉林银行",@"龙江银行",@"宁波银行",@"浙江泰隆商业银行",@"浙江稠州商业银行",@"江苏长江商业银行",@"临商银行",@"温州银行",@"嘉兴银行",@"湖州市商业银行",@"绍兴银行",@"金华银行",@"台州市商业银行",@"浙江民泰商业银行",@"福建海峡银行",@"厦门银行",@"泉州银行",@"南昌银行",@"九江银行",@"赣州银行",@"上饶银行",@"齐鲁银行",@"威海市商业银行",@"青岛银行",@"齐商银行",@"枣庄市商业银行",@"东营市商业银行",@"烟台银行",@"潍坊银行",@"济宁银行",@"泰安市商业银行",@"莱商银行",@"德州银行",@"日照银行",@"郑州银行",@"开封市商业银行",@"洛阳银行",@"平顶山市商业银行",@"安阳市商业银行",@"鹤壁市商业银行",@"新乡银行",@"焦作市商业银行",@"许昌银行",@"漯河市商业银行",@"三门峡市商业银行",@"商丘市商业银行",@"周口市商业银行",@"驻马店市商业银行",@"南阳市商业银行",@"信阳市商业银行",@"汉口银行",@"黄石银行",@"宜昌市商业银行",@"襄樊市商业银行",@"孝感市商业银行",@"荆州市商业银行",@"长沙银行",@"株洲市商业银行",@"湘潭市商业银行",@"衡阳市商业银行",@"岳阳市商业银行",@"广州银行",@"珠海市商业银行",@"湛江市商业银行",@"东莞银行",@"广西北部湾银行",@"柳州市商业银行",@"桂林市商业银行",@"成都银行",@"重庆银行",@"自贡市商业银行",@"攀枝花市商业银行",@"泸州市商业银行",@"德阳市商业银行",@"绵阳市商业银行",@"遂宁市商业银行",@"乐山市商业银行",@"宜宾市商业银行",@"南充市商业银行",@"达州市商业银行",@"雅安市商业银行",@"凉山州商业银行",@"贵阳市商业银行",@"贵州省六盘水市商业银行",@"遵义市商业银行",@"安顺市商业银行",@"富滇银行",@"曲靖市商业银行",@"玉溪市商业银行",@"宁夏银行",@"西安市商业银行",@"长安银行",@"兰州银行",@"平凉市商业银行",@"青海银行",@"石嘴山银行",@"乌鲁木齐市商业银行",@"昆仑银行",@"库尔勒市商业银行",@"奎屯市商业银行",@"天津滨海农村商业银行",@"江苏江阴农村商业银行",@"江苏东吴农村商业银行",@"太仓农村商业银行",@"昆山市农村商业银行",@"吴江农村商业银行",@"江苏常熟农村商业银行",@"张家港农村商业银行",@"广州农村商业银行",@"佛山顺德农村商业银行",@"重庆农村商业银行",@"恒丰银行",@"浙商银行",@"天津农村商业银行",@"渤海银行",@"徽商银行",@"重庆三峡银行",@"本溪市城市信用社",@"景德镇市城市信用社",@"濮阳市城市信用社",@"邵阳市城市信用社",@"白银市城市信用社",@"哈密市城市信用社",@"北京农村商业银行",@"河北省农村信用社",@"山西省农村信用社",@"晋城市农村信用社",@"临汾市尧都区农村信用社",@"运城市农村信用社",@"内蒙古自治区农村信用社",@"辽宁省农村信用社",@"吉林省农村信用社",@"黑龙江省农村信用社",@"上海农村商业银行",@"江苏省农村信用社",@"浙江省农村信用社",@"宁波鄞州农村合作银行",@"安徽省农村信用社",@"福建省农村信用社",@"江西省农村信用社",@"山东省农村信用社",@"郑州农村信用社",@"河南省农村信用社",@"湖北省农村信用社",@"湖南省农村信用社",@"广东省农村信用社",@"深圳农村商业银行",@"东莞农村商业银行",@"广西壮族自治区农村信用社",@"海南省农村信用社",@"成都市农村信用社",@"四川省农村信用社",@"贵州省农村信用社",@"云南省农村信用社",@"陕西省农村信用社",@"甘肃省农村合作金融结算服务中心",@"青海省农村信用社",@"宁夏黄河农村商业银行",@"新疆维吾尔自治区农村信用社",@"中国邮政储蓄银行",@"汇丰银行",@"东亚银行",@"南洋商业银行",@"恒生银行",@"集友银行",@"创兴银行",@"星展银行",@"永亨银行",@"永隆银行",@"大新银行",@"中信嘉华银行",@"花旗银行",@"美国银行",@"摩根大通银行",@"美国建东银行",@"三菱东京日联银行",@"三井住友银行",@"瑞穗实业银行",@"瑞穗银行",@"日本山口银行",@"外换银行",@"友利银行",@"韩国产业银行",@"新韩银行",@"企业银行",@"韩亚银行",@"华侨银行",@"大华银行",@"盘谷银行",@"奥地利中央合作银行",@"比利时联合银行",@"比利时富通银行",@"荷兰银行",@"荷兰安智银行",@"渣打银行",@"英国渣打银行",@"英国苏格兰皇家银行",@"法国兴业银行",@"东方汇理银行",@"法国外贸银行",@"德意志银行",@"德国商业银行",@"德国西德银行",@"德国北德意志州银行",@"意大利联合圣保罗银行",@"瑞士信贷银行",@"瑞士银行",@"加拿大丰业银行",@"加拿大蒙特利尔银行",@"澳大利亚和新西兰银行",@"摩根士丹利国际银行",@"华美银行",@"荷兰合作银行",@"厦门国际银行",@"法国巴黎银行",@"华商银行",@"华一银行", nil];
    
    
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    [self.myTableView reloadData];
    
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (isSearch == YES) {
        return self.searchArray.count;
    }else{
        return self.BanksArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (isSearch==YES) {
        cell.textLabel.text = [self.searchArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.BanksArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isSearch == YES){
        [self.delegate setBankName:[self.searchArray objectAtIndex:indexPath.row]];
    }else{
        [self.delegate setBankName:[self.BanksArray objectAtIndex:indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end