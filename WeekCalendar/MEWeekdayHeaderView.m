//
//  MEWeekdayHeaderView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/6/28.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEWeekdayHeaderView.h"
#import "UIView+MEWeekdayCalendarExtensions.h"

@implementation MEWeekdayHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation MEWeekdayHeaderCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    MEWeekdayIndicator *dotIndicator;
    UILabel *titleLabel;

    dotIndicator = [[MEWeekdayIndicator alloc] initWithFrame:CGRectZero];
    dotIndicator.backgroundColor = [UIColor clearColor];
    dotIndicator.hidden = YES;
    [self.contentView addSubview:dotIndicator];
    self.dotIndicator = dotIndicator;

    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat titleHeight = self.bounds.size.height*5.0/6.0;
    CGFloat diameter = MIN(self.bounds.size.height*5.0/6.0,self.bounds.size.width);
    diameter = diameter > MEWeekdayMaximumDotDiameter ? (diameter - (diameter-MEWeekdayMaximumDotDiameter)*0.5) : diameter;
    CGFloat dotSize = self.bounds.size.height/6.0;
    // TODO: ------ x 应设置中间
    self.dotIndicator.frame = CGRectMake(0, 0, self.me_width, dotSize * 0.83);
    self.titleLabel.frame = CGRectMake(0, dotSize, self.me_width, floor(self.contentView.me_height*5.0/6.0));
    if (self.header.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat position = [self.contentView convertPoint:CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds)) toView:self.header].x;
        CGFloat center = CGRectGetMidX(self.header.bounds);
        if (self.header.scrollEnabled) {
            
        } else {
            
        }
    }
}

@end

@implementation MEWeekdayHeaderLayout

-(instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(1, 1);
    }
    return self;
}

-(void)prepareLayout {
    [self prepareLayout];
    self.itemSize = CGSizeMake(self.collectionView.me_width * 0.5, self.collectionView.me_height);
}
// TODO: ------ 屏幕转换

@end

@interface MEWeekdayIndicator()

@property (weak, nonatomic) UIView *contentView;
@property (weak, nonatomic) CALayer *dotLayer;

@end

@implementation MEWeekdayIndicator

-(instancetype)initWithFrame:(CGRect)frame {
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

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat diameter = MIN(MIN(self.me_width, self.me_height), MEWeekdayMaximumDotDiameter);
    self.contentView.me_height = self.me_height;
    self.contentView.me_width = diameter;
    self.contentView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

-(void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    if (layer == self.layer) {
        CGFloat diameter = MIN(MIN(self.me_width, self.me_height), MEWeekdayMaximumDotDiameter);
        _dotLayer.frame = CGRectMake(0, (self.me_height-diameter)*0.5, diameter, diameter);
        if (_dotLayer.cornerRadius != diameter/2) {
            _dotLayer.cornerRadius = diameter/2;
        }
    }
}

@end
