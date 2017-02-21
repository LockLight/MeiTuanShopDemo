//
//  MTFoodDetailViewController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTFoodDetailViewController.h"
#import "MTHeaderDetailView.h"
#import "UIImageView+WebCache.h"

@interface MTFoodDetailViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UITableView *foodDetailTB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHeightConstraint;
@property (nonatomic, weak) MTHeaderDetailView *headerDetailView;

@end

@implementation MTFoodDetailViewController

//设置图片,不能在setter方法内赋值,视图可能还未创建
- (void)viewWillAppear:(BOOL)animated{
    _headerDetailView.foodDetail = _foodDetail;
    
    //使用第三方框架加载图片
    NSString *picStr = [_foodDetail.picture stringByDeletingPathExtension];
    NSURL *url = [NSURL URLWithString:picStr];
    
    [_iconView sd_setImageWithURL:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark 代理方法:监听tableView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _picHeightConstraint.constant = ABS(scrollView.contentOffset.y);
}

- (void)setupUI{
    //设置tableView滚动内边距,显示顶部iconView
    _foodDetailTB.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    //设置tabelView背景色透明
    _foodDetailTB.backgroundColor =  [UIColor clearColor];
    //消除tableView单元格分割线
    _foodDetailTB.tableFooterView = [[UIView alloc]init];
    
    //设置tableView代理
    _foodDetailTB.delegate = self;
    
    //创建表头视图
    MTHeaderDetailView *headerView = [MTHeaderDetailView headerDetailView];
    _foodDetailTB.tableHeaderView = headerView;
    
    
    //记录表头视图
    _headerDetailView = headerView;
}

@end
