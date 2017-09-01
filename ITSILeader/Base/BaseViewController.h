//
//  BaseViewController.h
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIButton *backBtn;

/** 导航条View */
@property (nonatomic, strong) UIImageView *navBarView;

-(void)backAction;

@end
