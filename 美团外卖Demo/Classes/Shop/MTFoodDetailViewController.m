//
//  MTFoodDetailViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTFoodDetailViewController.h"

@interface MTFoodDetailViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITableView *foodDetailTB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation MTFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 代理方法:监听tableView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _heightConstraint.constant = ABS(scrollView.contentOffset.y);
}

- (void)setupUI{
    //设置tableView滚动内边距,显示顶部iconView
    _foodDetailTB.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    //设置tabelView背景色透明
    _foodDetailTB.backgroundColor =  [UIColor clearColor];
    //消除tableView单元格分割线
//    _foodDetailTB.tableFooterView = [[UIView alloc]init];
    
    //设置tableView代理
    _foodDetailTB.delegate = self;
    
}

@end
