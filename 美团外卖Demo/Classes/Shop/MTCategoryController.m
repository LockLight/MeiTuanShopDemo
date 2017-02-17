//
//  MTCategoryController.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/17.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTCategoryController.h"

@interface MTCategoryController ()

@end

@implementation MTCategoryController{
    NSMutableArray<UIButton *> *_btnList;
    UIButton *_selectBtn;  //记录上一次被选中的按钮
    UIView *_lineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor colorWithRed:153.0 /255.0 green:204 /255.0 blue:204 /255.0 alpha:1];
    
    //MARK: 循环创建3个button
    NSArray *titileArr = @[@"菜式",@"评价",@"商家"];
    NSMutableArray<UIButton *> *btnList = [NSMutableArray array];
    
    NSInteger index = 0;
    for (NSString *title in titileArr) {
        UIButton *btn = [UIButton cz_textButton:title fontSize:14 normalColor:[UIColor cz_colorWithHex:0x000000] selectedColor:[UIColor cz_colorWithHex:0xff0000]];
        
        btn.tag = index++;
        
        [self.view addSubview:btn];
        [btnList addObject:btn];
        
        [btn addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _btnList = btnList;
    
    
    //设置水平方向排列及各项间距
    [btnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    //高
    [btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    //MARK: 创建导航条
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithRed:102/255.0 green:102 /255.0 blue:153 /255.0 alpha:1];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.mas_offset(btnList[0]);
        make.height.mas_offset(4);
    }];
    
    _lineView = lineView;
    
    //默认第一个按钮被选中状态
    btnList[0].selected = YES;
    _selectBtn = btnList[0];
}

- (void)changeCategory:(UIButton *)sender{
   //清除原先按钮的选中状态
    _selectBtn.selected = NO;
    
    //记录当前选中btn和状态
    sender.selected = YES;
    _selectBtn = sender;
    
    
}










@end
