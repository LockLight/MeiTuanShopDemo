//
//  MTFood.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTFood.h"
#import "MTFoodDetail.h"

@implementation MTFood

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"spus"]){
        //转化模型内部的模型
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in _spus) {
            
            MTFoodDetail *foodDetail = [MTFoodDetail new];
            [foodDetail setValuesForKeysWithDictionary:dict];
            [arrM addObject:foodDetail];
            
        }
        _spus = arrM.copy;
    }
}

//重写避免报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
