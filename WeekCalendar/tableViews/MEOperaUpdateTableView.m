//
//  MEOperaUpdateTableView.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/22.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEOperaUpdateTableView.h"
@interface MEOperaUpdateTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *nilView;

@end

@implementation MEOperaUpdateTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    if (datas.count > 0) {
        self.backgroundColor = UIColor.systemPinkColor;
    } else {
        self.nilView.backgroundColor = UIColor.lightGrayColor;
    }
}

- (UIView *)nilView {
    if (!_nilView) {
        _nilView = [[UIView alloc] initWithFrame:self.bounds];
        UIImageView *nilImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        nilImgView.image = [UIImage imageNamed:@"m_musume_alpha3"];
        [_nilView addSubview:nilImgView];
        UILabel *nilLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nilImgView.frame) + 10, 320, 20)];
        nilLabel.text = @"暂未更新";
        nilLabel.textAlignment = NSTextAlignmentCenter;
        nilLabel.font = [UIFont systemFontOfSize:12];
        [_nilView addSubview:nilLabel];
        [self addSubview:_nilView];
    }
    return _nilView;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellClick) {
        self.cellClick(self.datas[indexPath.row]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
