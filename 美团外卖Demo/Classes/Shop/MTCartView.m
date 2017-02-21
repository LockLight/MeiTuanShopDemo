//
//  MTCartView.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/20.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTCartView.h"

@interface MTCartView ()
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation MTCartView


- (IBAction)ShowShoppingList:(UIButton *)sender {
    if(sender.selected){
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"showShoppingList" object:self];
    }
}


- (void)setSelectedFoods:(NSMutableArray *)selectedFoods{
    _selectedFoods = selectedFoods;
    
    //购物车状态
    _cartBtn.selected  = selectedFoods.count > 0;
    //菜式状态
    _countBtn.hidden = selectedFoods.count == 0;
    
    //总数
    NSInteger totalCount = 0;
    //总价
    CGFloat totalPrice = 0;
    
    for (MTFoodDetail *foodDetail in _selectedFoods) {
        totalCount += foodDetail.goodsNum;
        totalPrice += foodDetail.goodsNum * foodDetail.min_price;
    }
    
    //菜式总数
    [_countBtn setTitle:@(totalCount).description forState:UIControlStateNormal];
    //总价格
    if(selectedFoods.count == 0){
        _priceLabel.textColor = [UIColor grayColor];
        _priceLabel.text = @"购物车空空如也~";
    }else{
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.text = [NSString stringWithFormat:@"￥%.1f",totalPrice];
    }
    
    //差价
    CGFloat basicPrice = 20 - totalPrice;
    if(basicPrice >0){
        _commitBtn.backgroundColor = [UIColor cz_colorWithHex:0xcccccc];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"差%.1f起送",basicPrice];
        [_commitBtn setTitle:str forState:UIControlStateNormal];
    }else{
        _commitBtn.backgroundColor = [UIColor orangeColor];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commitBtn setTitle:@"结算" forState:UIControlStateNormal];
    }
    
    //购物车添加物品动画
    _cartBtn.transform = CGAffineTransformMakeScale(0.72, 0.72);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _cartBtn.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    
}












@end
