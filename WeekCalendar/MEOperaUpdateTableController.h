//
//  MEOperaUpdateTableController.h
//  WeekCalendar
//
//  Created by nazimai on 2020/7/17.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MEOperaUpdateTableController : UIViewController

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) void(^cellClick)(NSDictionary *dic);

@end

NS_ASSUME_NONNULL_END
