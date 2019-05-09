//
//  JHDay.h
//  MEILIBO
//
//  Created by jh on 2017/11/1.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jday : NSObject

+ (NSCalendar *)localCalendar;

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year;

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year;

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components;

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSString *)stringOfWeekday:(NSUInteger)weekday lang:(int)lang;

+ (NSString *)stringOfMonth:(NSUInteger)month  lang:(int)lang;

+ (NSString *)LocalStringOfWeekday:(NSUInteger)weekday;

//+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date;



+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents;


+(NSDateComponents*)todyComponents;
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;
+(NSDateComponents*)dateComponentsWithUnix:(NSInteger)unix;

+(NSInteger)todayUnix;

/* 时间戳 转 时间*/
+ (NSDate *)dateWithTimeInterval:(NSTimeInterval)timeInterval;

/* 字符串 转 时间*/
+ (NSDate *)dateWithDateSting:(NSString *)dateString;

/* 从时间中 获取 日*/
+ (NSUInteger)getDayFromDate:(NSDate *)date;

/*从时间中 获取 月份*/
+ (NSUInteger)getMonthFromDate:(NSDate *)date;

/* 从时间获取 年份*/
+ (NSUInteger)getYearFromDate:(NSDate *)date;

/* 从时间中获取 小时*/
+ (NSUInteger)getHourFromDate:(NSDate *)date;

/* 从时间中获取 分钟*/
+ (NSUInteger)getMinuteFromDate:(NSDate *)date;

/* 从时间中获取 秒*/
+ (NSUInteger)getSecondFromDate:(NSDate *)date;

///* 把时间切割成数组  (年,月,日,时,分,秒)*/
//+ (NSArray *)getSplitDateFormDate:(NSDate *)date;

/* 时间 转 字符串*/
+ (NSString *)getStringFromDate:(NSDate *)date;

+ (NSString *)getSortStringFromDate:(NSDate *)date;

/* 时间 转 时间戳*/
+ (NSUInteger)getUnixFromDate:(NSDate *)date;

+(NSString*)getStringWithFormat:(NSString *)format fromUnix:(NSTimeInterval)unix;

+(NSString*)getStringWithFormat:(NSString*)format fromDate:(NSDate*)date;


@end
