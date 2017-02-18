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

- (void)setOffsetX:(CGFloat)offsetX{
    _offsetX = offsetX;
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(offsetX);
    }];
    
    //当前按钮索引
    NSInteger index = offsetX / _lineView.bounds.size.width;
    //取消原先按钮选中状态
    _selectBtn.selected = NO;
    
    //设置当前按钮选中状态
    _selectBtn = _btnList[index];
    _selectBtn.selected = YES;
}

- (void)setupUI{
    //创建3个btn
    NSArray *titleArr = @[@"菜式",@"评价",@"商家"];
    
    _btnList = [NSMutableArray arrayWithCapacity:titleArr.count];
    
    NSInteger index = 0;
    
    for (NSString *title in titleArr) {
        UIButton *btn = [UIButton cz_textButton:title fontSize:14 normalColor:[UIColor cz_colorWithHex:0x000000] selectedColor:[UIColor cz_colorWithHex:0xff0000]];
        
        btn.tag = index++;
        
        [self addSubview:btn];
        [_btnList addObject:btn];
        
        [btn addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_btnList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_btnList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    //设置默认启动按钮为第一个
    _btnList[0].selected = YES;
    _selectBtn = _btnList[0];
    
    
    //创建黄色导航条
    UIView *lineView =[[UIView alloc]init];
    lineView.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(_btnList[0]);
        make.height.mas_equalTo(4);
    }];
    
    _lineView = lineView;
}

- (void)changeCategory:(UIButton *)sender{
    //当前按钮的tag值传递给当前视图的tag
    self.tag = sender.tag;
 
    //发送消息给接受者
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    //根据当前frame立即更新位置
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}























@end
