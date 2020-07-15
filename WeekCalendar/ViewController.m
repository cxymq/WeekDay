//
//  ViewController.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#define UISCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define IS_IPHONEX                              ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.width == 812 || [UIScreen mainScreen].bounds.size.height == 896 || [UIScreen mainScreen].bounds.size.width == 896)

#import "ViewController.h"
#import "MEOperaUpdateScheduleView.h"
#import "UIView+MEWeekdayCalendarExtensions.h"
#import "MEScrollView.h"

static NSUInteger item;

@interface ViewController ()<MEOperaUpdateScheduleViewDelegate, MEScrollViewDelegate>

@property (nonatomic, strong) MEOperaUpdateScheduleView *scheduleView;
//@property (nonatomic, assign) NSInteger item;
@property (nonatomic, assign) BOOL sym;

@property (nonatomic, strong) MEScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更新表";
    MEOperaUpdateScheduleView *view = [[MEOperaUpdateScheduleView alloc] initWithFrame:CGRectMake(0, (IS_IPHONEX ? 88 : 64), self.view.me_width, 75)];
    view.datas = [self getDatas];
    view.delegate = self;
    [self.view addSubview:view];
    _scheduleView = view;
    
    _scrollView = [[MEScrollView alloc] initWithFrame:CGRectMake(0, (IS_IPHONEX ? 88 : 64) + 75, UISCREEN_WIDTH, UISCREEN_HEIGHT - (IS_IPHONEX ? 88 : 64) - 75) dataSource:[self getDatas2]];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

- (void)operaUpdateSchedule:(MEOperaUpdateScheduleView *)view didSelectItem:(NSDictionary *)items {
    NSLog(@"operaUpdateSchedule -> %@", items);
    item = [_scheduleView.datas indexOfObject:items];
    [self.scrollView scrollToItem:item];
}

- (void)scrollView:(MEScrollView *)scrollView didScrollItem:(NSDictionary *)items {
    NSLog(@"scrollView -> %@", items);
    item = [[self getDatas2] indexOfObject:items];
    [self.scheduleView scrollToItem:item];
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
    NSDictionary *dic10 = [NSDictionary dictionaryWithObjectsAndKeys: @"十", @"week", @"29", @"time", nil];
    NSDictionary *dic11 = [NSDictionary dictionaryWithObjectsAndKeys: @"王", @"week", @"30", @"time", nil];
    NSArray *datas = @[dic, dic2, dic3, dic4, dic5, dic6, dic7
                       , dic8, dic9
                       , dic10, dic11
    ];
    return datas;
}

- (NSArray *)getDatas2 {
    NSDictionary *dic = @{ @"week" : @[@"20天干", @"地支"] };
    NSDictionary *dic2 = @{ @"week" : @[@"21甲", @"乙", @"丙", @"丁", @"戊", @"己", @"庚", @"辛", @"壬", @"癸"] };
    NSDictionary *dic3 = @{ @"week" : @[@"22子", @"丑", @"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥"] };
    NSDictionary *dic4 = @{ @"week" : @[@"23金", @"木", @"水", @"火", @"土"] };
    NSDictionary *dic5 = @{ @"week" : @[@"24子鼠", @"丑牛", @"寅虎", @"卯兔", @"辰龙", @"巳蛇", @"午马", @"未羊", @"申猴", @"酉鸡", @"戌狗", @"亥猪"] };
    NSDictionary *dic6 = @{ @"week" : @[@"25立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑"] };
    NSDictionary *dic7 = @{ @"week" : @[@"26立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", @"小寒", @"大寒"] };
    NSDictionary *dic8 = @{ @"week" : @[@"27春季", @"夏季", @"秋季", @"冬季"] };
    NSDictionary *dic9 = @{ @"week" : @[@"28春节（农历正月初一）", @"元宵节（农历正月十五）", @"龙抬头（农历二月初二）", @"社日节（农历二月初二）", @"寒食节（农历冬至后的105天）", @"清明节（公历4月5日前后）", @"端午节（农历五月初五）", @"七夕节（农历七月初七）", @"中元节（农历七月十五）", @"中秋节（农历八月十五）", @"重阳节（农历九月初九）", @"下元节（农历十月十五）", @"冬至节（公历12月21~23日）", @"除夕（年尾最后一天）"] };
    NSDictionary *dic10 = @{ @"week" : @[@"29冀", @"兖", @"青", @"徐", @"扬", @"荆", @"豫", @"益", @"雍"] };
    NSDictionary *dic11 = @{ @"week" : @[@"30伏羲", @"祝融", @"神农", @"黄帝", @"少昊", @"颛顼", @"帝喾", @"尧"] };
    NSArray *datas = @[dic, dic2, dic3, dic4, dic5, dic6, dic7
                       , dic8, dic9
                       , dic10, dic11
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
