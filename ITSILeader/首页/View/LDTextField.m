//
//  LDTextField.m
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "LDTextField.h"

@implementation LDTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup
{
    _field = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 30)];
    _field.textAlignment = NSTextAlignmentLeft;
    _field.font = LRFont(14);
    _field.textColor = RGB(19, 125, 252);//System Blue
    [self addSubview:_field];
}

@end
