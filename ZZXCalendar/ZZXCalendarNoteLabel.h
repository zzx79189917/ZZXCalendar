//
//  ZZXCalendarNoteLabel.h
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZXCalendarNoteLabel;
@protocol ZZXCalendarNoteLabelDelegate <NSObject>

- (void)ZZXCalendarNoteLabel:(ZZXCalendarNoteLabel *)label;

- (void)ZZXCalendarNoteLabelModifiedText:(ZZXCalendarNoteLabel *)label;
@end

@interface ZZXCalendarNoteLabel : UIView

@property (nonatomic, strong) UILabel *noteLabel;

@property (nonatomic, strong) UIView *noteView;

@property (nonatomic, strong) UIScrollView *scrollBg;

@property (nonatomic, weak) id <ZZXCalendarNoteLabelDelegate> delegate;
@end
