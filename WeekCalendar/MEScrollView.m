//
//  MEScrollView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/13.
//  Copyright © 2020 nazimai. All rights reserved.
//
#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

#import "MEScrollView.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

@interface MEScrollView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    NSInteger _selected;
    NSInteger _refreshIndex;
}

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;

@end

@implementation MEScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)datas {
    self = [super initWithFrame:frame];
    if (self) {
        self.datas = datas;
        self.scrollView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.me_width, self.me_height)];
        _scrollView.contentSize = CGSizeMake(MAX(self.me_width, self.me_width * _datas.count), 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UITableView *)tableView1 {
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:self.scrollView.bounds style:UITableViewStylePlain];
        [_tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.tableFooterView = [UIView new];
        [self.scrollView addSubview:_tableView1];
    }
    return _tableView1;
}

- (UITableView *)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:self.scrollView.bounds style:UITableViewStylePlain];
        [_tableView2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.tableFooterView = [UIView new];
        [self.scrollView addSubview:_tableView2];
    }
    return _tableView2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.datas[_refreshIndex][@"week"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *arr = self.datas[_refreshIndex][@"week"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 用来区分手滑还是 scrolToItem
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        return;
    }
    if ([scrollView isKindOfClass:UITableView.class]) {
        return;
    }
    CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
    if (point.x > 0) {// 右滑
        if (_selected == 0) {
            return;
        }
        _refreshIndex = _selected - 1;
        if ((_selected - 1) % 2 == 0) {
            [self.tableView1 reloadData];
            self.tableView1.frame = CGRectMake(UISCREEN_WIDTH * (_selected - 1), 0, UISCREEN_WIDTH, self.me_height);
        } else {
            [self.tableView2 reloadData];
            self.tableView2.frame = CGRectMake(UISCREEN_WIDTH * (_selected - 1), 0, UISCREEN_WIDTH, self.me_height);
        }
        NSUInteger num = ceilf(scrollView.contentOffset.x / UISCREEN_WIDTH);
        if (_selected == num) {
            return;
        }
        _selected = num;
    }
    if (point.x < 0) {// 左滑
        if (_selected == _datas.count - 1) {
            return;
        }
        _refreshIndex = _selected + 1;
        if ((_selected + 1) % 2 == 0) {
            [self.tableView1 reloadData];
            self.tableView1.frame = CGRectMake(UISCREEN_WIDTH * (_selected + 1), 0, UISCREEN_WIDTH, self.me_height);
        } else {
            [self.tableView2 reloadData];
            self.tableView2.frame = CGRectMake(UISCREEN_WIDTH * (_selected + 1), 0, UISCREEN_WIDTH, self.me_height);
        }
        NSUInteger num = floor(scrollView.contentOffset.x / UISCREEN_WIDTH);
        if (_selected == num) {
            return;
        }
        _selected = num;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didScrollItem:)]) {
        [self.delegate scrollView:self didScrollItem:_datas[_selected]];
    }
}

- (void)scrollToItem:(NSInteger)item {
    if (_selected == item) {
        return;
    }
    _selected = item;
    self.scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH * _selected, 0);
    _refreshIndex = _selected;
    if (_selected % 2 == 0) {
        [self.tableView1 reloadData];
        self.tableView1.frame = CGRectMake(UISCREEN_WIDTH * _selected, 0, UISCREEN_WIDTH, self.me_height);
    } else {
        [self.tableView2 reloadData];
        self.tableView2.frame = CGRectMake(UISCREEN_WIDTH * _selected, 0, UISCREEN_WIDTH, self.me_height);
    }
}

@end
