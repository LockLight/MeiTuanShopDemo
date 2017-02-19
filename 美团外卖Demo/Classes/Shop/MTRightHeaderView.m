//
//  MTRightHeaderView.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/19.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTRightHeaderView.h"

@implementation MTRightHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
//    //背景色
//    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    //组头视图标签
    UILabel *sectionLabel = [UILabel cz_labelWithText:@"销售排行" fontSize:12 color:[UIColor cz_colorWithHex:0x404040]];
    [self.contentView addSubview:sectionLabel];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    _sectionLabel = sectionLabel;
}

@end
