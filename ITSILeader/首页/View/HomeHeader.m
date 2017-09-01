//
//  HomeHeader.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "HomeHeader.h"

@implementation HomeHeader

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.noticeLab animationWithTexts:@[@"这是第1条",@"这是第2条",@"这是第3条"]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"HomeHeader" owner:self options:nil][0];
    }
    return self;
}

@end
