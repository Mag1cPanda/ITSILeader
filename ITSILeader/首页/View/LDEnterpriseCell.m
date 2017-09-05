//
//  LDEnterpriseCell.m
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "LDEnterpriseCell.h"

@implementation LDEnterpriseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LDEnterpriseModel *)model
{
    _model = model;
    
    _name.text = model.enterprisename;
    _cerNum.text = model.qcertificatenum;
    _cerDate.text = model.firstcertificationdate;
    _verDate.text = model.approvaldate;
    
    if ([model.qualificationlevel isEqualToString:@"1"]) {
        _level.text = @"一级";
    }
    
    if ([model.qualificationlevel isEqualToString:@"2"]) {
        _level.text = @"二级";
    }
    
    if ([model.qualificationlevel isEqualToString:@"3"]) {
        _level.text = @"三级";
    }
    
    if ([model.qualificationlevel isEqualToString:@"4"]) {
        _level.text = @"四级";
    }
    
    _area.text = model.areacn;
    
    
}

@end
