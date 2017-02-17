//
//  MTShopViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/17.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTShopViewController.h"

#define TOPVIEW_HEIGHT 124

@interface MTShopViewController ()
@property (nonatomic, weak) UIView *topView;

@end

@implementation MTShopViewController

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:102.0 /255.0 green:205 /255.0 blue:153 /255.0 alpha:1];
    
    //
}


- (void)setupUI{
    //MARK: 头部顶部视图
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithRed:255 /255.0 green:204 /255.0 blue:204 /255.0 alpha:1];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(TOPVIEW_HEIGHT);
    }];
    
    
    //赋值给属性
    _topView = topView;
    
    
    
    //中间:商家功能分类视图
    UIView *categoryView = [[UIView alloc]init];
    categoryView.backgroundColor = [UIColor colorWithRed:153.0 /255.0 green:204 /255.0 blue:204 /255.0 alpha:1];
    [self.view addSubview:categoryView];
    
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
    //底部:scrollView
    UIScrollView *scrView = [[UIScrollView alloc]init];
    scrView.backgroundColor =   [UIColor colorWithRed:255 /255.0 green:255 /255.0 blue:102 /255.0 alpha:1];
    [self.view addSubview:scrView];
    
    [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(categoryView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    //添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(scaleTopView:)];
    
    [self.view addGestureRecognizer:pan];
}

#pragma mark - 拖拽手势自动调用的方法
-(void)scaleTopView:(UIPanGestureRecognizer *)sender{
    
    //获取当前拖拽的位移值
    CGPoint offset = [sender translationInView:sender.view];
    
    NSLog(@"%.2f",offset.y);
    //复位
    [sender setTranslation:CGPointZero inView:sender.view];
    
    CGFloat height = _topView.bounds.size.height + offset.y;
    
    if(height < NAV_STATUS_HEIGHT  || height > TOPVIEW_HEIGHT){
        return;
    }
    
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    //可移动的高度
    CGFloat offsetHeight = TOPVIEW_HEIGHT - NAV_STATUS_HEIGHT;
    
    //取出之前的alpha
    CGFloat currentAlpha = self.navigationController.navigationBar.alpha;
    
    //用当前移动的高度
    CGFloat alpha =  currentAlpha - offset.y * 1 / offsetHeight;
    
    //设置给导航条
    self.navigationController.navigationBar.alpha = alpha;
}














@end
