//
//  MEScrollView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/13.
//  Copyright © 2020 nazimai. All rights reserved.
//
#define IS_IPHONEX                              ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.width == 812 || [UIScreen mainScreen].bounds.size.height == 896 || [UIScreen mainScreen].bounds.size.width == 896)
#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

#import "MEScrollViewController.h"
#import "UIView+MEWeekdayCalendarExtensions.h"
#import "MEOperaUpdateTableController.h"

@interface MEScrollViewController() <UITableViewDelegate, UIScrollViewDelegate> {
    NSInteger _selected;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MEOperaUpdateTableController *tableView;

@end

@implementation MEScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self setUpTableView];
}

- (void)setUpTableView {
    if (self.datas.count <=0 ) {
        MEOperaUpdateTableController *tableView = [[MEOperaUpdateTableController alloc] init];
        tableView.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        tableView.datas = self.datas;
        [self.scrollView addSubview:tableView.view];
        [self addChildViewController:tableView];
    } else {
        [self.datas enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            MEOperaUpdateTableController *tableView = [[MEOperaUpdateTableController alloc] init];
            tableView.view.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * idx, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            tableView.datas = dic[@"week"];
            tableView.cellClick = ^(NSDictionary * _Nonnull dic) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellWithItem:)]) {
                    [self.delegate didSelectedCellWithItem:dic];
                }
            };
            [self.scrollView addSubview:tableView.view];
            [self addChildViewController:tableView];
        }];
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView.contentSize = CGSizeMake(MAX(self.view.me_width, self.view.me_width * _datas.count), 0);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewController:didScrollItem:)]) {
        [self.delegate scrollViewController:self didScrollItem:self.datas[num]];
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

@end
