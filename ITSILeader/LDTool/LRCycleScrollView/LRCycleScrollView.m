//
//  LRCycleScrollView.m
//  LRCycleScrollViewDemo
//
//  Created by Mag1cPanda on 2017/2/15.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "LRCycleScrollView.h"
#import "LRCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "TAPageControl.h"

#define kLRPageControlDotSize CGSizeMake(10, 10)

static NSString *cellID = @"cycleCellID";

@interface LRCycleScrollView ()

@property (nonatomic, strong) NSArray *imagePathsGroup;

@end

@implementation LRCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _pageControlAliment = LRPageControlAlignmentCenter;
    _autoScrollTimeInterval = 2.0;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = YES;
    _pageControlDotSize = kLRPageControlDotSize;
    _pageControlBottomOffset = 0;
    _pageControlRightOffset = 0;
    _pageControlStyle = LRPageContolStyleClassic;
    _hidesForSinglePage = YES;
    _currentPageDotColor = [UIColor whiteColor];
    _pageDotColor = [UIColor lightGrayColor];
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[LRCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
}

+(instancetype)cycleScrollViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage
{
    LRCycleScrollView *cycle = [[self alloc] initWithFrame:frame];
    cycle.placeholderImage = placeholderImage;
    return cycle;
}

#pragma mark - properties

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:mainView];
        backgroundImageView = bgImageView;
    }
    
    backgroundImageView.image = placeholderImage;
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    [self setupPageControl];
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageContol = (TAPageControl *)pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    pageControl.hidden = !showPageControl;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *customPageControl = (TAPageControl *)pageControl;
        customPageControl.dotColor = currentPageDotColor;
    } else {
        UIPageControl *defaultPageControl = (UIPageControl *)pageControl;
        defaultPageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }
    
}

- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    
    if ([pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *defaultPageControl = (UIPageControl *)pageControl;
        defaultPageControl.pageIndicatorTintColor = pageDotColor;
    }
}

- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    
    if (self.pageControlStyle != LRPageContolStyleAnimated) {
        self.pageControlStyle = LRPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}

- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    
    if (self.pageControlStyle != LRPageContolStyleAnimated) {
        self.pageControlStyle = LRPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}

- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !pageControl) return;
    
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *customPageControl = (TAPageControl *)pageControl;
        if (isCurrentPageDot) {
            customPageControl.currentDotImage = image;
        } else {
            customPageControl.dotImage = image;
        }
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (_imagePathsGroup.count) {
        self.imagePathsGroup = _imagePathsGroup;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    flowLayout.scrollDirection = scrollDirection;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageControlStyle:(LRPageControlStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    
    [self setupPageControl];
}

-(void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTimer];
    
    _imagePathsGroup = imagePathsGroup;
    
    totalItemsCount = self.infiniteLoop ? imagePathsGroup.count * 100 : imagePathsGroup.count;
    
    if (imagePathsGroup.count != 1) {
        mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        mainView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [mainView reloadData];
}


- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObject:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
}

-(void)setLocalImageNamesGroup:(NSArray *)localImageNamesGroup
{
    _localImageNamesGroup = localImageNamesGroup;
    self.imagePathsGroup = [localImageNamesGroup copy];
}

- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup
{
    localizationImageNamesGroup = localizationImageNamesGroup;
    self.imagePathsGroup = [localizationImageNamesGroup copy];
}

- (void)setTitlesGroup:(NSArray *)titlesGroup
{
    _titlesGroup = titlesGroup;
    if (self.onlyDisplayText) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < _titlesGroup.count; i++) {
            [temp addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.imageURLStringsGroup = [temp copy];
    }
}



#pragma mark - public actions

- (void)adjustWhenControllerViewWillAppera
{
    long targetIndex = [self currentIndex];
    if (targetIndex < totalItemsCount) {
        [mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}


#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    flowLayout.itemSize = self.frame.size;
    
    mainView.frame = self.bounds;
    if (mainView.contentOffset.x == 0 &&  totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *customPageControl = (TAPageControl *)pageControl;
        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kLRPageControlDotSize, self.pageControlDotSize))) {
            customPageControl.dotSize = self.pageControlDotSize;
        }
        size = [customPageControl sizeForNumberOfPages:_imagePathsGroup.count];
        
    } else {
        size = CGSizeMake(_imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    CGFloat x = (self.frame.size.width - size.width) * 0.5;
    if (self.pageControlAliment == LRPageControlAlignmentRight) {
        x = mainView.frame.size.width - size.width - 10;
    }
    CGFloat y = mainView.frame.size.height - size.height - 10;
    
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *customPageControl = (TAPageControl *)pageControl;
        [customPageControl sizeToFit];
    }
    
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    pageControlFrame.origin.y -= self.pageControlBottomOffset;
    pageControlFrame.origin.x -= self.pageControlRightOffset;
    pageControl.frame = pageControlFrame;
    pageControl.hidden = !_showPageControl;
    
    if (backgroundImageView) {
        backgroundImageView.frame = self.bounds;
    }
    
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    mainView.delegate = nil;
    mainView.dataSource = nil;
}

#pragma mark - actions

- (void)setupTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [timer invalidate];
    timer = nil;
}

- (void)setupPageControl
{
    if (pageControl) [pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if (_imagePathsGroup.count == 0 || self.onlyDisplayText) return;
    
    if ((_imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
    
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    
    switch (self.pageControlStyle) {
        case LRPageContolStyleAnimated:
        {
            TAPageControl *animatedaPageControl = [[TAPageControl alloc] init];
            animatedaPageControl.numberOfPages = _imagePathsGroup.count;
            animatedaPageControl.dotColor = self.currentPageDotColor;
            animatedaPageControl.userInteractionEnabled = NO;
            animatedaPageControl.currentPage = indexOnPageControl;
            [self addSubview:animatedaPageControl];
            pageControl = animatedaPageControl;
        }
            break;
            
        case LRPageContolStyleClassic:
        {
            UIPageControl *classicPageControl = [[UIPageControl alloc] init];
            classicPageControl.numberOfPages = _imagePathsGroup.count;
            classicPageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            classicPageControl.pageIndicatorTintColor = self.pageDotColor;
            classicPageControl.userInteractionEnabled = NO;
            classicPageControl.currentPage = indexOnPageControl;
            [self addSubview:classicPageControl];
            pageControl = classicPageControl;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pagecontroldot图片
    if (self.currentPageDotImage) {
        self.currentPageDotImage = self.currentPageDotImage;
    }
    if (self.pageDotImage) {
        self.pageDotImage = self.pageDotImage;
    }
}


- (void)automaticScroll
{
    if (0 == totalItemsCount) return;
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(NSInteger)targetIndex
{
    if (targetIndex >= totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = totalItemsCount * 0.5;
            [mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (NSInteger)currentIndex
{
    if (mainView.frame.size.width == 0 || mainView.frame.size.height == 0) {
        return 0;
    }
    
    NSInteger index = 0;
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width;
    } else {
        index = (mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (NSInteger)index % _imagePathsGroup.count;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    NSString *imagePath = _imagePathsGroup[itemIndex];
    
    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [cell.imageView sd_setImageWithURL:imagePath placeholderImage:self.placeholderImage];
        } else {
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.imageView.image = image;
        }
    } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (_titlesGroup.count && itemIndex < _titlesGroup.count) {
        cell.title = _titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
        cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
        cell.onlyDisplayText = self.onlyDisplayText;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
    
    if (self.clickHandle) {
        self.clickHandle([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    NSInteger itemIndex = [self currentIndex];
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *customPageControl = (TAPageControl *)pageControl;
        customPageControl.currentPage = indexOnPageControl;
    }
    
    else {
        UIPageControl *defaultPageControl = (UIPageControl *)pageControl;
        defaultPageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:mainView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!_imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    NSInteger itemIndex = [self currentIndex];
    NSInteger indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
        [self.delegate cycleScrollView:self didScrollToIndex:indexOnPageControl];
    }
    
    if (self.scrollHandle) {
        self.scrollHandle(indexOnPageControl);
    }
}

@end
