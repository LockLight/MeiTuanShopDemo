//
//  MTOrderViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTOrderViewController.h"
#import "MTFood.h"
#import "MTLeftCell.h"

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@interface MTOrderViewController ()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *leftTableView;
@property (nonatomic, weak) UITableView *rightTableView;

@end

@implementation MTOrderViewController{
    NSArray<MTFood *> *_foodList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:153 /255.0 green:204 /255.0 blue:205 /255.0 alpha:1];
    
    [self loadData];
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
    cartView.backgroundColor = [UIColor colorWithRed:153 /255.0 green:204 /255.0 blue:205 /255.0 alpha:1];
    [self.view addSubview:cartView];
    
    
    //MARK:三个tableView布局
    [leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.mas_equalTo(86);
        make.bottom.equalTo(cartView.mas_top);
    }];
    
    [rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTableView.mas_right).offset(6);
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
    
    [leftTableView registerClass:[MTLeftCell class] forCellReuseIdentifier:leftCell];
    [rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCell];
}


#pragma mark  数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _leftTableView){
        return 1;
    }
    return _foodList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _leftTableView) {
        return _foodList.count;
    }
    return _foodList[section].spus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _leftTableView){
        MTLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell forIndexPath:indexPath];
        cell.food = _foodList[indexPath.row];
    
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
    cell.textLabel.text = @"草莓圣代";
    
    return cell;
}

#pragma mark 解析加载jason数据
- (void)loadData{
    //获取地址 反序列化jason数据
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dataAll = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //定位准备数据
    NSArray *foodArr = dataAll[@"data"][@"food_spu_tags"];
    
    //准备模型数组
    NSMutableArray *foodList = [NSMutableArray array];
    for (NSDictionary *dict in foodArr) {
        
        MTFood *model = [MTFood new];
        [model setValuesForKeysWithDictionary:dict];
        [foodList addObject:model];
        
        }
        _foodList = foodList.copy;
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
