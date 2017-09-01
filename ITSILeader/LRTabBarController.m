//
//  LRTabBarController.m
//  CarRecordCarOwner
//
//  Created by Mag1cPanda on 2017/3/14.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "LRTabBarController.h"
#import "LRNavigationController.h"
#import "PersonViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"

@interface LRTabBarController ()


@end

@implementation LRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PersonViewController *vc11 = [PersonViewController new];
    vc11.tabBarItem.title = @"个人";
    vc11.tabBarItem.image = [UIImage imageNamed:@"icon_movie"];
    
    HomeViewController *vc1 = [HomeViewController new];
    vc1.tabBarItem.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"icon_theater"];
    
    NewsViewController *vc2 = [NewsViewController new];
    vc2.tabBarItem.title = @"工作动态";
    vc2.tabBarItem.image = [UIImage imageNamed:@"icon_found"];
    
    MineViewController *vc3 = [MineViewController new];
    vc3.tabBarItem.title = @"我的";
    vc3.tabBarItem.image = [UIImage imageNamed:@"icon_mine"];
    
    
    LRNavigationController *nav1;
    if ([Globle getInstance].userType == 0) {
        nav1 = [[LRNavigationController alloc] initWithRootViewController:vc11];
    }
    
    else {
        nav1 = [[LRNavigationController alloc] initWithRootViewController:vc1];
    }
    
    LRNavigationController *nav2 = [[LRNavigationController alloc] initWithRootViewController:vc2];
    
    LRNavigationController *nav3 = [[LRNavigationController alloc] initWithRootViewController:vc3];
    
    self.viewControllers = @[nav1, nav2, nav3];
    

}


@end
