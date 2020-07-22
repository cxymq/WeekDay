//
//  MEScrollView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/22.
//  Copyright © 2020 nazimai. All rights reserved.
//

#define IS_IPHONEX                              ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.width == 812 || [UIScreen mainScreen].bounds.size.height == 896 || [UIScreen mainScreen].bounds.size.width == 896)
#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

#import "MEOperaUpdateTableView.h"
#import "MEScrollView.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

@interface MEScrollView() <UIScrollViewDelegate> {
    NSInteger _selected;
}
@end

@implementation MEScrollView

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self setUpTableView];
}

- (void)setUpTableView {
    if (self.datas.count <=0 ) {
        MEOperaUpdateTableView *tableView = [[MEOperaUpdateTableView alloc] init];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        tableView.datas = self.datas;
        [self.scrollView addSubview:tableView];
    } else {
        __weak typeof(self) weakSelf = self;
        [self.datas enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            MEOperaUpdateTableView *tableView = [[MEOperaUpdateTableView alloc] init];
            tableView.frame = CGRectMake(CGRectGetWidth(self.frame) * idx, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            tableView.datas = dic[@"week"];
            tableView.cellClick = ^(NSDictionary * _Nonnull dic) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellWithItem:)]) {
                    [self.delegate didSelectedCellWithItem:dic];
                }
            };
            [self.scrollView addSubview:tableView];
        }];
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _scrollView.contentSize = CGSizeMake(MAX(self.me_width, self.me_width * _datas.count), 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger num = (long)(scrollView.contentOffset.x + UISCREEN_WIDTH * 0.5) / (NSInteger)UISCREEN_WIDTH;
    if (num == _selected) {
        return;
    }
    _selected = num;
    NSLog(@"scrollViewDidScroll num : %ld", num);
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didScrollItem:)]) {
        [self.delegate scrollView:self didScrollItem:self.datas[num]];
    }
}

#pragma mark - public method
- (void)scrollToItem:(NSInteger)item {
    if (_selected == item) {
        return;
    }
    _selected = item;
    self.scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH * _selected, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
