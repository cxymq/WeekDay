//
//  MECalendarWeekdayView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#define MECalendarRound(c) roundf(c)

#import "MECalendarWeekdayView.h"
#import "MEWeekdayCalendar.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

// 计算每部分的宽度（取整）
static inline void MECalendarSliceCake(CGFloat cake, NSInteger count, CGFloat *pieces) {
    CGFloat total = cake;
    for (int i = 0; i < count; i++) {
        NSInteger remains = count - i;
        CGFloat piece = MECalendarRound(total/remains*2)*0.5;
        total -= piece;
        pieces[i] = piece;
    }
}

@interface MECalendarWeekdayView()

@property (strong, nonatomic) NSPointerArray *weekdayPointers;
@property (weak  , nonatomic) UIView *contentView;
@property (weak  , nonatomic) MEWeekdayCalendar *calendar;

@end

@implementation MECalendarWeekdayView

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
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contentView];
    _contentView = contentView;

    _weekdayPointers = [NSPointerArray weakObjectsPointerArray];
    for (int i = 0; i < 7; i++) {
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:weekdayLabel];
        [_weekdayPointers addPointer:(__bridge void * _Nullable)(weekdayLabel)];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;

    // 位置计算
    NSInteger count = self.weekdayPointers.count;
    size_t size = sizeof(CGFloat)*count;
    CGFloat *widths = malloc(size);
    CGFloat contentWidth = self.contentView.me_width;
    MECalendarSliceCake(contentWidth, count, widths);

    BOOL opposite = NO;
    if (@available(iOS 9.0, *)) {
        UIUserInterfaceLayoutDirection direction = [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.calendar.semanticContentAttribute];
        opposite = (direction == UIUserInterfaceLayoutDirectionRightToLeft);
    }
    CGFloat x = 0;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat width = widths[i];
        NSInteger labelIndex = opposite ? count-1-i : i;
        UILabel *label = [self.weekdayPointers pointerAtIndex:labelIndex];
        label.frame = CGRectMake(x, 0, width, self.contentView.me_height);
        x = CGRectGetMaxX(label.frame);
    }
    free(widths);
}

@end
