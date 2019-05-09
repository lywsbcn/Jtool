//
//  JHDay.m
//  MEILIBO
//
//  Created by jh on 2017/11/1.
//  Copyright © 2017年 Mars. All rights reserved.
//

#import "Jday.h"

@implementation Jday

+ (NSCalendar *)localCalendar {
    static NSCalendar *Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    });
    return Instance;
}

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year {
    return [self dateWithMonth:month day:1 year:year];
}

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    return [self dateFromDateComponents:comps];
}

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components {
    return [[self localCalendar] dateFromComponents:components];
}

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] component:NSCalendarUnitWeekday fromDate:date];
}

+ (NSString *)stringOfWeekday:(NSUInteger)weekday lang:(int)lang{
    NSAssert(weekday >= 1 && weekday <= 7, @"Invalid weekday: %lu", (unsigned long) weekday);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (lang == 0)
            Strings = @[@"Sun", @"Mon", @"Tues", @"Wed", @"Thur", @"Fri", @"Sat"];
        else if (lang == 1)
            Strings = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    });
    
    return Strings[weekday - 1];
}

+ (NSString *)LocalStringOfWeekday:(NSUInteger)weekday{
    NSAssert(weekday >= 1 && weekday <= 7, @"Invalid weekday: %lu", (unsigned long) weekday);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[
                    @"星期日",
                    @"星期一",
                    @"星期二",
                    @"星期三",
                    @"星期四",
                    @"星期五",
                    @"星期六"
                    ];
    });
    
    return Strings[weekday - 1];
}

+ (NSString *)stringOfMonth:(NSUInteger)month  lang:(int)lang{
    NSAssert(month >= 1 && month <= 12, @"Invalid month: %lu", (unsigned long) month);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(lang==0)
            Strings = @[@"Jan.", @"Feb.", @"Mar.", @"Apr.", @"May.", @"Jun.", @"Jul.", @"Aug.", @"Sept.", @"Oct.", @"Nov.", @"Dec."];
        else if (lang ==1)
            Strings = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    });
    
    return Strings[month - 1];
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    return [[self localCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
}

+(NSDateComponents*)todyComponents{
    return [self dateComponentsWithDate:[NSDate date]];
}

+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}


+(NSDateComponents*)dateComponentsWithUnix:(NSInteger)unix{
    NSDate * date =[NSDate dateWithTimeIntervalSince1970:unix];
    return [self dateComponentsWithDate:date];
}

+(NSInteger)todayUnix{    
    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy-MM-dd";
    NSString *original = [dateFomater stringFromDate:[NSDate date]];
    NSDate *ZeroDate = [dateFomater dateFromString:original];
    return  [ZeroDate timeIntervalSince1970];
}


+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents {
    NSDateComponents *todayComps = [self dateComponentsFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return todayComps.year == dateComponents.year && todayComps.month == dateComponents.month && todayComps.day == dateComponents.day;
}

+(NSDate *)dateWithTimeInterval:(NSTimeInterval)timeInterval{
    return [[NSDate alloc]initWithTimeIntervalSince1970:timeInterval];
}

+(NSDate *)dateWithDateSting:(NSString *)dateString{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    
    if(dateString.length == 10) {
        formatter.dateFormat =@"YYYY-MM-dd";
        return  [formatter dateFromString:dateString];
    }else if (dateString.length == 19){
        formatter.dateFormat=@"YYYY-MM-dd HH:mm:ss";
        return [formatter dateFromString:dateString];
    }
    return [self dateWithTimeInterval:time(NULL)];
}

+(NSUInteger)getDayFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"dd";
    return  [[formart stringFromDate:date] integerValue];
}
+(NSUInteger)getMonthFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"MM";
    return [ [formart stringFromDate:date] integerValue];
}
+(NSUInteger)getYearFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"YYYY";
    return [[formart stringFromDate:date] integerValue];
}
+(NSUInteger)getHourFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"HH";
    return  [[formart stringFromDate:date] integerValue];
}
+(NSUInteger)getMinuteFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"mm";
    return [[formart stringFromDate:date] integerValue];
}
+(NSUInteger)getSecondFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"ss";
    return [[formart stringFromDate:date] integerValue];
}
+(NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"YYYY-MM-dd HH:mm:ss";
    return [formart stringFromDate:date];
}
+(NSString *)getSortStringFromDate:(NSDate *)date{
    NSDateFormatter *formart=[[NSDateFormatter alloc]init];
    formart.dateFormat=@"YYYY-MM-dd";
    return [formart stringFromDate:date];
}
+(NSUInteger)getUnixFromDate:(NSDate *)date{
    return [date timeIntervalSince1970];
}

+(NSString*)getStringWithFormat:(NSString *)format fromUnix:(NSTimeInterval)unix{
    NSDate * date = [self dateWithTimeInterval:unix];
    return [self getStringWithFormat:format fromDate:date];
}

+(NSString*)getStringWithFormat:(NSString*)format fromDate:(NSDate*)date{
    NSDateFormatter *Formatter=[[NSDateFormatter alloc]init];
    Formatter.dateFormat = format;
    return [Formatter stringFromDate:date];
}


@end
