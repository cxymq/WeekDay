//
//  ViewController.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "ViewController.h"
#import "MEOperaUpdateScheduleView.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

static NSInteger item;

@interface ViewController ()<MEOperaUpdateScheduleViewDelegate>

@property (nonatomic, strong) MEOperaUpdateScheduleView *scheduleView;
//@property (nonatomic, assign) NSInteger item;
@property (nonatomic, assign) BOOL sym;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MEOperaUpdateScheduleView *view = [[MEOperaUpdateScheduleView alloc] initWithFrame:CGRectMake(0, 100, self.view.me_width, 75)];
    view.datas = [self getDatas];
    view.delegate = self;
    item = 6;
    [self.view addSubview:view];
    _scheduleView = view;
    
//    if (@available(iOS 10.0, *)) {
//        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSInteger i = item + 1;
//            if (i >= self->_scheduleView.datas.count) {
//                i = 0;
//            }
//            [self->_scheduleView scrollToItem:i];
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
}

- (void)operaUpdateSchedule:(MEOperaUpdateScheduleView *)view didSelectItem:(NSDictionary *)items {
    NSLog(@"%@", items);
    item = [_scheduleView.datas indexOfObject:items];
}

- (NSArray *)getDatas {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: @"日", @"week", @"20", @"time", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys: @"一", @"week", @"21", @"time", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys: @"二", @"week", @"22", @"time", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys: @"三", @"week", @"23", @"time", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys: @"四", @"week", @"24", @"time", nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys: @"五", @"week", @"25", @"time", nil];
    NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys: @"六", @"week", @"26", @"time", nil];
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjectsAndKeys: @"八", @"week", @"27", @"time", nil];
    NSDictionary *dic9 = [NSDictionary dictionaryWithObjectsAndKeys: @"九", @"week", @"28", @"time", nil];
    NSArray *datas = @[dic, dic2, dic3, dic4, dic5, dic6, dic7
//                       , dic8, dic9
    ];
    return datas;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger i = item;
    
    if (i >= _scheduleView.datas.count - 1) {
        _sym = YES;
    }
    if (i < 1) {
        _sym = NO;
    }
    
    if (_sym) {
        i--;
    } else {
        i++;
    }
    [_scheduleView scrollToItem:i];
}

@end
