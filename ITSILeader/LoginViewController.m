//
//  LoginViewController.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "LoginViewController.h"
#import "LRTabBarController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClicked:(id)sender {
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [hud hideAnimated:YES];
    
        [Globle getInstance].userType = 1;
        
        LRTabBarController *vc = [LRTabBarController new];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCATransitionReveal;
        [self.view.window.layer addAnimation:transition forKey:@"animation"];
        
        self.view.window.rootViewController = vc;
        
        //修改根控制器时，注意内存，以免泄露
        //如果是设置页面点击退出按钮present过来的必须dismiss
        //如果不dismiss掉 ，则settingVC不会被释放，栈顶元素无法被释放，栈顶下面的控制器都无法释放。
        /*
         1.动画状态必须关闭，根控制器的切换与dismisse的动画同时进行会给用户带来较差的体验效果。
         2在项目开发中，只要有present出来的控制器，一定要有对应的dismiss，否则项目中会存在无法估量的bug
         */
        if (_isLogout) {
            NSLog(@"dismiss");
            [self.navigationController dismissViewControllerAnimated:false completion:nil];
        }
    
//    });
    
}


@end
