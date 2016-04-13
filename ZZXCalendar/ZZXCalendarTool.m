//
//  ZZXCalendarTool.m
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXCalendarTool.h"

@implementation ZZXCalendarTool


+ (NSDateComponents*)getCurrentDate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return comp;
}

+ (NSUInteger)getCurrentYear{
    NSDateComponents *comp = [self getCurrentDate];
    return [comp year];
}

+ (NSUInteger)getCurrentMonth{
    NSDateComponents *comp = [self getCurrentDate];
    return [comp month];
}

+ (NSUInteger)getCurrentDay{
    NSDateComponents *comp = [self getCurrentDate];
    return [comp day];
}

+ (NSUInteger)getCurrentDaysOfMonth{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
+ (NSUInteger)getDaysOfMonth:(NSUInteger)year month:(NSUInteger )month{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *monthString = [NSString stringWithFormat:@"%ld",month];
    if (monthString.length == 1) {
        monthString = [NSString stringWithFormat:@"0%@",monthString];
    }
    NSString *dateString = [NSString stringWithFormat:@"%ld-%@",year,monthString];
    NSDate *newDate=[format dateFromString:dateString];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

+ (NSUInteger)getWeekdayOfCurrentMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    double interval = 0;
    NSDate *beginDate = nil;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:now];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:beginDate];
    return [comps weekday] -1;
}

+ (NSUInteger)getWeekDay:(NSUInteger )year month:(NSUInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *monthString = [NSString stringWithFormat:@"%ld",month];
    if (monthString.length == 1) {
        monthString = [NSString stringWithFormat:@"0%@",monthString];
    }
    NSString *dateString = [NSString stringWithFormat:@"%ld-%@",year,monthString];
    NSDate *newDate=[format dateFromString:dateString];
    double interval = 0;
    NSDate *beginDate = nil;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    //    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:beginDate];
    return [comps weekday] - 1 ;
}

@end
