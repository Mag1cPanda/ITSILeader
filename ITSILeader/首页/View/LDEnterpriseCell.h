//
//  LDEnterpriseCell.h
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDEnterpriseModel.h"

@interface LDEnterpriseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLab;


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *cerNum;
@property (weak, nonatomic) IBOutlet UILabel *cerDate;
@property (weak, nonatomic) IBOutlet UILabel *verDate;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *area;

@property (nonatomic, strong) LDEnterpriseModel *model;

@end
