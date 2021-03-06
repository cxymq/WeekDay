//
//  MEOperaUpdateScheduleView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/29.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEOperaUpdateScheduleView.h"

@interface MEOperaUpdateScheduleView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDictionary *nextSelected;
@property (nonatomic, strong) NSMutableSet *endDisplaySelectItem;

@end

@implementation MEOperaUpdateScheduleView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.endDisplaySelectItem = [[NSMutableSet alloc] init];
    MEOperaUpdateScheduleLayout *layout = [[MEOperaUpdateScheduleLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.clipsToBounds = YES;
    collectionView.bounces = NO;
    collectionView.allowsSelection = YES;
    collectionView.allowsMultipleSelection = NO;
    [collectionView registerClass:[MEOperaUpdateScheduleCell class] forCellWithReuseIdentifier:@"MEOperaUpdateScheduleCell"];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MEOperaUpdateScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MEOperaUpdateScheduleCell" forIndexPath:indexPath];
    cell.weekTitle = self.datas[indexPath.item][@"week"];
    cell.timeTitle = self.datas[indexPath.item][@"time"];
    cell.weekLabel.font = [UIFont systemFontOfSize:12];
    cell.timeLabel.font = [UIFont systemFontOfSize:17];
    cell.isSelectedFlag = NO;
// TODO: 此处标记当日应根据实际情况更改
    if ([_datas[indexPath.item][@"week"] isEqualToString:@"三"]) {
        cell.dotIndicator.hidden = NO;
        cell.isSelectedFlag = YES;
        cell.dateIsToday = YES;
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        _nextSelected = [_datas objectAtIndex:indexPath.item];
    }
    [cell configureAppearance];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectDateWithIndexPath:indexPath scheduleCell:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectDateWithIndexPath:indexPath scheduleCell:nil];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
// TODO: 此处 week 应根据实际情况更改
    if ([_endDisplaySelectItem containsObject:_datas[indexPath.item]] && ![_datas[indexPath.item][@"week"] isEqualToString:_nextSelected[@"week"]]) {
        [self deselectDateWithIndexPath:indexPath scheduleCell:(MEOperaUpdateScheduleCell *)cell];
    }
    if ([cell isKindOfClass:[MEOperaUpdateScheduleCell class]] && (indexPath.item == [_datas indexOfObject:_nextSelected])) {
        [self selectDateWithIndexPath:indexPath scheduleCell:(MEOperaUpdateScheduleCell *)cell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (((MEOperaUpdateScheduleCell *)cell).isSelectedFlag) {
        [self.endDisplaySelectItem addObject:[_datas objectAtIndex:indexPath.item]];
    }
}

#pragma mark - Private

- (void)selectDateWithIndexPath:(NSIndexPath *)indexPath scheduleCell:(nullable MEOperaUpdateScheduleCell *)scheduleCell {
    MEOperaUpdateScheduleCell *cell = scheduleCell;
    if (!cell) {
        cell = (MEOperaUpdateScheduleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    }
    _nextSelected = _datas[indexPath.item];
// TODO: 此处标记当日应根据实际情况更改
    if (cell) {
        [_endDisplaySelectItem containsObject:_nextSelected];
        cell.isSelectedFlag = YES;
        cell.dateIsToday = [_datas[indexPath.item][@"week"] isEqualToString:@"三"] ? YES : NO;
        [cell performSelecting];
        [_collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    if (cell && self.delegate && [self.delegate respondsToSelector:@selector(operaUpdateSchedule:didSelectItem:)]) {
        [self.delegate operaUpdateSchedule:self didSelectItem:_datas[indexPath.item]];
    }
}

- (void)deselectDateWithIndexPath:(NSIndexPath *)indexPath scheduleCell:(nullable MEOperaUpdateScheduleCell *)scheduleCell {
    MEOperaUpdateScheduleCell *cell = scheduleCell;
    if (!cell) {
        cell = (MEOperaUpdateScheduleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    }
    if (!cell) {
        return;
    }
    cell.isSelectedFlag = NO;
    [cell configureAppearance];
}

#pragma mark - Public

- (void)scrollToItem:(NSInteger)item {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];

    [self deselectDateWithIndexPath:[NSIndexPath indexPathForItem:[_datas indexOfObject:_nextSelected] inSection:0] scheduleCell:nil];
    [self selectDateWithIndexPath:indexPath scheduleCell:nil];
}

@end

@implementation MEOperaUpdateScheduleLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(1, 1);
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 7 , CGRectGetHeight(self.collectionView.frame));
}

@end
