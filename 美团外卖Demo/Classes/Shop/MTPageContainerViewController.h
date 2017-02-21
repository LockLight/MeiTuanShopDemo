//
//  MTPageContainerViewController.h
//  美团外卖Demo
//
//  Created by locklight on 17/2/21.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTBaseViewController.h"
#import "MTFood.h"
#import "MTFoodDetail.h"

@interface MTPageContainerViewController : MTBaseViewController

@property (nonatomic, strong) NSArray<MTFood *> *foodList;

@property (nonatomic, strong) NSIndexPath *selectPath;

@property (nonatomic, strong) NSMutableArray<MTFoodDetail *> *selectedFoods;
@end
