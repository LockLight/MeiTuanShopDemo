//
//  MTRightCell.h
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTFoodDetail.h"

@class MTRightCell;

@protocol MTRightCellDelegate <NSObject>

- (void)rightCell:(MTRightCell *)rightCell  andBtnPoint:(CGPoint)point;

@end

@interface MTRightCell : UITableViewCell

@property (nonatomic, strong)  MTFoodDetail *foodDetail;
@property (nonatomic, weak) id<MTRightCellDelegate> delegate;

@end
