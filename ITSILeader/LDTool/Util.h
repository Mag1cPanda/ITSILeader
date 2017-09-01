//
//  Util.h
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LRUserDefaults [NSUserDefaults standardUserDefaults]

@interface Util : NSObject

/**
 获取系统版本

 @return 版本号(float)
 */
+(float)getVersion;

/**
 获取状态栏高度

 @return 状态栏高度(CGFloat)
 */
+(CGFloat)getStatusBarHeight;

/**
 获取导航栏高度

 @param nav 导航栏控制器
 @return 导航栏高度(CGFloat)
 */
+(CGFloat)getnavigationBarHeight:(UINavigationController *)nav;

/**
 导航栏高度和状态栏的总高度

 @param nav 导航栏控制器
 @return 状态栏+导航栏高度(CGFloat)
 */
+(CGFloat)getStatusBarAndNavigationBarHeight:(UINavigationController *)nav;


/**
 图片缩放

 @param image 图片对象
 @param size 缩放后的大小
 @return 缩放后的图片对象
 */
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;


/**
 图片旋转

 @param image 图片对象
 @param orientation 旋转方向
 @return 旋转后的图片对象
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

/**
 获取图片的大小
 
 @param image 图片对象
 @return 图片大小（单位为K）
 */
+(NSNumber *)getImageBig:(UIImage *)image;


/**
 根据格式获取当前时间

 @param formal 日期格式
 @return 时间
 */
+(NSString *)getCurrentTimeByFormal:(NSString *)formal;


/**
 获取当前时间戳

 @return 当前时间戳
 */
+(long)getCurrentTime;

/**
 获取设备名称

 @return 设备名称
 */
+(NSString *)getCurrentDeviceName;


/**
 获取唯一标识符（UUID）

 @return UUID
 */
+(NSString *)getIdentifierForVendor;



/**
 将字典写入文件中

 @param dicPath 文件上层路径
 @param fileName 文件名
 @param dic 要写入的字典
 @return 写入是否成功
 */
+(BOOL)dicWrite2File:(NSString *)dicPath fileName:(NSString *)fileName dic:(NSDictionary *)dic;



/**
 对象转JSON

 @param object NSObject对象
 @return JSON字符串
 */
+ (NSString *)objectToJson:(NSObject *)object;



/**
 JSON字符串转字典

 @param jsonString JSON字符串
 @return 转换后的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 16进制颜色

 @param color 颜色字符串（#ffffff）
 @return 计算出的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


/**
 16进制颜色

 @param color 颜色字符串（#ffffff）
 @param alpha alpha值
 @return 计算出的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 判断一个字符串是否全部为数字

 @param string 字符串
 @return 是否全部为数字
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  校验身份证号合法性
 *
 *  @param value 身份证号字符串
 *
 *  @return YES/NO
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;


/**
 设置UITextField距离左边的距离

 @param textField UITextField
 @param leftWidth 距离左边的距离
 */
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;


/**
 车牌号正则验证

 @param carNo 车牌号
 @return 车牌号是否正确
 */
+ (BOOL)validateCarNo:(NSString *)carNo;


/**
 根据字符串计算size

 @param text 要计算的文字
 @param width 确定的宽度
 @param fontSize 字体大小
 @return 文字的size(CGSize)
 */
+(CGSize)sr_DrawTextRectWithString:(NSString *)text Width:(CGFloat)width FondSize:(CGFloat)fontSize;


/**
 图片转字符串

 @param image 图片对象
 @return 转换后的字符串
 */
+(NSString *)imageToString:(UIImage *)image;


/**
 字符串转图片

 @param encodedImageStr 字符串
 @return 转换后的图片
 */
+(UIImage *)stringToImage:(NSString *)encodedImageStr;



/**
 拉伸图片

 @param image 要拉伸的图片对象
 @param top top
 @param right right
 @param bottom bottom
 @param left left
 @param resizingMode resizingMode
 @return 拉伸后的图片对象
 */
+(UIImage *)stretchImage:(UIImage *)image top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left resizingMode:(UIImageResizingMode)resizingMode;


/**
 绘制虚线

 @param lineView 需要绘制成虚线的view
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/******************************************************************/
/*----------------------------------------------------------------*/
/******************************************************************/


/**
 存NSInteger类型
 
 @param value 值
 @param key 键
 */
+(void)saveNSUserDefaultsForInteger:(NSInteger)value forKey:(NSString *)key;

/**
 存float类型
 
 @param value 值
 @param key 键
 */
+(void)saveNSUserDefaultsForFloat:(float)value forKey:(NSString *)key;

/**
 存Double类型
 
 @param value 值
 @param key 键
 */
+(void)saveNSUserDefaultsForDouble:(double)value forKey:(NSString *)key;

/**
 存BOOL类型
 
 @param value 值
 @param key 键
 */
+(void)saveNSUserDefaultsForBOOL:(BOOL)value forKey:(NSString *)key;

/**
 存对象
 
 @param value 值
 @param key 键
 */
+(void)saveNSUserDefaultsForObject:(id)value forKey:(NSString *)key;


/**
 取值
 
 @param key 键
 @return 取到的值
 */
+(id)getDataForKey:(NSString *)key;

/**
 移除所有本地用户信息
 */
+(void)removeAllUserDefaults;

#pragma mark 获取deviceToken
+(NSString *)getDeviceToken;
#pragma mark 保存deviceToken
+(NSString *)saveDeviceToken:(NSData *)data;

#pragma mark -
+ (BOOL)checkPassWordRationality:(NSString *)rationalityString;


//需要导入HUD
+ (void)showHudWithView:(UIView *)view message:(NSString *)message hideAfterDelay:(NSTimeInterval)timeInterval;

+ (void)showMessage:(NSString *)message;



@end
