//
//  RushOrderInfoViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "RushOrderInfoViewController.h"
#import "RushOrdersInfoTableViewCell.h"
#import "OrderInfoViewController.h"
@interface RushOrderInfoViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray * myData;
@end

@implementation RushOrderInfoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"RushOrdersInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.myTableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell" ;
    
    
    RushOrdersInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.OrdersImageView.image = [UIImage imageNamed:@"测试产品.jpg"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(1, 1);
    cell.layer.shadowOpacity = 0.2;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Touch %ld",(long)indexPath.row);
    OrderInfoViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
