//
//  MEWeekdayHeaderView.h
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEWeekdayIndicator;

CGFloat const MEWeekdayMaximumDotDiameter = 4.8;

NS_ASSUME_NONNULL_BEGIN

@interface MEWeekdayHeaderView : UIView

@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (assign, nonatomic) BOOL scrollEnabled;

@end

@interface MEWeekdayHeaderCell : UICollectionViewCell

@property (weak, nonatomic) MEWeekdayIndicator *dotIndicator;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) MEWeekdayHeaderView *header;

@end

@interface MEWeekdayHeaderLayout : UICollectionViewFlowLayout

@end

@interface MEWeekdayIndicator : UIView

@end

NS_ASSUME_NONNULL_END
