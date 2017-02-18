//
//  MTLeftCell.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTLeftCell.h"

@implementation MTLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setFood:(MTFood *)food{
    _food = food;
    
    self.textLabel.text = food.name;
}



- (void)setupUI{
    //栏目label
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.backgroundColor = [UIColor cz_colorWithHex:0x464646];
    self.textLabel.numberOfLines = 0;
    
    //背景色
    self.contentView.backgroundColor = [UIColor colorWithRed:255 /255.0 green:255 /255.0 blue:204 /255.0 alpha:1];
    
    //被选中视图的背景色
    UIView *selectView = [UIView new];
    selectView.backgroundColor = [UIColor colorWithRed:204/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    self.selectedBackgroundView = selectView;
    
    //黄色滑块
    UIView *silderView = [UIView new];
    silderView.backgroundColor = [UIColor yellowColor];
    [selectView addSubview:silderView];
    
    [silderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectView);
        make.size.mas_equalTo(CGSizeMake(4, 33));
    }];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end











