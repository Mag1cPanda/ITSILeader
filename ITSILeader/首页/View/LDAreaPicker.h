//
//  LDAreaPicker.h
//  ITSILeader
//
//  Created by panshen on 2017/9/4.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDAreaPicker;

@protocol LDAreaPickerDelegate <NSObject>

@optional
/** 取消按钮点击事件*/
- (void)cancelBtnClick;

- (void)pickerView:(LDAreaPicker *)pickerView selectedArea:(NSString *)area;

@end

@interface LDAreaPicker : UIView
<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *picker;

/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<LDAreaPickerDelegate> delegate;

- (void)show;
- (void)hide;

- (instancetype)initWithDataArray:(NSArray *)dataArr;

@end
