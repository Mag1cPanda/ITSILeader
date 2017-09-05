//
//  LDManagerCell.m
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "LDManagerCell.h"

@implementation LDManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LDManagerModel *)model
{
    _model = model;
    
    _name.text = model.name;
    _enterpriseName.text = model.enterprisename;
    _regNum.text = model.qcertificatenum;
    _regDate.text = model.approvaltime;
    _verDate.text = model.avaidate;
    _area.text = model.areacn;
    _remarks.text = model.remarks;
    
}

@end
