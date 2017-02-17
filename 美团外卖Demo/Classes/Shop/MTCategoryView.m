//
//  MTCategoryView.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTCategoryView.h"

@implementation MTCategoryView{
    NSMutableArray<UIButton *> *_btnList;
    UIView *_lineView;
    UIButton *_selectBtn;   //记录上一次被选中的按钮
}

- (void)setupUI{
    //创建3个btn
    NSArray *titleArr = @[@"菜式",@"评价",@"商家"];
    
    NSMutableArray<UIButton *> *btnList = [NSMutableArray array];
    
    NSInteger index = 0;
    
    for (NSString *title in titleArr) {
        UIButton *btn = [UIButton cz_textButton:title fontSize:14 normalColor:[UIColor cz_colorWithHex:0x000000] selectedColor:[UIColor cz_colorWithHex:0xff0000]];
        
        btn.tag = index++;
        
        [self addSubview:btn];
        [btnList addObject:btn];
        
        [btn addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [btnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    _btnList = btnList;
    
    //创建黄色导航条
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(btnList[0]);
        make.height.mas_equalTo(4);
    }];
    
    _lineView = lineView;
    
    //设置默认启动按钮为第一个
    btnList[0].selected = YES;
    _selectBtn = btnList[0];
}

- (void)changeCategory:(UIButton *)sender{
    //选中原先按钮的选中状态
    _selectBtn.selected = NO;
    
    //设置当前按钮选中状态
    sender.selected = YES;
    _selectBtn = sender;
    
    //根据当前按钮tag值,计算当前导航条的宽度
    CGFloat offsetX = sender.tag * sender.bounds.size.width;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(offsetX);
    }];
    
    //根据当前frame立即更新位置
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
    
    //当前按钮的tag值传递给当前视图的tag
    self.tag = sender.tag;
 
    //发送消息给接受者
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}























@end
