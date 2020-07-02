//
//  MEOperaUpdateScheduleCell.h
//  WeekCalendar
//
//  Created by nazimai on 2020/6/29.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEOperaUpdateScheduleDotIndicator;

NS_ASSUME_NONNULL_BEGIN

@interface MEOperaUpdateScheduleCell : UICollectionViewCell

@property (nonatomic, strong) MEOperaUpdateScheduleDotIndicator *dotIndicator;
@property (nonatomic, strong) NSString *weekTitle;
@property (nonatomic, strong) UILabel *weekLabel;

@property (nonatomic, strong) NSString *timeTitle;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) BOOL dateIsToday;

@property (nonatomic, assign) BOOL isSelectedFlag;

- (void)performSelecting;
- (void)configureAppearance;

@end

@interface MEOperaUpdateScheduleDotIndicator : UIView

@end
NS_ASSUME_NONNULL_END
