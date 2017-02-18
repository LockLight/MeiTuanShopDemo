//
//  MTOrderViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTOrderViewController.h"

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@interface MTOrderViewController ()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *leftTableView;
@property (nonatomic, weak) UITableView *rightTableView;

@end

@implementation MTOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:102 /255.0 green:204 /255.0 blue:204 /255.0 alpha:1];
}

- (void)setupUI{
    //MARK:左侧tableView
    UITableView *leftTableView = [[UITableView alloc]init];
    [self.view addSubview:leftTableView];
    //MARK:右侧tableView
    UITableView *rightTableView = [[UITableView alloc]init];
    [self.view addSubview:rightTableView];
    //MARK:底部购物栏tableview
    UITableView *cartView = [[UITableView alloc]init];
    cartView.backgroundColor = [UIColor colorWithRed:153 /255.0 green:102 /255.0 blue:204 /255.0 alpha:1];
    [self.view addSubview:cartView];
    
    
    //MARK:三个tableView布局
    [leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.mas_equalTo(86);
        make.bottom.equalTo(cartView.mas_top);
    }];
    
    [rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTableView.mas_right).offset(9);
        make.right.top.equalTo(self.view);
        make.bottom.equalTo(cartView.mas_top);
    }];
    
    [cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(46);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //MARK:记录tableView  设置数据源  注册cell
    _leftTableView = leftTableView;
    _rightTableView = rightTableView;
    
    leftTableView.dataSource = self;
    rightTableView.dataSource = self;
    
    [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCell];
    [rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _leftTableView){
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _leftTableView) {
        return 10;
    }
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _leftTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell forIndexPath:indexPath];
        cell.textLabel.text = @"热销推荐";
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
    cell.textLabel.text = @"草莓圣代";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
