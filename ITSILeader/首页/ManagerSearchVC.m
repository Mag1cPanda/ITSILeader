//
//  ManagerSearchVC.m
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "ManagerSearchVC.h"
#import "LDTextField.h"
@interface ManagerSearchVC ()

@property (weak, nonatomic) IBOutlet LDTextField *name;

@property (weak, nonatomic) IBOutlet LDTextField *enterpriseName;

@property (weak, nonatomic) IBOutlet UIButton *area;

@property (weak, nonatomic) IBOutlet UIButton *date;


@end

@implementation ManagerSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmBtnClicked:(id)sender {
    
    NSString *str1 = _name.field.text ? _name.field.text : @"";
    NSString *str2 = _enterpriseName.field.text ? _enterpriseName.field.text : @"";
    NSString *str3 = _area.titleLabel.text ? _area.titleLabel.text : @"";
    NSString *str4 = _date.titleLabel.text ? _date.titleLabel.text : @"";
    
    if (_block) {
        _block(str1, str2, str3, str4);
    }
}

- (IBAction)resetBtnClicked:(id)sender {
    _name.field.text = @"";
    _enterpriseName.field.text = @"";
    [_area setTitle:@"" forState:0];
    [_date setTitle:@"" forState:0];
    
}



@end
