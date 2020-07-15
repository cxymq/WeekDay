//
//  MEOperaUpdateView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/14.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEOperaUpdateView.h"

@interface MEOperaUpdateView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MEOperaUpdateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    MEOperaUpdateLayout *layout = [[MEOperaUpdateLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.clipsToBounds = YES;
    collectionView.bounces = NO;
    collectionView.allowsSelection = YES;
    collectionView.allowsMultipleSelection = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MEOperaUpdateCell"];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

@end

@implementation MEOperaUpdateLayout

- (instancetype)init {
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

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame));
}


@end
