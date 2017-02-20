//
//  MTPresentationController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/20.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTPresentationController.h"

@implementation MTPresentationController

- (void)containerViewWillLayoutSubviews{
    //取出被弹出控制器的根视图
    UIView *modalView = self.presentedView;
    
    
    //创建背景蒙版
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    bgView.frame = self.containerView.bounds;
    
    [self.containerView insertSubview:bgView atIndex:0];
    
    //创建点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(dismissModalVC:)];
    
    [bgView addGestureRecognizer:tap];
    
    [modalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.containerView);
        make.height.mas_equalTo(320);
    }];
}

- (void)dismissModalVC:(UITapGestureRecognizer *)sender{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
