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

@end

@implementation MTShopViewController

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
    
}













@end
