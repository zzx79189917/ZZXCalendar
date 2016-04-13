//
//  ZZXCalendarNoteLabel.m
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#import "ZZXCalendarNoteLabel.h"

@interface ZZXCalendarNoteLabel()<UIScrollViewDelegate>

@end

@implementation ZZXCalendarNoteLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        self.scrollBg = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollBg.contentSize = CGSizeMake(self.bounds.size.width*1.5, 0);
        self.scrollBg.showsHorizontalScrollIndicator = NO;
        self.scrollBg.delegate = self;
        self.scrollBg.pagingEnabled = YES;
        [self addSubview:self.scrollBg];
        
        self.noteView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        self.noteView.layer.cornerRadius = 5;
        self.noteView.backgroundColor  = [UIColor greenColor];
        [self.scrollBg addSubview:self.noteView];
        
        self.noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noteView.frame)+5, 0, self.bounds.size.width - 20, 20)];
        self.noteLabel.font = [UIFont systemFontOfSize:10];
        [self.scrollBg addSubview:self.noteLabel];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
    }
    return self;
}

- (void)handleSingleTap{
    if ([self.delegate respondsToSelector:@selector(ZZXCalendarNoteLabelModifiedText:)]) {
        [self.delegate ZZXCalendarNoteLabelModifiedText:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>self.bounds.size.width * 0.3) {
        if ([self.delegate respondsToSelector:@selector(ZZXCalendarNoteLabel:)]) {
            [self.delegate ZZXCalendarNoteLabel:self];
        }
    }
}

@end
