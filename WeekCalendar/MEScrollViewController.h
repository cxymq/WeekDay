//
//  MEScrollView.h
//  WeekCalendar
//
//  Created by nazimai on 2020/7/13.
//  Copyright © 2020 nazimai. All rights reserved.
//
@class MEScrollViewController;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MEScrollViewDelegate <NSObject>

- (void)scrollViewController:(MEScrollViewController *)scrollViewController didScrollItem:(NSDictionary *)item;

- (void)didSelectedCellWithItem:(NSDictionary *)item;

@end

@interface MEScrollViewController : UIViewController

@property (nonatomic, weak) id<MEScrollViewDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)scrollToItem:(NSInteger)item;

@end

NS_ASSUME_NONNULL_END
