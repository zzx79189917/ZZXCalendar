//
//  ZZXCalendarCollectionViewCell.m
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/7.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

#import "ZZXCalendarCollectionViewCell.h"

@interface ZZXCalendarCollectionViewCell()

@end

@implementation ZZXCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.seletedBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.seletedBg.backgroundColor = [UIColor redColor];
        [self addSubview:self.seletedBg];
        
        self.dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        self.dayLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.dayLabel];
        
        self.defaultSelectIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-20, 0, 10, 10)];
        self.defaultSelectIcon.hidden = YES;
        [self addSubview:self.defaultSelectIcon];
        
        self.bigSelectIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width-20, -10, 20, 20)];
        self.bigSelectIcon.layer.masksToBounds = NO;
        self.bigSelectIcon.hidden = YES;
        [self addSubview:self.bigSelectIcon];
        
        self.labelScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dayLabel.frame), self.bounds.size.width, self.bounds.size.height - 20)];
        self.labelScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.labelScrollView];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(transferCell)];
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void)transferCell{
    if ([self.delegate respondsToSelector:@selector(ZZXCalendarCollectionViewCell:)]) {
        [self.delegate ZZXCalendarCollectionViewCell:self];
    }
}

- (void)handleSingleTap{
    if ([self.delegate respondsToSelector:@selector(ZZXCalendarCollectionViewCellSelect:)]) {
        [self.delegate ZZXCalendarCollectionViewCellSelect:self];
    }
}




@end
