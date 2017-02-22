//
//  MTHeaderDetailView.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTHeaderDetailView.h"

@interface MTHeaderDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleCount;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;

@end

@implementation MTHeaderDetailView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _cartBtn.layer.cornerRadius = 20;
    _cartBtn.layer.masksToBounds = YES;
}

+ (instancetype)headerDetailView{
    UINib *nib = [UINib nibWithNibName:@"MTHeaderDetailView" bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

- (void)setFoodDetail:(MTFoodDetail *)foodDetail{
    _foodDetail = foodDetail;
    
    //名称
    _nameLabel.text = _foodDetail.name;
    //月售
    _saleCount.text = _foodDetail.month_saled_content;
    //价格
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",_foodDetail.min_price];
    //描述
    _descLabel.text = [NSString stringWithFormat:@"%@",_foodDetail.desc];
}

- (IBAction)addToCart:(UIButton *)sender {
    //点击一次当前食物+1
    _foodDetail.goodsNum ++;
    //创建通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //发送通知消息
    [center postNotificationName:ADDFOOD object:self userInfo:@{@"position":[NSValue valueWithCGPoint:sender.center]}];
}


@end
