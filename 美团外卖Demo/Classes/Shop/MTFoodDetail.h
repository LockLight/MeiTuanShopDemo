//
//  MTFoodDetail.h
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTFoodDetail : NSObject
//商品名
@property (nonatomic, copy) NSString *name;
//商品图片
@property (nonatomic, copy) NSString *picture;
//商品描述
@property (nonatomic, copy) NSString *desc;
//月销售
@property (nonatomic, copy) NSString *month_saled_content;
//价格
@property (nonatomic, assign) CGFloat min_price;
//点赞数
@property (nonatomic, assign) NSInteger praise_num;
//商品购买数
@property (nonatomic, assign) NSInteger goodsNum;
@end
