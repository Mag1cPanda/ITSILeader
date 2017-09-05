//
//  BaseModel.m
//  ITSILeader
//
//  Created by panshen on 2017/9/1.
//  Copyright © 2017年 panshen. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"forUndefinedKey -> %@",key);
}



-(instancetype)initWithDict:(NSDictionary *)dic{
    [self setValuesForKeysWithDictionary:dic];
    return self;
}

@end
