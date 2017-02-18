//
//  MTShopViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/17.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTShopViewController.h"
#import "MTCategoryView.h"

#define TOPVIEW_HEIGHT 124

@interface MTShopViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIScrollView *srcView;
@property (nonatomic, weak) MTCategoryView *categoryView;

@end

@implementation MTShopViewController

- (void)viewDidAppear:(BOOL)animated{
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
    MTCategoryView *categoryView = [[MTCategoryView alloc]init];
    [self.view addSubview:categoryView];
    
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
    [categoryView addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    _categoryView = categoryView;
    
    //底部:scrollView
    UIScrollView *scrView = [[UIScrollView alloc]init];
    scrView.backgroundColor =   [UIColor colorWithRed:255 /255.0 green:255 /255.0 blue:102 /255.0 alpha:1];
    [self.view addSubview:scrView];
    
    [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(categoryView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    //给srcView添加三个根控制器
    NSArray *classNameList = @[@"MTOrderViewController",
                               @"MTCommentViewController",
                               @"MTBussinessViewController"];
    
    //创建保持根视图的数组
    NSMutableArray<UIView *> *viewList = [NSMutableArray array];
    for (NSInteger i = 0; i < classNameList.count; i++) {
        Class cls = NSClassFromString(classNameList[i]);
        
        UIViewController *vc = [[cls alloc]init];
        
        //视图拖拽消失bug:需添加子视图控制器添加为父控制的容器控制器
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        
        //添加视图到scrollView
        [scrView addSubview:vc.view];
        [viewList addObject:vc.view];
    }
    
    //开启分页
    scrView.pagingEnabled = YES;
    
    _srcView = scrView;
    
    //设置srcView代理
    scrView.delegate = self;
    
    //设置scrView子视图约束
    [viewList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(scrView);
        //根据视图的宽高,计算contsize
        make.size.equalTo(scrView);
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
    
    [self.view  layoutIfNeeded];
    
    //可移动的高度
    CGFloat offsetHeight = TOPVIEW_HEIGHT - NAV_STATUS_HEIGHT;
    
//    //取出之前的alpha
//    CGFloat currentAlpha = self.navigationController.navigationBar.alpha;
//
//    //用当前移动的高度
//    CGFloat alpha =  currentAlpha - offset.y * 1 / offsetHeight;
    
    //计算可移动高度内alpha值变化比例
    CGFloat eachAlpha = 1 / offsetHeight;
    
    //设置给导航条
    self.navigationController.navigationBar.alpha -= eachAlpha * offset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算当前滚动偏移量
    CGFloat offsetX  = scrollView.contentOffset.x /3;
    
    //赋值给分类导航条偏移量
    _categoryView.offsetX = offsetX;
}

- (void)changePage:(MTCategoryView *)sender{
    NSLog(@"%zd",sender.tag);
    
    [_srcView setContentOffset:CGPointMake(sender.tag * _srcView.bounds.size.width, 0) animated:YES];
}









@end
