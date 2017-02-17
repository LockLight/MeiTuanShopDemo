//
//  MTHomeViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/17.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTShopViewController.h"

@interface MTHomeViewController ()

@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加按钮跳转到商家页面
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    
    [btn addTarget:self action:@selector(pushShopVc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    [self pushShopVc:btn];
}

- (void)pushShopVc:(UIButton *)sender{
    MTShopViewController *shopVc = [[MTShopViewController alloc]init];
    
    [self.navigationController pushViewController:shopVc animated:YES];
}

@end
