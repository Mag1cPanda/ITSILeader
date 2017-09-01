//
//  Globle.h
//  TBRJL
//
//  Created by 程三 on 15/6/13.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globle : NSObject

@property (nonatomic, copy) NSString *userflag;
@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) NSInteger userType;

+(Globle *)getInstance;

@end
