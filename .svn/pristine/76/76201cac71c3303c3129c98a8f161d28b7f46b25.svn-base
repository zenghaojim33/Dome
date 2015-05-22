//
//  GoodsViewController.m
//  Dome
//
//  Created by BTW on 14/12/23.
//  Copyright (c) 2014年 jenk. All rights reserved.
//

#import "GoodsViewController.h"
#import "AllRootModel.h"
#import "CollectionViewCell.h"
#import "GoodsInfoViewController.h"
#import "SDWebImage/SDWebImageManager.h"
@interface GoodsViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate
>
{
    MBProgressHUD * HUD;
    NSString * catagoryId;
    long int indexRow;
}
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (nonatomic,strong)NSMutableArray * GetRoots;
@property (nonatomic,strong)NSMutableArray * TableViewArrays;
@property (nonatomic,strong)NSMutableArray * CollectionArrays;
@end

@implementation GoodsViewController


#pragma mark -------Life Cycle

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
    indexRow = 0;
    // Do any additional setup after loading the view.
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.tableHeaderView = [[UIView alloc]init];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    [self.CollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    [self GetRoot];
}

#pragma mark ---- HTTP Methods

- (void)GetRoot
{

    NSString * link = [[NSString stringWithFormat:GetByName,@"root"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在获取数据";
    [HTTPRequestManager getURL:link andParameter:nil onCompletion:^(id responseObject, NSError *error) {
       
        NSMutableArray * response = [responseObject copy];
        [self GetRootModel:response];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        });
        
    }];
    
    
    
}
#pragma mark 获取所有分类数据
-(void)GetRootModel:(NSMutableArray*)array
{
    self.GetRoots = [NSMutableArray array];
    self.TableViewArrays = [NSMutableArray array];
    self.CollectionArrays = [NSMutableArray array];
    for (NSMutableDictionary * dict in array)
    {
        AllRootModel * model = [[AllRootModel alloc]init];
        model.path = [dict objectForKey:@"path"];
        model.categoryName = [dict objectForKey:@"categoryName"];
        model.categoryId = [dict objectForKey:@"categoryId"];
        [self.GetRoots addObject:model];
        
        if ([model.path isEqualToString:@"root"])
        {
           
            
            NSString * title = self.title;
            if ([self.title isEqualToString:@"货品上架"])
            {
                title = @"服装";
            }
            
            if ([model.categoryName isEqualToString:title])
            {
                NSLog(@"model.name :%@ model.id :%@",model.categoryName,model.categoryId);
                
                catagoryId = [NSString stringWithFormat:@"root,%@",model.categoryId];
            
            }
            
           
        }
    }
    
    
    for (AllRootModel * model in self.GetRoots)
    {
        if ([model.path isEqualToString:catagoryId])
        {
            [self.TableViewArrays addObject:model];
        }
        [self.TableView reloadData];
    }
    if (self.TableViewArrays.count != 0)
    {
        AllRootModel * first = [self.TableViewArrays objectAtIndex:0];
        [self GetCollectionForID:first.categoryId];
    }
}
- (void)GetCollectionForID:(NSString*)idstr
{
    NSString * path = [NSString stringWithFormat:@"%@,%@",catagoryId,idstr];
    NSLog(@"idstr:%@",path);
    for (AllRootModel * model in self.GetRoots)
    {
        if ([model.path isEqualToString:path])
        {
            [self.CollectionArrays addObject:model];
        }
        
        [self.CollectionView reloadData];
    }
}
#pragma mark UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.TableViewArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   AllRootModel * model =  [self.TableViewArrays objectAtIndex:indexPath.row];
   cell.textLabel.text = model.categoryName;
   cell.selectionStyle = UITableViewCellAccessoryNone;
   cell.textLabel.font = [UIFont systemFontOfSize:14.0];
   cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == indexRow)
    {
        cell.textLabel.textColor = [UIColor colorWithRed:199/255.0 green:69/255.0 blue:67/255.0 alpha:1];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexRow = indexPath.row;
    AllRootModel * model = [self.TableViewArrays objectAtIndex:indexPath.row];
    self.CollectionArrays = [NSMutableArray array];
    [self GetCollectionForID:model.categoryId];
    [self.TableView reloadData];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark UICollectionView Delegate

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.CollectionArrays.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    AllRootModel * model = [self.CollectionArrays objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsInfoViewController * vc= [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsInfoViewController"];
    AllRootModel * model = [self.CollectionArrays objectAtIndex:indexPath.row];
    vc.title = model.categoryName;
    vc.link = [NSString stringWithFormat:GetByCategory,model.categoryId,@"id",1,@"price"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width-130)/3, (self.view.bounds.size.width-130)/3+40);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
        return UIEdgeInsetsMake(1, 1, 1, 1);
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
    self.title = title;
    indexRow = 0;
    [self GetRoot];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
