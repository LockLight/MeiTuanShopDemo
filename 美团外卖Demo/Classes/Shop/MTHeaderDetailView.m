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

- (IBAction)addToCart:(UIButton *)sender {
}


@end
