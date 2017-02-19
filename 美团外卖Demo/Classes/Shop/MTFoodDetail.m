//
//  MTFoodDetail.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTFoodDetail.h"

@implementation MTFoodDetail

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"description"]){
        _desc = value;
    }
}

@end
