//
//  AddressViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "NewAddressViewController.h"
@interface AddressViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    AddressCellDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *MyTableView;

@end

@implementation AddressViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"管理地址";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    [self.MyTableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.MyTableView reloadData];
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
    
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(1, 1);
    cell.layer.shadowOpacity = 0.2;
    return cell;
}
-(void)TouchChangeButtonForTag:(long int)tag
{
    NewAddressViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewAddressViewController"];
    vc.isChange = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)TouchDeleteButtonForTag:(long int)tag
{
    UIAlertView * av =[[UIAlertView alloc]initWithTitle:@"是否删除该地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    av.tag = 999;
    [av show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999&&buttonIndex==1)
    {
        NSLog(@"确定删除");
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
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
