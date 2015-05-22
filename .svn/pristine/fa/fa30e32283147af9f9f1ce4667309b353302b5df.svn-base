//
//  MyIntegralViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "MyIntegralViewController.h"
#import "MyIntegralTableViewCell.h"
@interface MyIntegralViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *MyTableView;

@end

@implementation MyIntegralViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"我的美分";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
}
- (IBAction)TouchAddIntegarl:(id)sender {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource = self;
    [self.MyTableView registerNib:[UINib nibWithNibName:@"MyIntegralTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.MyTableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell" ;
    
    
    MyIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    
    

    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
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
