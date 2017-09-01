//
//  HomeHeader.h
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYChangeTextView.h"

@interface HomeHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet GYChangeTextView *noticeLab;

@property (weak, nonatomic) IBOutlet UIButton *qrBtn;


@end
