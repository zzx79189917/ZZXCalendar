//
//  ZZXCalendarTool.h
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZXCalendarTool : NSObject

+ (NSUInteger)getCurrentYear;

+ (NSUInteger)getCurrentMonth;

+ (NSUInteger)getCurrentDay;

+ (NSUInteger)getCurrentDaysOfMonth;

+ (NSUInteger)getDaysOfMonth:(NSUInteger)year month:(NSUInteger )month;

//+ (NSUInteger )getFirstdayOfCurrentMonth;

+ (NSUInteger)getWeekDay:(NSUInteger )year month:(NSUInteger)month;
@end
