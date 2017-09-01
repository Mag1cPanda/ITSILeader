//
//  HomeViewController.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeader.h"
#import "HomeLeftCell.h"
#import "HomeRightCell.h"
#import "LRCycleScrollView.h"

@interface HomeViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    HomeHeader *header;
    UITableView *table;
    NSMutableArray *dataArr;
    
    NSString *totalCount;
    
    NSInteger page;
}
@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArr = [NSMutableArray array];
    page = 1;
    
    self.navBarView.hidden = YES;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    
    
    header = [[HomeHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200*(ScreenWidth/320))];
    table.tableHeaderView = header;
    
    
    [table registerNib:[UINib nibWithNibName:@"HomeLeftCell" bundle:nil] forCellReuseIdentifier:@"HomeLeftCell"];
    [table registerNib:[UINib nibWithNibName:@"HomeRightCell" bundle:nil] forCellReuseIdentifier:@"HomeRightCell"];
    
//    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self  refreshingAction:@selector(loadMoreData)];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
-(void)loadData
{

}

-(void)refreshData
{
    page = 1;
    [dataArr removeAllObjects];
    [table.mj_header endRefreshing];
    [self loadData];
}

-(void)loadMoreData
{
    
}

#pragma mark - TableView Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (ScreenHeight-49-(200*(ScreenWidth/320)))/4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section%2 == 0) {
        HomeLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeLeftCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            cell.titleLab.text = @"集成企业资质查询";
            cell.icon.image = [UIImage imageNamed:@"jc"];
        }
        
        else {
            cell.titleLab.text = @"项目经理登记查询";
            cell.icon.image = [UIImage imageNamed:@"xm"];
        }
        
        return cell;
    }
    
    else {
        HomeRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRightCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 1) {
            cell.titleLab.text = @"运行维护分项资质查询";
            cell.icon.image = [UIImage imageNamed:@"yx"];
        }
        
        else {
            cell.titleLab.text = @"高级项目经理登记查询";
            cell.icon.image = [UIImage imageNamed:@"gj"];
        }
        
        return cell;
    }
    
}


@end
