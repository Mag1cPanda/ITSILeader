//
//  EnterpriseSearchVC.m
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "EnterpriseSearchVC.h"
#import "LDTextField.h"
#import "LDAreaPicker.h"
#import "WSDatePickerView.h"

@interface EnterpriseSearchVC ()
<LDAreaPickerDelegate>
{
    LDAreaPicker *areaPicker;
    LDAreaPicker *levelPicker;
}

@property (weak, nonatomic) IBOutlet LDTextField *name;
@property (weak, nonatomic) IBOutlet UIButton *level;
@property (weak, nonatomic) IBOutlet UIButton *area;
@property (weak, nonatomic) IBOutlet UIButton *date;


@end

@implementation EnterpriseSearchVC

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [areaPicker hide];
    [levelPicker hide];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _level.titleLabel.textAlignment = NSTextAlignmentLeft;
    _area.titleLabel.textAlignment = NSTextAlignmentLeft;
    _date.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    NSArray *areaArr = @[@"北京",@"天津",@"上海",@"重庆",@"青岛",@"深圳",@"大连",@"厦门",@"宁波",@"河北",@"山西",@"辽宁",@"吉林",@"黑龙江",@"江苏",@"浙江",@"安徽",@"福建",@"江西",@"山东",@"河南",@"湖北",@"湖南",@"广东",@"海南",@"四川",@"贵州",@"云南",@"陕西",@"甘肃",@"青海",@"内蒙古",@"广西",@"西藏",@"宁夏",@"新疆维吾尔自治区"];
    areaPicker = [[LDAreaPicker alloc] initWithDataArray:areaArr];
    areaPicker.delegate = self;
    
    NSArray *levelArr = @[@"一级",@"二级",@"三级",@"四级"];
    levelPicker = [[LDAreaPicker alloc] initWithDataArray:levelArr];
    levelPicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmBtnClicked:(id)sender {
    
    NSString *str1 = _name.field.text ? _name.field.text : @"";
    NSString *str2 = _level.titleLabel.text ? _level.titleLabel.text : @"";
    NSString *str3 = _area.titleLabel.text ? _area.titleLabel.text : @"";
    NSString *str4 = _date.titleLabel.text ? _date.titleLabel.text : @"";
    
    if (_block) {
        _block(str1, str2, str3, str4);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetBtnClicked:(id)sender {
    _name.field.text = @"";
    [_level setTitle:@"" forState:0];
    [_area setTitle:@"" forState:0];
    [_date setTitle:@"" forState:0];
}

- (IBAction)levelBtnClicked:(id)sender {
    [levelPicker show];
}

- (IBAction)areaBtnClicked:(id)sender {
    [areaPicker show];
}

- (IBAction)dateBtnClicked:(id)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        NSLog(@"时间： %@",date);
        
        [_date setTitle:date forState:0];
    }];
    datepicker.doneButtonColor = RGB(239, 124, 88);//确定按钮的颜色
    [datepicker show];
}


#pragma mark - LDAreaPickerDelegate
-(void)pickerView:(LDAreaPicker *)pickerView selectedArea:(NSString *)area
{
    if (pickerView == areaPicker) {
        [_area setTitle:area forState:0];
    }
    
    else {
        [_level setTitle:area forState:0];
    }
}



@end
