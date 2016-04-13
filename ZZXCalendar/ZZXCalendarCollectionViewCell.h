//
//  ZZXCalendarCollectionViewCell.h
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZXCalendarCollectionViewCell;
@protocol ZZXCalendarCollectionViewCellDelegate <NSObject>

- (void)ZZXCalendarCollectionViewCell:(ZZXCalendarCollectionViewCell *)cell;

- (void)ZZXCalendarCollectionViewCellSelect:(ZZXCalendarCollectionViewCell *)cell ;

@end

@interface ZZXCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) UIScrollView *labelScrollView;

@property (nonatomic, strong) UIView *seletedBg;

@property (nonatomic, strong) UIImageView *defaultSelectIcon;

@property (nonatomic, strong) UIImageView *bigSelectIcon;

@property (nonatomic, weak) id <ZZXCalendarCollectionViewCellDelegate> delegate;

@property (nonatomic, copy) NSString *cellMark;

//@property (nonatomic, copy) NSString *cellColorMark;
//
//@property (nonatomic, copy) NSString *cellIconMark;
//
//@property (nonatomic, copy) NSString *cellDayTagColorMark;

@end
