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
//@property (nonatomic, strong) NSMutableArray *lastSelecteds;
@property (nonatomic, strong) NSDictionary *lastSelected;
@property (nonatomic, strong) NSDictionary *selected;
@property (nonatomic, strong) NSDictionary *nextSelected;

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
//    _lastSelecteds = [[NSMutableArray alloc] init];
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
    if (indexPath.item == 6 && !cell.selected) {
        cell.dotIndicator.hidden = NO;
        cell.selected = YES;
        cell.dateIsToday = YES;
//        [_lastSelecteds addObject:[_datas objectAtIndex:6]];
//        _selected = [_lastSelecteds lastObject];
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        _lastSelected = [_datas objectAtIndex:6];
        _selected = _lastSelected;
    }
    [cell configureAppearance];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectDateWithIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectDate];
}

#pragma mark - Private

- (void)selectDateWithIndexPath:(NSIndexPath *)indexPath {
    MEOperaUpdateScheduleCell *cell = (MEOperaUpdateScheduleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    _nextSelected = _datas[indexPath.item];
    if (cell && _selected && ![_selected isEqualToDictionary:_nextSelected]) {
        _selected = _nextSelected;
        cell.selected = YES;
        cell.dateIsToday = indexPath.item == 6 ? YES : NO;
//        [self deselectDate];
        [cell performSelecting];
//        [_lastSelecteds addObject:_selected];
        _lastSelected = _selected;
        [_collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    if (cell && self.delegate && [self.delegate respondsToSelector:@selector(operaUpdateSchedule:didSelectItem:)]) {
        [self.delegate operaUpdateSchedule:self didSelectItem:_datas[indexPath.item]];
    }
}

- (void)deselectDate {
//    if (_lastSelecteds.count <= 0) {
    if (!_lastSelected) {
        //        [_lastSelecteds addObject:_selected];
        _lastSelected = _selected;
        return;
    }

//    [_lastSelecteds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_datas indexOfObject:_lastSelecteds[idx]] inSection:0];
//        NSLog(@"%ld - %ld", indexPath.section, indexPath.item);
//        MEOperaUpdateScheduleCell *cell = (MEOperaUpdateScheduleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//        if (!cell) {
//            return;
//        }
//        cell.selected = NO;
//        [cell configureAppearance];
//        [_lastSelecteds removeObjectAtIndex:idx];
//    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_datas indexOfObject:_lastSelected] inSection:0];
    NSLog(@"%ld - %ld", indexPath.section, indexPath.item);
    MEOperaUpdateScheduleCell *cell = (MEOperaUpdateScheduleCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    cell.selected = NO;
    [cell configureAppearance];
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self deselectDate];
//    if (_lastSelecteds.count > 1 && [_lastSelecteds containsObject:_selected]) {
//        [_lastSelecteds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_datas indexOfObject:_lastSelecteds[idx]] inSection:0];
//            if ([_collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
//
//            }
//        }];
//    }
//}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    if (![_lastSelecteds containsObject:_selected]) {
//        [self deselectDate];
//        [_lastSelecteds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_datas indexOfObject:_lastSelecteds[idx]] inSection:0];
//            if ([_collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
//                [self deselectDate];
//            }
//        }];
//    }
//    if (![_nextSelected isEqualToDictionary:_selected]) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_datas indexOfObject:_nextSelected] inSection:0];
//        if ([_collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
//            [self selectDateWithIndexPath:indexPath];
//        }
//    }
//}

#pragma mark - Public

- (void)scrollToItem:(NSInteger)item {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [self deselectDate];
    [self selectDateWithIndexPath:indexPath];
}

@end

@implementation MEOperaUpdateScheduleLayout

-(instancetype)init {
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

-(void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) / 7 , CGRectGetHeight(self.collectionView.frame));
}

@end
