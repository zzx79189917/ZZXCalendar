//
//  ViewController.m
//  ZZXCalendar
//
//  Created by 邹圳巡 on 16/4/6.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//


#import "ViewController.h"
#import "ZZXCalendarTool.h"
#import "ZZXCalendarCollectionViewCell.h"
#import "ZZXCalendarHeaderView.h"
#import "ZZXCalendarNoteLabel.h"
#import <TMCache.h>

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZZXCalendarCollectionViewCellDelegate,ZZXCalendarNoteLabelDelegate>
@property (nonatomic, strong) UICollectionView *collecitonView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSUInteger selectYear;
@property (nonatomic, assign) NSUInteger selectMonth;
@property (nonatomic, assign) NSUInteger selectDay;
@property (nonatomic, strong) ZZXCalendarHeaderView *myHeader;
@property (nonatomic, strong) ZZXCalendarCollectionViewCell *selectedCell;
@property (nonatomic, strong) ZZXCalendarNoteLabel *selectedNoteLabel;
@property (nonatomic, strong) UIButton *addTodoBtn;
@property (nonatomic, strong) UIButton *addIconBtn;
@property (nonatomic, strong) UIButton *addTagColorBtn;
@property (nonatomic, strong) UIButton *modifierNoteLabelBtn;
@property (nonatomic, strong) UIButton *modifierDayTextColor;
@property (nonatomic, strong) UIButton *cancelDayTextColor;
@property (nonatomic, strong) UIButton *modifierNoteLabelViewColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectYear = [ZZXCalendarTool getCurrentYear];
    self.selectMonth = [ZZXCalendarTool getCurrentMonth];
    self.selectDay = [ZZXCalendarTool getCurrentDay];
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width/7;
    CGFloat height = width;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.itemSize = CGSizeMake(width, height);
    self.layout.headerReferenceSize = CGSizeMake(100, 100);
    
    self.collecitonView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [self.collecitonView registerClass:[ZZXCalendarCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    [self.collecitonView registerClass:[ZZXCalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionViewHeaderViewIdentifier];
    self.collecitonView.delegate = self;
    self.collecitonView.dataSource = self;
    self.collecitonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collecitonView];
    
    self.addTodoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTodoBtn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-120,60, 60);
    self.addTodoBtn.backgroundColor = [UIColor redColor];
    [self.addTodoBtn setTitle:@"添加事项" forState:UIControlStateNormal];
    self.addTodoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.addTodoBtn.hidden = YES;
    [self.addTodoBtn addTarget:self action:@selector(addMatter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTodoBtn];
    
    self.addIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addIconBtn.frame = CGRectMake(80, [UIScreen mainScreen].bounds.size.height-120, 60, 60);
    self.addIconBtn.backgroundColor = [UIColor redColor];
    [self.addIconBtn setTitle:@"添加图标" forState:UIControlStateNormal];
    self.addIconBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.addIconBtn.hidden = YES;
    [self.addIconBtn addTarget:self action:@selector(addIcon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addIconBtn];
    
    self.addTagColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTagColorBtn.frame = CGRectMake(160, [UIScreen mainScreen].bounds.size.height-120, 100, 60);
    self.addTagColorBtn.backgroundColor = [UIColor redColor];
    [self.addTagColorBtn setTitle:@"添加tag颜色" forState:UIControlStateNormal];
    self.addTagColorBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    self.addTagColorBtn.hidden = YES;
    [self.addTagColorBtn addTarget:self action:@selector(addTagColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTagColorBtn];
    
    self.modifierNoteLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.modifierNoteLabelBtn.frame = CGRectMake(280, [UIScreen mainScreen].bounds.size.height-120, 100, 60);
    self.modifierNoteLabelBtn.backgroundColor = [UIColor redColor];
    [self.modifierNoteLabelBtn setTitle:@"修改label文字" forState:UIControlStateNormal];
    self.modifierNoteLabelBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    self.modifierNoteLabelBtn.hidden = YES;
    [self.modifierNoteLabelBtn addTarget:self action:@selector(modifiedText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.modifierNoteLabelBtn];
    
    self.modifierDayTextColor = [UIButton buttonWithType:UIButtonTypeCustom];
    self.modifierDayTextColor.frame = CGRectMake(0, CGRectGetMaxY(self.addTodoBtn.frame), 100, 60);
    self.modifierDayTextColor.backgroundColor = [UIColor redColor];
    [self.modifierDayTextColor setTitle:@"修改dayText颜色" forState:UIControlStateNormal];
    self.modifierDayTextColor.titleLabel.font = [UIFont systemFontOfSize:13];
    self.modifierDayTextColor.hidden = YES;
    [self.modifierDayTextColor addTarget:self action:@selector(modifiedDayLabelTextColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.modifierDayTextColor];
    
    self.cancelDayTextColor = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelDayTextColor.frame = CGRectMake(120, CGRectGetMaxY(self.addTodoBtn.frame), 100, 60);
    self.cancelDayTextColor.backgroundColor = [UIColor redColor];
    [self.cancelDayTextColor setTitle:@"取消dayText颜色" forState:UIControlStateNormal];
    self.cancelDayTextColor.titleLabel.font = [UIFont systemFontOfSize:13];
    self.cancelDayTextColor.hidden = YES;
    [self.cancelDayTextColor addTarget:self action:@selector(cancelDayLabelTextColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelDayTextColor];
    
    self.modifierNoteLabelViewColor = [UIButton buttonWithType:UIButtonTypeCustom];
    self.modifierNoteLabelViewColor.frame = CGRectMake(240, CGRectGetMaxY(self.addTodoBtn.frame), 100, 60);
    self.modifierNoteLabelViewColor.backgroundColor = [UIColor redColor];
    [self.modifierNoteLabelViewColor setTitle:@"修改Label的view颜色" forState:UIControlStateNormal];
    self.modifierNoteLabelViewColor.titleLabel.font = [UIFont systemFontOfSize:10];
    self.modifierNoteLabelViewColor.hidden = YES;
    [self.modifierNoteLabelViewColor addTarget:self action:@selector(modifiedNoteLabelViewColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.modifierNoteLabelViewColor];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collecitonView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger totalItem = [ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] + [ZZXCalendarTool getDaysOfMonth:self.selectYear month:self.selectMonth];
    NSUInteger num = ceil(totalItem/7.0) * 7;
    return num;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZXCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.labelScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in cell.subviews) {
        if (view == cell.dayLabel || view == cell.defaultSelectIcon || view == cell.bigSelectIcon) {
            cell.dayLabel.backgroundColor = kDefaultTagColor;
            cell.defaultSelectIcon.hidden= YES;
            cell.bigSelectIcon.hidden = YES;
        }
    }
    [cell.seletedBg removeFromSuperview];
    NSString *dayString = [NSString string];
    if (indexPath.row < [ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth]) {
        NSUInteger month = self.selectMonth;
        NSUInteger year = self.selectYear;
        if (month == 1) {
            month = 12;
            year = year - 1;
        }else{
            month = month - 1;
        }
        NSUInteger firstPriorDay = [ZZXCalendarTool getDaysOfMonth:year month:month] -  [ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] + indexPath.row + 1;
        dayString = [NSString stringWithFormat:@"%ld",firstPriorDay];
        cell.dayLabel.text = dayString;
        if (dayString.length == 1) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        cell.cellMark = [NSString stringWithFormat:@"%ld-%ld-%@",year,month,dayString];
        cell.dayLabel.textColor = kDefaultNotCurrentMonthDayTextColor;
    }else if(indexPath.row >= [ZZXCalendarTool getDaysOfMonth:self.selectYear month:self.selectMonth] +[ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] ){
        NSUInteger month = self.selectMonth;
        NSUInteger year = self.selectYear;
        if (month == 12) {
            month = 1;
            year = year + 1;
        }else{
            month = month + 1;
        }
        dayString = [NSString stringWithFormat:@"%ld",(long)indexPath.row -[ZZXCalendarTool getDaysOfMonth:self.selectYear month:self.selectMonth] - [ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] +1 ];
        cell.dayLabel.text = dayString;
        if (dayString.length == 1) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        cell.cellMark = [NSString stringWithFormat:@"%ld-%ld-%@",year,month,dayString];
        cell.dayLabel.textColor = kDefaultNotCurrentMonthDayTextColor;
    }else{
        dayString = [NSString stringWithFormat:@"%ld",(long)indexPath.row -[ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] + 1];
        cell.dayLabel.text = dayString;
        if (dayString.length == 1) {
            dayString = [NSString stringWithFormat:@"0%@",dayString];
        }
        NSString *headString = [NSString stringWithFormat:@"%ld年%ld月",self.selectYear,self.selectMonth];
        
        cell.cellMark = [NSString stringWithFormat:@"%ld-%ld-%@",self.selectYear,self.selectMonth,dayString];
        NSString *currentString = [NSString stringWithFormat:@"%ld年%ld月",[ZZXCalendarTool getCurrentYear],[ZZXCalendarTool getCurrentMonth]];
        if ([cell.dayLabel.text isEqualToString:[NSString stringWithFormat:@"%ld",self.selectDay]] && [headString isEqualToString:currentString]) {
            cell.seletedBg = [[UIView alloc]initWithFrame:cell.bounds];
            cell.seletedBg.backgroundColor = kDefaultSelectBgColor;
            [cell insertSubview:cell.seletedBg belowSubview:cell.dayLabel];
        }
        cell.dayLabel.textColor = kDefaultCurrentMonthDayTextColor;
    }
    cell.delegate = self;
    
    NSMutableDictionary *dataDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    
    NSMutableArray *array = [dataDic objectForKey:kCellMarkNewToDoKey];
    NSMutableArray *colorArray = [[[TMCache sharedCache] objectForKey:cell.cellMark] objectForKey:kCellMarkNewToDoColorKey];
    if (array.count>0) {
        cell.labelScrollView.contentSize = CGSizeMake(0, 0);
        for (int i = 0; i<array.count; i++) {
            CGSize size = cell.labelScrollView.contentSize;
            ZZXCalendarNoteLabel *label = [[ZZXCalendarNoteLabel alloc]initWithFrame:CGRectMake(0, size.height, cell.bounds.size.width, 20)];
            label.noteView.backgroundColor = colorArray[i];
            label.delegate = self;
            label.noteLabel.text = array[i];
            [cell.labelScrollView addSubview:label];
            cell.labelScrollView.contentSize = CGSizeMake(cell.bounds.size.width, CGRectGetMaxY(label.frame));
        }
    }
    NSMutableDictionary *dic = [dataDic objectForKey:kCellMarkIconKey];
    if ([dic objectForKey:@"image"] != nil) {
        if ([[dic objectForKey:@"type"] isEqualToString:@"0"]) {
            cell.defaultSelectIcon.hidden = NO;
            cell.defaultSelectIcon.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        }else if([[dic objectForKey:@"type"] isEqualToString:@"1"]){
            cell.bigSelectIcon.hidden = NO;
            cell.bigSelectIcon.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        }
    }
    UIColor *dayTagColor = [dataDic objectForKey:kCellMarkTagColorKey];
    if (dayTagColor) {
        cell.dayLabel.backgroundColor = dayTagColor;
    }
    
    UIColor *dayTextColor = [dataDic objectForKey:kCellMarkDayTextColorKey];
    if (dayTextColor) {
        cell.dayLabel.textColor = dayTextColor;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/7, [UIScreen mainScreen].bounds.size.width *1.5 /7);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        self.myHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionViewHeaderViewIdentifier forIndexPath:indexPath];
        NSString *headString = [NSString stringWithFormat:@"%ld年%ld月",self.selectYear,self.selectMonth];
        self.myHeader.titleLabel.text = headString;
        [self.myHeader.priorMonth addTarget:self action:@selector(priorMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self.myHeader.nextMonth addTarget:self action:@selector(nextMonth:) forControlEvents:UIControlEventTouchUpInside];
    }
        return self.myHeader;
}

- (void)nextMonth:(id)sender{
    if (self.selectMonth < 12) {
        self.selectMonth = self.selectMonth + 1;
    }else{
        self.selectMonth = 1;
        self.selectYear = self.selectYear + 1;
    }
    self.addTodoBtn.hidden = YES;
    self.addIconBtn.hidden = YES;
    self.modifierNoteLabelBtn.hidden = YES;
    self.addTagColorBtn.hidden = YES;
    self.modifierDayTextColor.hidden = YES;
    self.cancelDayTextColor.hidden = YES;
    self.modifierNoteLabelViewColor.hidden = YES;
    [self.collecitonView reloadData];
}

- (void)priorMonth:(id)sender{
    if (self.selectMonth > 1) {
        self.selectMonth = self.selectMonth - 1;
    }else{
        self.selectMonth = 12;
        self.selectYear = self.selectYear - 1;
    }
    self.addTodoBtn.hidden = YES;
    self.addIconBtn.hidden = YES;
    self.addTagColorBtn.hidden = YES;
    self.modifierNoteLabelBtn.hidden = YES;
    self.modifierDayTextColor.hidden = YES;
    self.cancelDayTextColor.hidden = YES;
    self.modifierNoteLabelViewColor.hidden = YES;
    [self.collecitonView reloadData];
}

#pragma mark --ZZXCalendarCollectionViewCell代理
- (void)ZZXCalendarCollectionViewCell:(ZZXCalendarCollectionViewCell *)cell{
    if (cell.labelScrollView.subviews.count == 0) {
        cell.labelScrollView.contentSize = CGSizeMake(0, 0);
    }
    CGSize size = cell.labelScrollView.contentSize;
    NSMutableDictionary *dic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableArray *newToDoArray = [mutableDic objectForKey:kCellMarkNewToDoKey];
    NSMutableArray *newToDoColorArray = [mutableDic objectForKey:kCellMarkNewToDoColorKey];
    ZZXCalendarNoteLabel *label = [[ZZXCalendarNoteLabel alloc]initWithFrame:CGRectMake(0, size.height, cell.bounds.size.width, 20)];
    label.delegate = self;
    label.noteLabel.text = @"1234";
    [cell.labelScrollView addSubview:label];
    if (!newToDoArray) {
        newToDoArray = [NSMutableArray array];
    }
    
    if (!newToDoColorArray) {
        newToDoColorArray = [NSMutableArray array];
    }
    [newToDoArray addObject:label.noteLabel.text];
    [newToDoColorArray addObject:[UIColor greenColor]];
    [mutableDic setObject:newToDoArray forKey:kCellMarkNewToDoKey];
    [mutableDic setObject:newToDoColorArray forKey:kCellMarkNewToDoColorKey];
    [[TMCache sharedCache] setObject:mutableDic forKey:cell.cellMark];
    cell.labelScrollView.contentSize = CGSizeMake(cell.bounds.size.width, CGRectGetMaxY(label.frame));
}
-(void)ZZXCalendarCollectionViewCellSelect:(ZZXCalendarCollectionViewCell *)cell{
    [self.selectedCell.seletedBg removeFromSuperview];
    self.selectedCell = cell;
    if (self.selectedNoteLabel && self.selectedNoteLabel.superview.superview != self.selectedCell) {
        self.selectedNoteLabel.layer.borderWidth = 0;
    }
    self.addTodoBtn.hidden = NO;
    self.addIconBtn.hidden = NO;
    self.addTagColorBtn.hidden = NO;
    self.modifierNoteLabelBtn.hidden = NO;
    self.modifierDayTextColor.hidden = NO;
    self.cancelDayTextColor.hidden = NO;
    self.modifierNoteLabelViewColor.hidden = NO;
    cell.seletedBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    cell.seletedBg.backgroundColor = kSelectBgColor;
    [cell insertSubview:cell.seletedBg belowSubview:cell.dayLabel];
}

#pragma mark --ZZXCalendarNoteLabel代理
-(void)ZZXCalendarNoteLabel:(ZZXCalendarNoteLabel *)label{
    ZZXCalendarCollectionViewCell *cell = (ZZXCalendarCollectionViewCell *)label.superview.superview;
    for (int i = 0; i<cell.labelScrollView.subviews.count; i++) {
        UIView *view = cell.labelScrollView.subviews[i];
        if (view == label) {
            NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
            NSMutableArray *newToDoArray = [mutableDic objectForKey:kCellMarkNewToDoKey];
            NSMutableArray *newToDoColorArray = [mutableDic objectForKey:kCellMarkNewToDoColorKey];
            if (!newToDoArray) {
                newToDoArray = [NSMutableArray array];
            }
            
            if (!newToDoColorArray) {
                newToDoColorArray = [NSMutableArray array];
            }
            if (newToDoArray.count>0) {
                [newToDoArray removeObjectAtIndex:i];
                [newToDoColorArray removeObjectAtIndex:i];
            }
            [mutableDic setObject:newToDoArray forKey:kCellMarkNewToDoKey];
            [mutableDic setObject:newToDoColorArray forKey:kCellMarkNewToDoColorKey];
            [[TMCache sharedCache] setObject:mutableDic forKey:cell.cellMark];
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        [label removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.collecitonView reloadData];
    }];
}

-(void)ZZXCalendarNoteLabelModifiedText:(ZZXCalendarNoteLabel *)label{
    self.selectedNoteLabel.layer.borderWidth = 0;
    self.selectedNoteLabel = label;
    self.selectedNoteLabel.layer.borderColor = [UIColor colorWithRed:0.379 green:1.000 blue:0.976 alpha:1.000].CGColor;
    self.selectedNoteLabel.layer.borderWidth = 1;
    [self ZZXCalendarCollectionViewCellSelect:(ZZXCalendarCollectionViewCell *)label.superview.superview];
}

- (void)addNewToDo:(ZZXCalendarCollectionViewCell *)cell text:(NSString *)text flagColor:(UIColor *)color{
    if (cell.labelScrollView.subviews.count == 0) {
        cell.labelScrollView.contentSize = CGSizeMake(0, 0);
    }
    CGSize size = cell.labelScrollView.contentSize;
    NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    NSMutableArray *newToDoArray = [mutableDic objectForKey:kCellMarkNewToDoKey];
    NSMutableArray *newToDoColorArray = [mutableDic objectForKey:kCellMarkNewToDoColorKey];
    if (!newToDoArray) {
        newToDoArray = [NSMutableArray array];
    }
    
    if (!newToDoColorArray) {
        newToDoColorArray = [NSMutableArray array];
    }

    ZZXCalendarNoteLabel *label = [[ZZXCalendarNoteLabel alloc]initWithFrame:CGRectMake(0, size.height, cell.bounds.size.width, 20)];
    label.delegate = self;
    label.noteLabel.text = text;
    if (color) {
        label.noteView.backgroundColor = color;
        [newToDoColorArray addObject:color];
    }else{
        [newToDoColorArray addObject:kDefaultNewToDoViewColor];
    }
    [cell.labelScrollView addSubview:label];
    [newToDoArray addObject:label.noteLabel.text];
    
    [mutableDic setObject:newToDoArray forKey:kCellMarkNewToDoKey];
    [mutableDic setObject:newToDoColorArray forKey:kCellMarkNewToDoColorKey];
    [[TMCache sharedCache] setObject:mutableDic forKey:cell.cellMark];

    cell.labelScrollView.contentSize = CGSizeMake(cell.bounds.size.width, CGRectGetMaxY(label.frame));
}

#pragma mark -- 方法
- (void)addSelectIcon:(ZZXCalendarCollectionViewCell *)cell iconName:(NSString *)iconName type:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        [self controlIcon:cell iconImageView:cell.defaultSelectIcon iconName:iconName type:type];
    }else if([type isEqualToString:@"1"]){
        [self controlIcon:cell iconImageView:cell.bigSelectIcon iconName:iconName type:type];
    }

}

- (void)controlIcon:(ZZXCalendarCollectionViewCell *)cell iconImageView:(UIImageView *)iconImageView iconName:(NSString *)iconName type:(NSString *)type{
    if (iconImageView.hidden == YES) {
        iconImageView.hidden = NO;
        iconImageView.image = [UIImage imageNamed:iconName];
        NSDictionary *iconDic = @{
                                  @"image":iconName,
                                  @"type":type
                                  };
        NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
        if (!mutableDic) {
            mutableDic = [NSMutableDictionary dictionary];
        }
        [mutableDic setObject:iconDic forKey:kCellMarkIconKey];
        [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
    }else{
        iconImageView.hidden = YES;
        NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
        [mutableDic removeObjectForKey:kCellMarkIconKey];
        [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
    }
}

- (void)addSelectTagColor:(ZZXCalendarCollectionViewCell *)cell tagColor:(UIColor *)color{
    if (cell.dayLabel.backgroundColor == kDefaultTagColor) {
        cell.dayLabel.backgroundColor = color;
        NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
        [mutableDic setObject:color forKey:kCellMarkTagColorKey];
        [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
    }else{
        cell.dayLabel.backgroundColor = kDefaultTagColor;
        NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
        [mutableDic setObject:color forKey:kCellMarkTagColorKey];
        [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
    }
}

- (void)modifiedSelectLabelText:(ZZXCalendarNoteLabel *)label text:(NSString *)text{
        label.noteLabel.text = text;
        ZZXCalendarCollectionViewCell *cell = (ZZXCalendarCollectionViewCell *)label.superview.superview;
        NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
        NSMutableArray *newToDoArray = [mutableDic objectForKey:kCellMarkNewToDoKey];
        for (int i = 0; i<cell.labelScrollView.subviews.count; i++) {
            if (cell.labelScrollView.subviews[i] == label) {
                newToDoArray[i] = text;
            }
        }
        [mutableDic setObject:newToDoArray forKey:kCellMarkNewToDoKey];
        [[TMCache sharedCache] setObject:mutableDic forKey:cell.cellMark];
}

- (void)modifiedSelectLabelViewColor:(ZZXCalendarNoteLabel *)label color:(UIColor *)color{
    label.noteView.backgroundColor = color;
    ZZXCalendarCollectionViewCell *cell = (ZZXCalendarCollectionViewCell *)label.superview.superview;
    NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    NSMutableArray *newToDoColorArray = [mutableDic objectForKey:kCellMarkNewToDoColorKey];
    for (int i = 0; i<cell.labelScrollView.subviews.count; i++) {
        if (cell.labelScrollView.subviews[i] == label) {
            newToDoColorArray[i] = color;
        }
    }
    [mutableDic setObject:newToDoColorArray forKey:kCellMarkNewToDoColorKey];
    [[TMCache sharedCache] setObject:mutableDic forKey:cell.cellMark];
}

- (void)modifiedSelectDayLabelTextColor:(ZZXCalendarCollectionViewCell *)cell textColor:(UIColor *)color{
    cell.dayLabel.textColor = color;
    NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    if (!mutableDic) {
        mutableDic = [NSMutableDictionary dictionary];
    }
    [mutableDic setObject:color forKey:kCellMarkDayTextColorKey];
    [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
}

- (void)cancelSelectDayLabelTextColor:(ZZXCalendarCollectionViewCell *)cell{
    NSIndexPath *indexPath = [self.collecitonView indexPathForCell:cell];
    if (indexPath.row < [ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth] || indexPath.row >= [ZZXCalendarTool getDaysOfMonth:self.selectYear month:self.selectMonth] +[ZZXCalendarTool getWeekDay:self.selectYear month:self.selectMonth]) {
        cell.dayLabel.textColor = kDefaultNotCurrentMonthDayTextColor;
    }else{
        cell.dayLabel.textColor = kDefaultCurrentMonthDayTextColor;
    }
    NSMutableDictionary *mutableDic = [[TMCache sharedCache]objectForKey:cell.cellMark];
    [mutableDic removeObjectForKey:kCellMarkDayTextColorKey];
    [[TMCache sharedCache]setObject:mutableDic forKey:cell.cellMark];
}

- (NSArray *)getSelectCellMark:(ZZXCalendarCollectionViewCell *)cell{
    NSArray *array = [cell.cellMark componentsSeparatedByString:@"-"];
    return array;
}

#pragma mark --使用方法
/**
 *  增加标签
 */
- (void)addMatter{
    [self addNewToDo:self.selectedCell text:@"你好啊" flagColor:[UIColor redColor]];
}
/**
 *  增加图标 type:0小图 type:1大图
 */
- (void)addIcon{
    [self addSelectIcon:self.selectedCell iconName:@"xiaoxin1" type:@"1" ];
}
/**
 *  日期天数所在栏的颜色
 */
- (void)addTagColor{
    [self addSelectTagColor:self.selectedCell tagColor:[UIColor purpleColor]];
}
/**
 *  修改标签数据
 */
- (void)modifiedText{
    [self modifiedSelectLabelText:self.selectedNoteLabel text:@"哈哈哈哈"];
}
/**
 *  修改day颜色
 */
- (void)modifiedDayLabelTextColor{
    [self modifiedSelectDayLabelTextColor:self.selectedCell textColor:[UIColor redColor]];
}
/**
 *  取消day颜色
 */
- (void)cancelDayLabelTextColor{
    [self cancelSelectDayLabelTextColor:self.selectedCell];
}
/**
 *  修改noteLabel前view的颜色
 */

- (void)modifiedNoteLabelViewColor{
    [self modifiedSelectLabelViewColor:self.selectedNoteLabel color:[UIColor colorWithRed:0.157 green:1.000 blue:0.941 alpha:1.000]];
}
/**
 *  获取选中cell的text列表
 */
- (NSArray *)getSelectCellText{
    NSDictionary *mutableDic = [[TMCache sharedCache]objectForKey:self.selectedCell.cellMark];
    NSArray *newTodoList = [mutableDic objectForKey:kCellMarkNewToDoKey];
    return newTodoList;
}
/**
 *   获取选中cell的年
 */
- (NSString *)getSelectCellYear{
    return [[self getSelectCellMark:self.selectedCell] objectAtIndex:0];
}
/**
 *   获取选中cell的月
 */
- (NSString *)getSelectCellMonth{
    return [[self getSelectCellMark:self.selectedCell] objectAtIndex:1];
}
/**
 *   获取选中cell的年
 */
- (NSString *)getSelectCellDay{
    return [[self getSelectCellMark:self.selectedCell] objectAtIndex:2];
}
@end
