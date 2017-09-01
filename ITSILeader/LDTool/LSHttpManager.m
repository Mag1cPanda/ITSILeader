//
//  LSHttpManager.m
//  CarRecord_Longrise
//
//  Created by Mag1cPanda on 16/6/8.
//  Copyright © 2016年 Mag1cPanda. All rights reserved.
//

#import "LSHttpManager.h"

@implementation LSHttpManager
+ (void)requestWithServiceName:(NSString *)serviceName parameters:(NSMutableDictionary *)parameters complete:(CompleteBlock)block
{
    [AFNetWorkServiceCar getAFNetWorkServiceCar].showNotice = NO;

    [[AFNetWorkServiceCar getAFNetWorkServiceCar] requestWithServiceIP2:LRServiceIP ServiceName:serviceName params:parameters httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result, ResultType resultType) {

        if (resultType == -1) {
            NSLog(@"LSHttpManager ~ 无法访问服务器");
        }
        
        if (resultType == 0) {
            NSLog(@"失败");
        }
        
        if (resultType == 1) {
            
            if ([result[@"restate"] isEqualToString:@"-4"]) {
                [Util showMessage:result[@"redes"]];
                return ;
            }
            
            block(result, resultType);
        } 

    }];
}
@end
