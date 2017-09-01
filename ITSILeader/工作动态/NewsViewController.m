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

@interface NewsViewController ()
<LRCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    LRCycleScrollView *cycleScrollView;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化TableView
-(void)initTable
{
    cycleScrollView = [LRCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) placeholderImage:[UIImage imageNamed:@"slide_img"]];
    cycleScrollView.delegate = self;
    //    cycleScrollView.pageControlBottomOffset = 30;
    cycleScrollView.infiniteLoop = YES;
    //    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.autoScroll = false;
    
    NSArray *imgURLArr = @[@"http://p1.bqimg.com/567571/bb20a661a0210133.jpg",
                           @"http://p1.bqimg.com/567571/d159dd39c15025ce.jpg",
                           @"http://p1.bpimg.com/567571/1a105a4f6ab5f7ce.jpg"];
    
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithArray:imgURLArr];
    for (NSInteger i=0; i<titleArr.count; i++) {
        NSString *tmp = imgURLArr[i];
        NSString *indexStr = [NSString stringWithFormat:@"%zi/%zi %@", i, titleArr.count, tmp];
        titleArr[i] =indexStr;
        
    }

    
    cycleScrollView.imageURLStringsGroup = imgURLArr;
    cycleScrollView.titlesGroup = titleArr;
    
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.tableHeaderView = cycleScrollView;
    //设置拉伸效果必须添加而不是设置tableHeaderView
    //    [table insertSubview:cycleScrollView atIndex:0];
    //    table.contentInset = UIEdgeInsetsMake(imageH, 0, 49, 0);
    //    table.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [self.view addSubview:table];
    
    //    [table registerClass:[HomeSectionZero class] forCellReuseIdentifier:@"HomeSectionZero"];
    
    [table registerNib:[UINib nibWithNibName:@"HomeSectionOne" bundle:nil] forCellReuseIdentifier:@"HomeSectionOne"];
    [table registerNib:[UINib nibWithNibName:@"HomeSectionTwo" bundle:nil] forCellReuseIdentifier:@"HomeSectionTwo"];
    
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
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDNewsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
