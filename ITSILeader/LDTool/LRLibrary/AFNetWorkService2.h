//
//  AFNetWorkServicePolice.h
//  ShangHaiPolice
//
//  Created by 程三 on 16/8/9.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkService.h"
#import <UIKit/UIKit.h>

@interface AFNetWorkService2 : AFNetWorkService

@property(nonatomic,assign)BOOL showNotice;

-(void)requestWithServiceIP2:(NSString *)serviceIP ServiceName:(NSString *)serviceName params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod resultIsDictionary:(BOOL)resultIsDictionary completeBlock:(RequestCompelete2)block2;

+ (AFNetWorkService2 *)getAFNetWorkService2;

@end
