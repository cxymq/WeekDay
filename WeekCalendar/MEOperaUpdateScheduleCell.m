//
//  MEOperaUpdateScheduleCell.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/29.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEOperaUpdateScheduleCell.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

@interface MEOperaUpdateScheduleCell()

@property (readonly, nonatomic) UIColor *colorForWeekLabel;
@property (readonly, nonatomic) UIColor *colorForTimeLabel;
@property (nonatomic, strong) UIColor *colorForCellBorder;
@property (nonatomic, strong) UIColor *colorForCellFill;

@end

@implementation MEOperaUpdateScheduleCell

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    MEOperaUpdateScheduleDotIndicator *dotIndicator;
    UILabel *weekLabel;
    CAShapeLayer *shapeLayer;
    UILabel *timeLabel;

    dotIndicator = [[MEOperaUpdateScheduleDotIndicator alloc] initWithFrame:CGRectZero];
    dotIndicator.backgroundColor = [UIColor clearColor];
    dotIndicator.hidden = YES;
    [self.contentView addSubview:dotIndicator];
    self.dotIndicator = dotIndicator;

    weekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    weekLabel.textAlignment = NSTextAlignmentCenter;
    weekLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:weekLabel];
    self.weekLabel = weekLabel;

    timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 1.0;
    shapeLayer.borderColor = [UIColor clearColor].CGColor;
    shapeLayer.opacity = 0;
    [self.contentView.layer insertSublayer:shapeLayer below:_timeLabel.layer];
    self.shapeLayer = shapeLayer;

    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _dotIndicator.frame = CGRectMake(0, 0, self.me_width, 5.f);
    CGFloat height = self.dotIndicator.me_top + self.dotIndicator.me_height + 4;
    CGFloat weekHeight = self.weekLabel.font.lineHeight;
    if (_weekTitle) {
        _weekLabel.text = _weekTitle;
        _weekLabel.frame = CGRectMake(0, height, self.me_width, weekHeight);
    }
    height = height + _weekLabel.me_height;
    CGFloat timeHeight = self.timeLabel.font.lineHeight;
    CGFloat timeOffSet = 10;
    if (_timeTitle) {
        _timeLabel.text = _timeTitle;
        _timeLabel.frame = CGRectMake(0, height + timeOffSet, self.me_width, timeHeight);
    }

    CGFloat shapeOffSet = 4;
    CGFloat diameter = MIN(self.me_width, timeHeight + (timeOffSet - shapeOffSet) * 2);
    _shapeLayer.frame = CGRectMake((self.me_width - diameter) / 2, height + shapeOffSet, diameter, diameter);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:_shapeLayer.bounds cornerRadius:_shapeLayer.me_width * 0.5].CGPath;
    if (!CGPathEqualToPath(_shapeLayer.path, path)) {
        _shapeLayer.path = path;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.window) { // Avoid interrupt of navigation transition somehow
        [CATransaction setDisableActions:YES]; // Avoid blink of shape layer.
    }
    self.shapeLayer.opacity = 0;
    [self.contentView.layer removeAnimationForKey:@"opacity"];
}

#pragma mark - Public

- (void)performSelecting {
//    _shapeLayer.opacity = 1;

//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    zoomOut.fromValue = @0.3;
//    zoomOut.toValue = @1.2;
//    zoomOut.duration = 0.15/4*3;
//    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    zoomIn.fromValue = @1.2;
//    zoomIn.toValue = @1.0;
//    zoomIn.beginTime = 0.15/4*3;
//    zoomIn.duration = 0.15/4;
//    group.duration = 0.15;
//    group.animations = @[zoomOut, zoomIn];
//    [_shapeLayer addAnimation:group forKey:@"bounce"];
    [self configureAppearance];
}

#pragma mark - Private

- (void)configureAppearance {
    UIColor *textColor = self.colorForWeekLabel;
    if (![textColor isEqual:_weekLabel.textColor]) {
        _weekLabel.textColor = textColor;
    }
    textColor = self.colorForTimeLabel;
    if (![textColor isEqual:_timeLabel.textColor]) {
        _timeLabel.textColor = textColor;
    }

    BOOL shouldHideShapeLayer = !self.isSelectedFlag;

    if (_shapeLayer.opacity == shouldHideShapeLayer) {
        _shapeLayer.opacity = !shouldHideShapeLayer;
    }
    if (!shouldHideShapeLayer) {
        CGColorRef cellFillColor = self.colorForCellFill.CGColor;
        if (!CGColorEqualToColor(_shapeLayer.fillColor, cellFillColor)) {
            _shapeLayer.fillColor = cellFillColor;
        }

        CGColorRef cellBorderColor = self.colorForCellBorder.CGColor;
        if (!CGColorEqualToColor(_shapeLayer.strokeColor, cellBorderColor)) {
            _shapeLayer.strokeColor = cellBorderColor;
        }

        CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:_shapeLayer.bounds cornerRadius:CGRectGetWidth(_shapeLayer.bounds)*0.5].CGPath;
        if (!CGPathEqualToPath(_shapeLayer.path, path)) {
            _shapeLayer.path = path;
        }
    }
}

#pragma mark - Properties

- (UIColor *)colorForCellFill {
    if (self.isSelectedFlag && self.dateIsToday) {
        return UIColor.systemPinkColor;
    }
    return UIColor.whiteColor;
}

- (UIColor *)colorForWeekLabel {
    if (self.isSelectedFlag) {
        return UIColor.redColor;
    }
    return UIColor.blackColor;
}

- (UIColor *)colorForTimeLabel {
    if (self.isSelectedFlag) {
        return self.dateIsToday ? UIColor.whiteColor : UIColor.redColor;
    }
    return UIColor.grayColor;
}

- (UIColor *)colorForCellBorder {
    if (self.isSelectedFlag) {
        return UIColor.redColor;
    }
    return UIColor.whiteColor;
}

@end

@interface MEOperaUpdateScheduleDotIndicator()

@property (weak, nonatomic) UIView *contentView;
@property (weak, nonatomic) CALayer *dotLayer;

@end

@implementation MEOperaUpdateScheduleDotIndicator

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
        self.contentView = view;
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor systemPinkColor].CGColor;
        _dotLayer = layer;
        [self.contentView.layer addSublayer:layer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat diameter = MIN(MIN(self.me_width, self.me_height), 5.f);
    self.contentView.me_height = self.me_height;
    self.contentView.me_width = diameter;
    self.contentView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    if (layer == self.layer) {
        CGFloat diameter = MIN(MIN(self.me_width, self.me_height), 5.f);
        _dotLayer.frame = CGRectMake(0, (self.me_height-diameter) * 0.5, diameter, diameter);
        if (_dotLayer.cornerRadius != diameter / 2) {
            _dotLayer.cornerRadius = diameter / 2;
        }
    }
}

@end
