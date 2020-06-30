//
//  UIView+MEWeekdayCalendarExtensions.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "UIView+MEWeekdayCalendarExtensions.h"

@implementation UIView (MEWeekdayCalendarExtensions)

- (CGFloat)me_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setMe_width:(CGFloat)me_width
{
    self.frame = CGRectMake(self.me_left, self.me_top, me_width, self.me_height);
}

- (CGFloat)me_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setMe_height:(CGFloat)me_height
{
    self.frame = CGRectMake(self.me_left, self.me_top, self.me_width, me_height);
}

- (CGFloat)me_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setMe_top:(CGFloat)me_top
{
    self.frame = CGRectMake(self.me_left, me_top, self.me_width, self.me_height);
}

- (CGFloat)me_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMe_bottom:(CGFloat)me_bottom
{
    self.me_top = me_bottom - self.me_height;
}

- (CGFloat)me_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setMe_left:(CGFloat)me_left
{
    self.frame = CGRectMake(me_left, self.me_top, self.me_width, self.me_height);
}

- (CGFloat)me_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMe_right:(CGFloat)me_right
{
    self.me_left = self.me_right - self.me_width;
}

@end

@implementation CALayer (MEWeekdayCalendarExtensions)

- (CGFloat)me_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setMe_width:(CGFloat)me_width
{
    self.frame = CGRectMake(self.me_left, self.me_top, me_width, self.me_height);
}

- (CGFloat)me_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setMe_height:(CGFloat)me_height
{
    self.frame = CGRectMake(self.me_left, self.me_top, self.me_width, me_height);
}

- (CGFloat)me_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setMe_top:(CGFloat)me_top
{
    self.frame = CGRectMake(self.me_left, me_top, self.me_width, self.me_height);
}

- (CGFloat)me_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMe_bottom:(CGFloat)me_bottom
{
    self.me_top = me_bottom - self.me_height;
}

- (CGFloat)me_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setMe_left:(CGFloat)me_left
{
    self.frame = CGRectMake(me_left, self.me_top, self.me_width, self.me_height);
}

- (CGFloat)me_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMe_right:(CGFloat)me_right
{
    self.me_left = self.me_right - self.me_width;
}

@end
