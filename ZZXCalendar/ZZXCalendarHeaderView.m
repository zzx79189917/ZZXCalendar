//
//  ZZXCalendarHeaderView.m
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXCalendarHeaderView.h"

@implementation ZZXCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        [self inflateWeekHead];
    }
    return self;
}

- (void)inflateWeekHead{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.priorMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    self.priorMonth.frame = CGRectMake(10, 5, 60, 30);
    [self.priorMonth setTitle:@"上一月" forState:UIControlStateNormal];
    [self addSubview:self.priorMonth];
    
    self.nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextMonth.frame = CGRectMake(screenWidth - 70, 5, 60, 30);
    [self.nextMonth setTitle:@"下一月" forState:UIControlStateNormal];
    [self addSubview:self.nextMonth];
    
    NSArray *weekArray = [NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wen",@"Thu",@"Fri",@"Sat", nil];
    CGFloat titleWidth = 150;
    CGFloat titleHeight = 40;
    CGFloat titleX = (screenWidth - titleWidth)/2;
    CGFloat titleY = 5;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleWidth, titleHeight)];
    self.titleLabel.font = [UIFont systemFontOfSize:25];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    CGFloat width = screenWidth/7;
    for (int i = 0; i< 7 ; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width * i, 50, width, 50)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"%@",weekArray[i]];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}

@end
