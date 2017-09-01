//
//  Util.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Util.h"

#define DEVICE_TOKEN_KEY @"RemoteDeviceToken"

@implementation Util

#pragma mark 系统版本
+(float)getVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
#pragma mark 状态栏高度
+(CGFloat)getStatusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark 导航栏高度
+(CGFloat)getnavigationBarHeight:(UINavigationController *)nav
{
    if(nil == nav)
    {
        return 0;
    }
    return nav.navigationBar.frame.size.height;
}

#pragma mark 导航栏高度和状态栏的总高度
+(CGFloat)getStatusBarAndNavigationBarHeight:(UINavigationController *)nav
{
    if(nil == nav)
    {
        return 0;
    }
    
    return nav.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}


#pragma mark 图片缩放
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

#pragma mark 图片的旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    /*
     typedef enum {
     UIImageOrientationUp,
     UIImageOrientationDown ,   // 180 deg rotation
     UIImageOrientationLeft ,   // 90 deg CW
     UIImageOrientationRight ,   // 90 deg CCW
     UIImageOrientationUpMirrored ,    // as above but image mirrored along
     // other axis. horizontal flip
     UIImageOrientationDownMirrored ,  // horizontal flip
     UIImageOrientationLeftMirrored ,  // vertical flip
     UIImageOrientationRightMirrored , // vertical flip
     } UIImageOrientation;
     */
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

#pragma mark 根据格式获取当前时间
+(NSString *)getCurrentTimeByFormal:(NSString *)formal
{
    NSString *time = nil;
    if(nil != formal && ![@"" isEqualToString:formal])
    {
        NSDateFormatter *formateter = [[NSDateFormatter alloc] init];
        [formateter setDateFormat:formal];
        time = [formateter stringFromDate:[NSDate date]];
    }
    return time;
}

#pragma mark 获取图片的大小（单位为K）
+(NSNumber *)getImageBig:(UIImage *)image
{
    if(image == nil)
    {
        return nil;
    }
    return [[NSNumber alloc] initWithDouble:UIImagePNGRepresentation(image).length/1000];
}


#pragma mark - 16进制颜色
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

#pragma mark 获取设备名称
+(NSString *)getCurrentDeviceName
{
    return [UIDevice currentDevice].name;
}

#pragma mark 获取唯一标识符
+(NSString *)getIdentifierForVendor
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

#pragma mark - JSON字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark 将字典写入文件中
+(BOOL)dicWrite2File:(NSString *)dicPath fileName:(NSString *)fileName dic:(NSDictionary *)dic
{
    BOOL b = false;
    if(dicPath == nil || [@"" isEqualToString:dicPath] || dic == nil || fileName == nil || [@"" isEqualToString:fileName])
    {
        return b;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断目录是否存在
    if(![fileManager fileExistsAtPath:dicPath])
    {
        //不存在就创建
        BOOL ceaterSuccess = [fileManager createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:NULL];
        if(!ceaterSuccess)
        {
            return b;
        }
    }
    
    NSString *fullPath = [dicPath stringByAppendingPathComponent:fileName];
    //判断文件是否存在
    if([fileManager fileExistsAtPath:fullPath])
    {
        //存在删除
        BOOL delSuccess = [fileManager removeItemAtPath:fullPath error:nil];
        if(!delSuccess)
        {
            return b;
        }
    }
    
    //创建文件
    BOOL createBool = [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    if(!createBool)
    {
        return b;
    }
    
    //写入
    b = [dic writeToFile:fullPath atomically:YES];
    
    return b;

}

#pragma mark 获取当前时间戳
+(long)getCurrentTime
{
    NSDate *localDate = [NSDate date]; //获取当前时间
    return (long)[localDate timeIntervalSince1970];
}

#pragma mark - 转JSON
+ (NSString*)objectToJson:(NSObject *)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark 判断一个字符串是否全部为数字
+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 车牌号正则验证
+ (BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

#pragma mark - 验证身份证是否合法
+(NSString *)changeIdcardNumber:(NSString *)value
{
    NSInteger length = [value length];
    if (length == 15 ) {
        NSString *a =  [NSString stringWithFormat:@"%c",[value characterAtIndex:14]];
        NSString *b = [value substringToIndex:14];
        if ([a isEqualToString:@"x"]) {
            value = [NSString stringWithFormat:@"%@%@",b,@"X"];
        }
        
    }
    else if (length == 18 ) {
        NSString *a =  [NSString stringWithFormat:@"%c",[value characterAtIndex:17]];
        NSString *b = [value substringToIndex:17];
        if ([a isEqualToString:@"x"]) {
            value = [NSString stringWithFormat:@"%@%@",b,@"X"];
        }
        
    }
    return value;
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [self changeIdcardNumber:value];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    
    if (!value) {
        
        return NO;
        
    }else {
        
        length = value.length;
        
        if (length !=18) {
            return NO;
        }
        
    }
    // 省份代码
    
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag =NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
    }
    
    if (!areaFlag) {
        
        return false;
        
    }
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    int year =0;
    
    switch (length) {
            
        case 15:
            
        {
            year = [[value substringWithRange:NSMakeRange(6,2)]intValue]+1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                
                return YES;
                
            }else {
                
                return NO;
            }
        }
        case 18:
        {
            year =(int) [[value substringWithRange:NSMakeRange(6,4)] integerValue];
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                        options:NSRegularExpressionCaseInsensitive
                                     
                                                                          error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                
                NSString *M =@"F";
                
                NSString *JYM =@"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
            }else {
                
                return NO;
                
            }
        }
            
        default:
            
            return false;
    }
    
}

#pragma mark 设置UITextField距离左边的距离
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

#pragma mark - 根据字符串计算size
+(CGSize)sr_DrawTextRectWithString:(NSString *)text Width:(CGFloat)width FondSize:(CGFloat)fontSize{
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                     context:nil].size;
    return size;
}

#pragma mark - imageToString
+(NSString *)imageToString:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString * encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    return encodedImageStr;
}

#pragma mark - 图片拉伸
+(UIImage *)stretchImage:(UIImage *)image top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left resizingMode:(UIImageResizingMode)resizingMode
{
    if(nil == image)
    {
        return nil;
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    /*
     UIImageResizingMode:拉伸模式
     UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
     UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
     */
    return [image resizableImageWithCapInsets:insets resizingMode:resizingMode];
}

#pragma mark - 绘制虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


#pragma mark - 字符串转图片
+(UIImage *)stringToImage:(NSString *)encodedImageStr
{
    
    NSData *decodedImageData   = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSData *decodedImageData   = [[NSData alloc] initWithBase64Encoding:encodedImageStr];
    UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}


#pragma mark - UserDefaultsUtil
+(void)saveNSUserDefaultsForInteger:(NSInteger)value forKey:(NSString *)key
{
    [LRUserDefaults setInteger:value forKey:key];
}

+(void)saveNSUserDefaultsForFloat:(float)value forKey:(NSString *)key
{
    [LRUserDefaults setFloat:value forKey:key];
}

+(void)saveNSUserDefaultsForDouble:(double)value forKey:(NSString *)key
{
    [LRUserDefaults setDouble:value forKey:key];
}

+(void)saveNSUserDefaultsForBOOL:(BOOL)value forKey:(NSString *)key
{
    [LRUserDefaults setBool:value forKey:key];
}

+(void)saveNSUserDefaultsForObject:(id)value forKey:(NSString *)key
{
    [LRUserDefaults setObject:value forKey:key];
}

+(id)getDataForKey:(NSString *)key
{
    return  [LRUserDefaults objectForKey:key];
}

+(void)removeAllUserDefaults{
    NSDictionary *userDic = [LRUserDefaults dictionaryRepresentation];
    for (NSString *key in [userDic allKeys]) {
        [LRUserDefaults removeObjectForKey:key];
    }
    [LRUserDefaults synchronize];
}

#pragma mark 保存deviceToken
+(NSString *)saveDeviceToken:(NSData *)data
{
    NSString *deviceToken = nil;
    if(data)
    {
        deviceToken = [[[[data description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        //保存到本地
        [Util saveNSUserDefaultsForObject:deviceToken forKey:DEVICE_TOKEN_KEY];
    }

    return deviceToken;
}

#pragma mark 获取deviceToken
+(NSString *)getDeviceToken
{
    return [Util getDataForKey:DEVICE_TOKEN_KEY];
}


#pragma mark - 正则验证用户名和密码
+ (BOOL)checkPassWordRationality:(NSString *)rationalityString
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z_]{6,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [predicate evaluateWithObject:rationalityString];
    return isMatch;
}

#pragma mark - HUD
+ (void)showHudWithView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)timeInterval
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:false];
    hud.mode = MBProgressHUDModeText;
    
    //文字较长时改为detailsLabel显示  并延长一秒的显示时间
    if (message.length > 15) {
        hud.detailsLabel.text = message;
        [hud hideAnimated:false afterDelay:timeInterval+1];
    }
    
    else {
        hud.label.text = message;
        [hud hideAnimated:false afterDelay:timeInterval];
    }
}

+ (void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows[0] animated:false];
    hud.mode = MBProgressHUDModeText;
    
    //文字较长时改为detailsLabel显示  并延长一秒的显示时间
    if (message.length > 15) {
        hud.detailsLabel.text = message;
        [hud hideAnimated:false afterDelay:2.5];
    }
    
    else {
        hud.label.text = message;
        [hud hideAnimated:false afterDelay:1.5];
    }
}


@end
