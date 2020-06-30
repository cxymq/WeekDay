//
//  UIView+MEWeekdayCalendarExtensions.h
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MEWeekdayCalendarExtensions)

@property (nonatomic) CGFloat me_width;
@property (nonatomic) CGFloat me_height;

@property (nonatomic) CGFloat me_top;
@property (nonatomic) CGFloat me_left;
@property (nonatomic) CGFloat me_bottom;
@property (nonatomic) CGFloat me_right;

@end


@interface CALayer (MEWeekdayCalendarExtensions)

@property (nonatomic) CGFloat me_width;
@property (nonatomic) CGFloat me_height;

@property (nonatomic) CGFloat me_top;
@property (nonatomic) CGFloat me_left;
@property (nonatomic) CGFloat me_bottom;
@property (nonatomic) CGFloat me_right;

@end


NS_ASSUME_NONNULL_END
