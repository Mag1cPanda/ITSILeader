//
//  EnterpriseSearchVC.h
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^SearchBlock) (NSString *name, NSString *level, NSString *area, NSString *date);

@interface EnterpriseSearchVC : BaseViewController

@property (nonatomic, copy) SearchBlock block;

@end
