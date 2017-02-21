//
//  MTShoppingListViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/20.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTShoppingListViewController.h"
#import "MTPresentationController.h"

@interface MTShoppingListViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation MTShoppingListViewController

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    //创建弹出的控制器
    MTPresentationController *presentVc = [[MTPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
    return presentVc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        //自定义转场效果
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        self.view.backgroundColor = [UIColor clearColor];
        //设置自定义转场代理
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
