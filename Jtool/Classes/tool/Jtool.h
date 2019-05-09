//
//  JHTools.h
//  happiness
//
//  Created by jh on 2018/4/25.
//  Copyright © 2018年 jh. All rights reserved.
//




#import <UIKit/UIKit.h>


#ifndef NDEBUG
#define DLog(message, ...) NSLog(@"%s: " message, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define DLog(message, ...)
#endif
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r,g,b) RGBA(r,g,b,1)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height




@interface Jtool : NSObject

/*根据 唯一标志从Storyborad 中获取 控制*/
+(UIViewController *)fromStoryboadWithName:(NSString *)identity;

/*对象或模型 转换成JSON字符串*/
+(NSString *)objectToJson:(id)dict;

/*JSON字符串 转换成对象(字典)*/
+(id)jsonToObject:(NSString *)json;

/*MD5 加密*/
+(NSString *)md5HexDigest:(NSString*)Des_str;

/*获取文本宽度*/
+(CGFloat)stringWidth:(NSString*)str font:(UIFont *)font;
/*获取文本高度*/
+(CGFloat)stringHeight:(NSString *)str font:(UIFont *)font width:(CGFloat)width;
+(CGFloat) heightForString:(UITextView *)textView andWidth:(float)width;
//返回字符串所占用的尺寸.
+(CGSize)string:(NSString *)str sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+(UIWindow*)window;

+(void)CheckVersionData:(void(^)(NSInteger code,NSDictionary * dic))res;

/* 提示相关*/
+(void)alert:(NSString *)string;
+(void)alert:(NSString *)string confirm:(void (^ )(UIAlertAction *action))confirm;
+(void)alert:(NSString *)string confirm:(void (^)(UIAlertAction *action))confirm cancel:(void(^)(UIAlertAction *action))cancel;
+(void)alert:(NSString *)string title:(NSString *)title num:(int)num confirm:(void (^)(UIAlertAction * action))confirm cancel:(void (^)(UIAlertAction *action))cancel;

+(void)alert:(NSString*)string title:(NSString*)title actions:(NSArray<UIAlertAction*>*)actions;

//获取Nib
+(id)getNibView:(NSString *)name;

//格式化 钱
+(NSString *)formatMoney:(NSInteger)money;
+ (NSString *)formattingWithStirng:(NSString *)string;

+(CGFloat)statusBarHeight;

//获取设备号
+(NSString *)deviceVersion;
//获取系统版本
+(CGFloat)systemVersion;
//获取app版本
+(NSString*)appVersion;

+(NSString *)getConstellation:(NSInteger)birthday;

+ (NSInteger )getAge: (NSDate *)userBirthday;

+ (UIViewController *)topViewController;

+(void)mainQueue:(void(^)(void))block;
+(void)delayDuration:(CGFloat)duration block:(void (^)(void))block;

+(NSString *)currentLanage;
@end


