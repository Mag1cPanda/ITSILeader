//
//  NewsViewController.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "NewsViewController.h"
#import "LRCycleScrollView.h"
#import "LDNewsCell.h"
#import "LDEmptyCell.h"
#import "NewsModel.h"

@interface NewsViewController ()
<LRCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    LRCycleScrollView *cycleScrollView;
    
    NSMutableDictionary *bean;
    NSMutableArray *dataArr;
    
    NSString *totalCount;
    NSInteger page;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
    bean = [NSMutableDictionary dictionary];
    [bean setValue:@"10" forKey:@"pagesize"];
    [bean setValue:@"1" forKey:@"pagenum"];
    
    page = 1;
    
    [self initTable];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化TableView
-(void)initTable
{
    cycleScrollView = [LRCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlBottomOffset = 20;
    cycleScrollView.infiniteLoop = YES;
    //    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.autoScroll = false;
    
    NSArray *imgURLArr = @[@"http://p1.bqimg.com/567571/bb20a661a0210133.jpg",
                           @"http://p1.bqimg.com/567571/d159dd39c15025ce.jpg",
                           @"http://p1.bpimg.com/567571/1a105a4f6ab5f7ce.jpg"];
    
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithArray:imgURLArr];
    for (NSInteger i=0; i<titleArr.count; i++) {
        NSString *tmp = imgURLArr[i];
        NSString *indexStr = [NSString stringWithFormat:@"%zi/%zi  %@", i+1, titleArr.count, tmp];
        titleArr[i] =indexStr;
        
    }

    
    cycleScrollView.imageURLStringsGroup = imgURLArr;
    cycleScrollView.titlesGroup = titleArr;
    
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.tableHeaderView = cycleScrollView;
    table.tableFooterView = [UIView new];
    //设置拉伸效果必须添加而不是设置tableHeaderView
    //    [table insertSubview:cycleScrollView atIndex:0];
    //    table.contentInset = UIEdgeInsetsMake(imageH, 0, 49, 0);
    //    table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"LDNewsCell" bundle:nil] forCellReuseIdentifier:@"LDNewsCell"];
    [table registerNib:[UINib nibWithNibName:@"LDEmptyCell" bundle:nil] forCellReuseIdentifier:@"LDEmptyCell"];
    
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"MJRefreshHeader");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [table.mj_header endRefreshing];
            
        });
        
    }];
    
    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [table.mj_footer endRefreshing];
            
        });
        
    }];
}

#pragma mark - 加载数据
-(void)loadData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [LSHttpManager requestWithServiceName:@"csitopnews" parameters:bean complete:^(id result, ResultType resultType) {
        
        [hud hideAnimated:true];
        
        NSLog(@"csitopnews ~ %@",result);
        
        if ([result[@"restate"] isEqualToString:@"1"]) {
            
            totalCount = result[@"redatas"][@"endNum"];
            
            id tmpObj = result[@"redatas"][@"result"];
            
            if ([tmpObj isKindOfClass:[NSArray class]]) {
                NSArray *arr = tmpObj;
                for (NSDictionary *dic in arr) {
                    NewsModel *model = [[NewsModel alloc] initWithDict:dic];
                    [dataArr addObject:model];
                }
            }
            
            [table reloadData];
        }
    }];
}


#pragma mark - LRCycleScrollViewDelegate
-(void)cycleScrollView:(LRCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    NSLog(@"Scroll to index ~ %zi",index);
}

-(void)cycleScrollView:(LRCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Click index ~ %zi",index);
}

#pragma mark - TableView Delegate & DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArr.count > 0) {
        return dataArr.count;
    }
    
    else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArr.count > 0) {
        return 100;
    }
    
    else {
        return ScreenHeight-200-49;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArr.count > 0) {
        LDNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDNewsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else {
        LDEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDEmptyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

@end
