//
//  LDManagerModel.h
//  ITSILeader
//
//  Created by panshen on 2017/9/5.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "BaseModel.h"

@interface LDManagerModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *enterprisename;
@property (nonatomic, copy) NSString *qcertificatenum;
@property (nonatomic, copy) NSString *approvaltime;
@property (nonatomic, copy) NSString *avaidate;
@property (nonatomic, copy) NSString *areacn;
@property (nonatomic, copy) NSString *remarks;

@end
