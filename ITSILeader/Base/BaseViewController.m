//
//  BaseViewController.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *navBarView = [[UIImageView alloc] init];
    navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    navBarView.image = [UIImage imageNamed:@"navbar"];
    navBarView.backgroundColor = [UIColor orangeColor];
    [self.view insertSubview:navBarView atIndex:0];//放入栈顶
    self.navBarView = navBarView;
    
    
    NSArray *arr = self.navigationController.viewControllers;
    if (arr.count > 1)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, 44, 44);
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:1 << 6];
        
        [_backBtn setImage:[UIImage imageNamed:@"backbtn"] forState:0];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
        self.navigationItem.leftBarButtonItem = item;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

#pragma mark - 返回按钮点击事件（返回首页）
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
