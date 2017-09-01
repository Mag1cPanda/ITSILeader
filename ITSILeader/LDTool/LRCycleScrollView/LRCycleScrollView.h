//
//  LRCycleScrollView.h
//  LRCycleScrollViewDemo
//
//  Created by Mag1cPanda on 2017/2/15.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LRCycleScrollView;

/**
 图片点击事件

 @param currentIndex 当前序号
 */
typedef void (^clickItemHandle)(NSInteger currentIndex);


/**
 ScrollView滚动事件

 @param currentIndex 当前序号
 */
typedef void (^itemDidScrollHandle)(NSInteger currentIndex);


typedef NS_ENUM(NSInteger, LRPageControlStyle) {
    LRPageContolStyleClassic = 0,
    LRPageContolStyleAnimated = 1,
    LRPageContolStyleNone = 2
};

/**
 PageControl对齐方式

 - LRPageControlAlignmentCenter: 中
 - LRPageControlAlignmentRight: 右
 */
typedef NS_ENUM(NSInteger, LRPageControlAlignment) {
    LRPageControlAlignmentCenter = 0,
    LRPageControlAlignmentRight = 1
};

@protocol LRCycleScrollViewDelegate <NSObject>

@optional

/**
 图片点击代理方法

 @param cycleScrollView 当前cycleScrollView
 @param index 当前序号
 */
- (void)cycleScrollView:(LRCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;


/**
 ScrollView滚动代理方法

 @param cycleScrollView 当前cycleScrollView
 @param index 当前序号
 */
- (void)cycleScrollView:(LRCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

@end

@interface LRCycleScrollView : UIView
<UICollectionViewDataSource,
UICollectionViewDelegate>
{
    UICollectionView *mainView;
    UICollectionViewFlowLayout *flowLayout;
    NSTimer *timer;
    NSInteger totalItemsCount;
    UIControl *pageControl;//有三种样式
    
    UIImageView *backgroundImageView;
}

/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;

/** 本地图片数组 */
@property (nonatomic, strong) NSArray *localImageNamesGroup;


/** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;

/** pagecontrol 样式，默认为动画样式 */
@property (nonatomic, assign) LRPageControlStyle pageControlStyle;

/** 分页控件位置 */
@property (nonatomic, assign) LRPageControlAlignment pageControlAliment;

/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlBottomOffset;

/** 分页控件距离轮播图的右边间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlRightOffset;

/** 分页控件小圆标大小 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/** 其他分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *pageDotImage;

/** 轮播文字label字体颜色 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;

/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;

/** 轮播文字label背景颜色 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;

/** 轮播文字label高度 */
@property (nonatomic, assign) CGFloat titleLabelHeight;



/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, weak) id<LRCycleScrollViewDelegate> delegate;

/** block方式监听点击 */
@property (nonatomic, copy) clickItemHandle clickHandle;

/** block方式监听滚动 */
@property (nonatomic, copy) itemDidScrollHandle scrollHandle;

/**
 初始化方法

 @param frame 坐标大小
 @param placeholderImage 占位图
 @return 实例对象
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage;

@end
