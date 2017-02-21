//
//  MTPageContainerViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTPageContainerViewController.h"
#import "MTFoodDetailViewController.h"

@interface MTPageContainerViewController ()<UIPageViewControllerDataSource>

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
