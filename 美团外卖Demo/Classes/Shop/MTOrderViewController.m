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
#import "MTRightCell.h"
#import "MTRightHeaderView.h"

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";
static NSString *R_HeaderView = @"rightHeaderView";

@interface MTOrderViewController ()
<UITableViewDataSource,
UITableViewDelegate,
MTRightCellDelegate,
CAAnimationDelegate
>

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

#pragma mark  启动默认左侧cell选中行
- (void)viewDidAppear:(BOOL)animated{
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_leftTableView selectRowAtIndexPath:idxPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark 选中左侧cell 右侧cell联动
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {

        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [_rightTableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark 右侧滚到哪个cell 让左侧cell联动
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(_rightTableView.isTracking || _rightTableView.isDecelerating || _rightTableView.isDragging){
        
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
        [_leftTableView selectRowAtIndexPath:idxPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
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
        make.left.equalTo(leftTableView.mas_right);
        make.right.top.equalTo(self.view);
        make.bottom.equalTo(cartView.mas_top);
    }];
    
    [cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(46);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //MARK:记录tableView
    _leftTableView = leftTableView;
    _rightTableView = rightTableView;
    
    //MARK:设置行高
    _leftTableView.rowHeight = 55;
    _rightTableView.estimatedRowHeight = 200;
    _rightTableView.rowHeight = UITableViewAutomaticDimension;
    
    //MARK:记录tableView  设置数据源  注册cell
    leftTableView.dataSource = self;
    rightTableView.dataSource = self;
    
    leftTableView.delegate = self;
    rightTableView.delegate = self;
    
    [leftTableView registerClass:[MTLeftCell class] forCellReuseIdentifier:leftCell];
    [rightTableView registerClass:[MTRightCell class] forCellReuseIdentifier:rightCell];
    
    //注册右侧自定义头部样式
    [rightTableView registerClass:[MTRightHeaderView class] forHeaderFooterViewReuseIdentifier:R_HeaderView];
    rightTableView.sectionHeaderHeight = 32;
    
}

#pragma mark 实现动画对象的代理方法

#pragma mark rightCell中按钮添加红点的代理方法
- (void)rightCell:(MTRightCell *)rightCell andBtnPoint:(CGPoint)point{
    //MARK:创建红点视图
    UIImageView *redPointView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    [self.view addSubview:redPointView];
    
    //坐标转换
    CGPoint pointToShopView = [rightCell convertPoint:point toView:self.view];
    
    redPointView.center = pointToShopView;
    
    //MARK:关键帧动画创建红点移动路径
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointToShopView];
    [path addQuadCurveToPoint:CGPointMake(60, self.view.bounds.size.height -60) controlPoint:CGPointMake(pointToShopView.x -160, pointToShopView.y - 230)];
    
    ani.path = path.CGPath;
    ani.duration = 0.3;
    
    //添加动画代理
    ani.delegate = self;
    //动画对象中保持图片对象
    [ani setValue:redPointView forKey:@"redView"];
    
    //动画对象作用给红点
    [redPointView.layer addAnimation:ani forKey:@"keyAni"];
}

#pragma mark  自定义cell组头视图的方法实现
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _rightTableView){
        MTRightHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:R_HeaderView];
        headerView.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
        headerView.sectionLabel.text = _foodList[section].name;
        return headerView;
    }
    return nil;
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
    MTRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
    
    //设置右侧cell的代理
    cell.delegate = self;
    
    cell.foodDetail = _foodList[indexPath.section].spus[indexPath.row];
    
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
