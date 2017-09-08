//
//  ViewController.m
//  RXRefresh
//
//  Created by srx on 2017/9/7.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "ViewController.h"
#import "RXRefresh.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy)UITableView * tableView;
@property (nonatomic, assign) NSInteger dataCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.tableView];
    self.dataCount = 2;
    
    __weak typeof(self)weakSelf = self;
    self.tableView.footer = [RXRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf startEndRefreshing];
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    [self.tableView reloadData];
}

- (void)startEndRefreshing {
    if(self.dataCount >15) {
        self.tableView.footer.nextRefreshText = @"没有数据啦";
        self.tableView.footer.refreshState = RXRefreshViewStateNoMoreData;
    }
    NSLog(@"开始你的表演");
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"~结束~你的表演");
        weakSelf.dataCount += 5;
        [self.tableView.footer endRefreshing];
        [weakSelf.tableView reloadData];
    });
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
