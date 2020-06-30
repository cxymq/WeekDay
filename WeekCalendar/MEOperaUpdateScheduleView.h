//
//  MEOperaUpdateScheduleView.h
//  WeekCalendar
//
//  Created by nazimai on 2020/6/29.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEOperaUpdateScheduleCell.h"

@class MEOperaUpdateScheduleLayout, MEOperaUpdateScheduleView;

NS_ASSUME_NONNULL_BEGIN

@protocol MEOperaUpdateScheduleViewDelegate <NSObject>

@optional
- (void)operaUpdateSchedule:(MEOperaUpdateScheduleView *)view didSelectItem:(NSDictionary *)item;

@end

@interface MEOperaUpdateScheduleView : UIView

@property (nonatomic, weak) id<MEOperaUpdateScheduleViewDelegate> delegate;

@property (nonatomic, strong) NSArray *datas;

- (void)scrollToItem:(NSInteger)item;

@end

@interface MEOperaUpdateScheduleLayout : UICollectionViewFlowLayout

@end

NS_ASSUME_NONNULL_END
