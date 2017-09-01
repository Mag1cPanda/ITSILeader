//
//  LRCollectionViewCell.h
//  LRCycleScrollViewDemo
//
//  Created by Mag1cPanda on 2017/2/15.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;

@end
