//
//  MTHeaderDetailView.h
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTBaseView.h"
#import "MTFoodDetail.h"


@interface MTHeaderDetailView : MTBaseView

@property (nonatomic, strong) MTFoodDetail *foodDetail;

+ (instancetype)headerDetailView;

@end
