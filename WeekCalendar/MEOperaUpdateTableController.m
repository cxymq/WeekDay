//
//  MEOperaUpdateTableController.m
//  WeekCalendar
//
//  Created by nazimai on 2020/7/17.
//  Copyright © 2020 nazimai. All rights reserved.
//

#import "MEOperaUpdateTableController.h"

@interface MEOperaUpdateTableController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *nilView;

@end

@implementation MEOperaUpdateTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    if (datas.count > 0) {
        self.tableView.backgroundColor = UIColor.systemPinkColor;
    } else {
        self.nilView.backgroundColor = UIColor.lightGrayColor;
    }
}

#pragma mark - 初始化视图
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)nilView {
    if (!_nilView) {
        _nilView = [[UIView alloc] initWithFrame:self.view.bounds];
        UIImageView *nilImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        nilImgView.image = [UIImage imageNamed:@"m_musume_alpha3"];
        [_nilView addSubview:nilImgView];
        UILabel *nilLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nilImgView.frame) + 10, 320, 20)];
        nilLabel.text = @"暂未更新";
        nilLabel.textAlignment = NSTextAlignmentCenter;
        nilLabel.font = [UIFont systemFontOfSize:12];
        [_nilView addSubview:nilLabel];
        [self.view addSubview:_nilView];
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

@end
