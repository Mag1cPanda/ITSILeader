//
//  Globle.h
//  TBRJL
//
//  Created by 程三 on 15/6/13.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globle : NSObject

@property (nonatomic, copy) NSString *inscompany;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *userflag;
@property (nonatomic, copy) NSString *fullname;
@property (nonatomic, copy) NSString *mobilephone;
@property (nonatomic, copy) NSString *currenttime;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *usercode;
@property (nonatomic, copy) NSString *areaid;

+(Globle *)getInstance;

@end
