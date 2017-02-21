//
//  MTPageContainerViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTPageContainerViewController.h"
#import "MTFoodDetailViewController.h"

@interface MTPageContainerViewController ()

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
    foodDetailVC.foodDetail = _foodList[_indexPath.section].spus[_indexPath.row];
    
    [pageVC setViewControllers:@[foodDetailVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    //将分页控制器作为子控制器加入当前控制器
    [self.view addSubview:pageVC.view];
    [self addChildViewController:pageVC];
    [pageVC didMoveToParentViewController:self];
}










@end
