//
//  MTPageContainerViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTPageContainerViewController.h"
#import "MTFoodDetailViewController.h"
#import "MTCartView.h"
#import "MTHeaderDetailView.h"

@interface MTPageContainerViewController ()<UIPageViewControllerDataSource,CAAnimationDelegate>

@property (nonatomic, weak) MTCartView  *cartView;

@end

@implementation MTPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    //MARK:创建分页控制器
    UIPageViewController *pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //添加分页控制器的子控制器
    MTFoodDetailViewController *foodDetailVC = [[MTFoodDetailViewController alloc]init];
    
        //传入食物信息模型
    foodDetailVC.foodDetail = _foodList[_selectPath.section].spus[_selectPath.row];
    
    [pageVC setViewControllers:@[foodDetailVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    pageVC.dataSource = self;
    
    //将分页控制器作为子控制器加入当前控制器
    [self.view addSubview:pageVC.view];
    [self addChildViewController:pageVC];
    [pageVC didMoveToParentViewController:self];
    
    
    //MAKR:创建底部购物车
    UINib *nib = [UINib nibWithNibName:@"MTCartView" bundle:nil];
    MTCartView *cartView = [nib instantiateWithOwner:nil options:nil].lastObject;
    [self.view addSubview:cartView];
    
    [cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(46);
    }];
    
    //赋值给属性
    _cartView = cartView;
    //已添加的食物模型传入当前视图
    cartView.selectedFoods = _selectedFoods;
    
    //MARK:订阅通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addToCartView:) name:ADDFOOD object:nil];
}

#pragma mark 实现监听到的通知方法
- (void)addToCartView:(NSNotification *)noticeCenter{
    //根据通知传递的info获取当前点击坐标
    CGPoint point = [noticeCenter.userInfo[@"position"]CGPointValue];
    //获取当前食品详情对象
    MTHeaderDetailView *headerDetailView = noticeCenter.object;
    //创建红色原点
    UIImageView *redPointView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    [self.view addSubview:redPointView];
                                 
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //坐标转换
    CGPoint pointToPageView = [headerDetailView convertPoint:point toView:self.view];
    redPointView.center = pointToPageView;
    
    [path moveToPoint:pointToPageView];
    [path addQuadCurveToPoint:CGPointMake(50, self.view.bounds.size.height -50) controlPoint:CGPointMake(pointToPageView.x - 160 , pointToPageView.y - 230)];
    
    //关键帧动画
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = path.CGPath;
    ani.duration = 0.3;
    
    ani.delegate = self;
    
    //添加红点视图对象到动画对象
    [ani setValue:redPointView forKey:@"redPointView"];
    
    //动画对象作用到红点
    [redPointView.layer addAnimation:ani forKey:@"KeyAni"];
    
//    //判断选中模型内是否有当前模型对象
//    if( ![_selectedFoods containsObject:headerDetailView.foodDetail]){
//        [_selectedFoods addObject:headerDetailView.foodDetail];
//    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //动画完成后移除红点
    UIImageView *redPointView = [anim valueForKey:@"redPointView"];
    [redPointView removeFromSuperview];
    
    MTFoodDetail *detail = _foodList[_selectPath.section].spus[_selectPath.row];
    
    //判断选中模型内是否有当前模型对象
    if( ![_selectedFoods containsObject:detail]){
        [_selectedFoods addObject:detail];
    }
    
    NSUInteger count = 0;
    
    for (MTFoodDetail * slDetail in _selectedFoods) {
        count += slDetail.goodsNum;
    }
    
    NSLog(@"page count = %zd",count);
    
    
    //完成后传递数据给购物车视图
    _cartView.selectedFoods = _selectedFoods;
}


- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 分页控制器数据源方法
//上一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //当前行索引 列索引
    NSInteger row = _selectPath.row;
    NSInteger section = _selectPath.section;
    
    //当前索引-1
    row--;
    if(row<0){
        section--;
        if(section < 0){
            NSLog(@"前面已无数据");
            return nil;
        }
        row = _foodList[section].spus.count - 1;
    }
    
    //创建该页的详情控制器
    MTFoodDetailViewController *foodDetailVC =  [[MTFoodDetailViewController alloc]init];
        //传递当前索引数据
    foodDetailVC.foodDetail = _foodList[section].spus[row];
    
#warning MARK  修改当前选中索引
    _selectPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    return foodDetailVC;
}


//下一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //当前行索引 列索引
    NSInteger row = _selectPath.row;
    NSInteger section = _selectPath.section;
    
    //取出当前组数据
    MTFood *food = _foodList[section];
    
    //当前索引+1
    row++;
    if(row == food.spus.count ){
        section++;
        if(section == _foodList.count){
            NSLog(@"后面已无数据");
            return nil;
        }
        //重新设置 组与行 索引
        food = _foodList[section];
        row = 0;
    }
    
    //创建该页的详情控制器
    MTFoodDetailViewController *foodDetailVC =  [[MTFoodDetailViewController alloc]init];
    //传递当前索引数据
    foodDetailVC.foodDetail = _foodList[section].spus[row];
    
#warning MARK  修改当前选中索引
    _selectPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    return foodDetailVC;
    
}








@end
