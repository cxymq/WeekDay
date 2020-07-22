//
//  MEScrollView.h
//  WeekCalendar
//
//  Created by nazimai on 2020/7/22.
//  Copyright © 2020 nazimai. All rights reserved.
//
@class MEScrollView;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MEScrollViewDelegate <NSObject>

- (void)scrollView:(MEScrollView *)scrollView didScrollItem:(NSDictionary *)item;

- (void)didSelectedCellWithItem:(NSDictionary *)item;

@end

@interface MEScrollView : UIView

@property (nonatomic, weak) id<MEScrollViewDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)scrollToItem:(NSInteger)item;

@end

NS_ASSUME_NONNULL_END
