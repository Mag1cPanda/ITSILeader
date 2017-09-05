//
//  LDAreaPicker.m
//  ITSILeader
//
//  Created by panshen on 2017/9/4.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "LDAreaPicker.h"
#define TitleColor RGB(19, 125, 252)
static CGFloat const TITLEHEIGHT = 50.0;
static CGFloat const TITLEBUTTONWIDTH = 75.0;

@interface LDAreaPicker ()

@property (nonatomic ,strong) UIButton * cancelBtn;/**< 取消按钮*/
@property (nonatomic, strong) UIButton * sureBtn;/**< 完成按钮*/
@property (nonatomic, strong) NSArray * areaArr;/**< 完成按钮*/

@end

@implementation LDAreaPicker

- (instancetype)initWithDataArray:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        self.areaArr = dataArr;
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 220);
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:
                      CGRectMake(0, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_cancelBtn setTitle:@"取消"
                    forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:TitleColor
                         forState:UIControlStateNormal];
        [_cancelBtn addTarget:self
                       action:@selector(cancelBtnClicked)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        
        _sureBtn = [[UIButton alloc]initWithFrame:
                    CGRectMake(ScreenWidth - TITLEBUTTONWIDTH, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_sureBtn setTitle:@"完成"
                  forState:UIControlStateNormal];
        [_sureBtn setTitleColor:TitleColor
                       forState:UIControlStateNormal];
        [_sureBtn addTarget:self
                     action:@selector(sureBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureBtn];
        
        _picker = [[UIPickerView alloc] initWithFrame:
                              CGRectMake(0, TITLEHEIGHT, ScreenWidth, 180)];
        _picker.backgroundColor = RGB(239, 239, 244);
        _picker.showsSelectionIndicator = YES;
        _picker.delegate = self;
        _picker.dataSource = self;
        [self addSubview:_picker];
    }
    return self;
}

- (void)show{
    [self showOrHide:YES];
}

- (void)hide{
    [self showOrHide:NO];
}

- (void)showOrHide:(BOOL)isShow{
    
    CGFloat selfY = self.frame.origin.y;
    __block CGFloat selfkY = selfY;
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        
        if (isShow) {
            selfkY = [UIScreen mainScreen].bounds.size.height - 220;
        }
        else {
            selfkY = [UIScreen mainScreen].bounds.size.height;
        }
        self.frame = CGRectMake(0,selfkY, self.bounds.size.width,220);
        
        [UIView commitAnimations];
    }];
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClicked{
    [self hide];
}

- (void)sureBtnClicked
{
    [_delegate pickerView:self selectedArea:self.areaArr[[_picker selectedRowInComponent:0]]];
    [self hide];
}

#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return _areaArr.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return _areaArr[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    
}


@end
