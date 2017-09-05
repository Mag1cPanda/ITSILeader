//
//  EnterpriseInquireVC.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "EnterpriseInquireVC.h"
#import "EnterpriseSearchVC.h"
#import "LDEnterpriseCell.h"
#import "LDEnterpriseModel.h"

@interface EnterpriseInquireVC ()
<UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *dataArr;
    NSMutableDictionary *bean;
    
    NSString *totalCount;
    
    NSInteger page;
}
@end

@implementation EnterpriseInquireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([_type isEqualToString:@"1"]) {
        self.title = @"集成企业资质查询";
    }
    
    else {
        self.title = @"运行维护分项资质查询";
    }
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0, 0, 40, 40);
    [moreBtn setImage:[UIImage imageNamed:@"search"] forState:0];
    [moreBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:1<<6];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    dataArr = [NSMutableArray array];
    bean = [NSMutableDictionary dictionary];
    [bean setValue:[Globle getInstance].userflag forKey:@"userflag"];
    [bean setValue:[Globle getInstance].token forKey:@"token"];
    [bean setValue:@"10" forKey:@"pagesize"];
    [bean setValue:@"1" forKey:@"pagenum"];
    [bean setValue:_type forKeyPath:@"type"];
    
    
    page = 1;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor whiteColor];
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"LDEnterpriseCell" bundle:nil] forCellReuseIdentifier:@"LDEnterpriseCell"];
    
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClicked{
    EnterpriseSearchVC *vc = [EnterpriseSearchVC new];
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 加载数据
-(void)loadData
{
//    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
//    [bean setValue:[Globle getInstance].userflag forKey:@"userflag"];
//    [bean setValue:[Globle getInstance].token forKey:@"token"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [LSHttpManager requestWithServiceName:@"csigetmiitcompany" parameters:bean complete:^(id result, ResultType resultType) {
        
        [hud hideAnimated:true];
        
        NSLog(@"csigetmiitcompany ~ %@",result);
        
        if ([result[@"restate"] isEqualToString:@"1"]) {
            
            
            totalCount = result[@"redatas"][@"endNum"];
            
            id tmpObj = result[@"redatas"][@"result"];
            
            if ([tmpObj isKindOfClass:[NSArray class]]) {
                NSArray *arr = tmpObj;
                for (NSDictionary *dic in arr) {
                    LDEnterpriseModel *model = [[LDEnterpriseModel alloc] initWithDict:dic];
                    [dataArr addObject:model];
                }
            }
            
            [table reloadData];
        }
    }];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDEnterpriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDEnterpriseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexLab.text = [NSString stringWithFormat:@"%zi",indexPath.row+1];
    
    if (dataArr.count > indexPath.row) {
        LDEnterpriseModel *model = dataArr[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

@end
