//
//  JHDay+Week.h
//  bunch
//
//  Created by jh on 2018/9/4.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Jday.h"

@interface Jday (Week)
/**
 传入时间戳，返回今天、昨天、星期几。。。。。
 注：时间戳需要10位及以上，包括10位，否则返回“未知时间”
 */
+ (NSString *)achieveDayFormatByTimeString:(NSString *)timeString;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
