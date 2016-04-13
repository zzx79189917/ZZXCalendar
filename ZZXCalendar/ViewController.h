//
//  ViewController.h
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/6.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

//当前日期选中背景颜色
#define kDefaultSelectBgColor [UIColor colorWithRed:0.720 green:0.000 blue:0.007 alpha:0.2]
//其他选择日期背景颜色
#define kSelectBgColor [UIColor colorWithRed:0.884 green:0.689 blue:1.000 alpha:1.000]
//daylabel背景颜色
#define kDefaultTagColor [UIColor yellowColor]
//当前月的text颜色
#define kDefaultCurrentMonthDayTextColor [UIColor blackColor]
//非当前月的text颜色
#define kDefaultNotCurrentMonthDayTextColor [UIColor grayColor]
//newToDo默认view颜色
#define kDefaultNewToDoViewColor [UIColor greenColor]

#define kCollectionViewCellIdentifier @"collectionCell"
#define kCollectionViewHeaderViewIdentifier @"collectionHeader"

#define kCellMarkIconKey @"icon"
#define kCellMarkNewToDoKey @"newToDo"
#define kCellMarkNewToDoColorKey @"newToDoColor"
#define kCellMarkTagColorKey @"tagColor"
#define kCellMarkDayTextColorKey @"dayTextColor"

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//所有操作需要选择cell后才能进行

/**
 *  增加标签
 */
- (void)addMatter;
/**
 *  增加图标 type:0小图 type:1大图
 */
- (void)addIcon;
/**
 *  日期天数所在栏的颜色
 */
- (void)addTagColor;
/**
 *  修改标签数据
 */
- (void)modifiedText;
/**
 *  修改day颜色
 */
- (void)modifiedDayLabelTextColor;
/**
 *  取消day颜色
 */
- (void)cancelDayLabelTextColor;

/**
 *  修改noteLabel前view的颜色
 */

- (void)modifiedNoteLabelViewColor;
/**
 *  获取选中cell的text列表
 */
- (NSArray *)getSelectCellText;
/**
 *   获取选中cell的年
 */
- (NSString *)getSelectCellYear;
/**
 *   获取选中cell的月
 */
- (NSString *)getSelectCellMonth;
/**
 *   获取选中cell的年
 */
- (NSString *)getSelectCellDay;


@end

