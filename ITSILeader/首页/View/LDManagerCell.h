//
//  LDManagerCell.h
//  ITSILeader
//
//  Created by panshen on 2017/9/3.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDManagerModel.h"

@interface LDManagerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLab;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;

@property (weak, nonatomic) IBOutlet UILabel *regNum;

@property (weak, nonatomic) IBOutlet UILabel *regDate;

@property (weak, nonatomic) IBOutlet UILabel *verDate;

@property (weak, nonatomic) IBOutlet UILabel *area;

@property (weak, nonatomic) IBOutlet UILabel *remarks;

@property (nonatomic, strong) LDManagerModel *model;

@end
