//
//  MTRightCell.m
//  美团外卖Demo
//
//  Created by locklight on 17/2/18.
//  Copyright © 2017年 LockLight. All rights reserved.
//

#import "MTRightCell.h"
#import "UIImageView+WebCache.h"

@interface MTRightCell ()

@property (nonatomic, weak) UIImageView *dishView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *saleCount;
@property (nonatomic, weak) UIImageView *praiseIcon;
@property (nonatomic, weak) UILabel *praiseNum;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UIButton *minusBtn;
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *countLbl;

@end

@implementation MTRightCell{
    //记录购物车物品数量
    NSInteger _count;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setFoodDetail:(MTFoodDetail *)foodDetail{
    _foodDetail = foodDetail;
    
    //图片
    NSString *picture = [foodDetail.picture stringByDeletingPathExtension];
    NSURL *url = [NSURL URLWithString:picture];
    [_dishView sd_setImageWithURL:url];
    
    //名称
    _nameLabel.text = foodDetail.name;
    
    //月销售
    _saleCount.text = foodDetail.month_saled_content;
    
    //点赞数
    _praiseNum.text = [NSString stringWithFormat:@"%zd",foodDetail.praise_num];
    
    //价格
    NSString *rmb =  @"¥";
    _priceLabel.text = [NSString stringWithFormat:@"%@ %.1f",rmb,foodDetail.min_price];
    
    //描述
    _descLabel.text = foodDetail.desc;
    

}


- (void)setupUI{
    //默认间距
    CGFloat margin = 10;
    //设置分隔栏从左边顶部开始
    self.separatorInset = UIEdgeInsetsZero;
    //设置cell选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //图片
    UIImageView *dishView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    dishView.contentMode = UIViewContentModeScaleAspectFill;
    dishView.layer.cornerRadius = 5;
    dishView.layer.masksToBounds = YES;
    [self.contentView addSubview:dishView];
    
    [dishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin);
        make.top.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    //名称
    UILabel *nameLabel = [UILabel cz_labelWithText:@"天堂饭" fontSize:13 color:[UIColor cz_colorWithHex:0x000000]];
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dishView.mas_right).offset(margin);
        make.top.mas_equalTo(margin);
    }];
    
    //月销售
    UILabel *saleCount = [UILabel cz_labelWithText:@"月销售3099" fontSize:11 color:[UIColor cz_colorWithHex:0x7e7e7e]];
    [self.contentView addSubview:saleCount];
    
    [saleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(margin/2);
    }];
    
    //点赞图标
    UIImageView *praiseIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_food_review_praise"]];
    [self.contentView addSubview:praiseIcon];
    
    [praiseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(saleCount.mas_right).offset(margin/2);
        make.centerY.equalTo(saleCount.mas_centerY);
    }];
    
    //点赞数
    UILabel *praiseNum = [UILabel cz_labelWithText:@"109" fontSize:11 color:[UIColor cz_colorWithHex:0x7e7e7e]];
    [self.contentView addSubview:praiseNum];
    
    [praiseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(praiseIcon.mas_right).offset(margin/2);
        make.centerY.equalTo(saleCount.mas_centerY);
    }];
    
    //价格
    UILabel *priceLabel = [UILabel cz_labelWithText:@"￥19" fontSize:14 color:[UIColor cz_colorWithHex:0xfa2a09]];
    [self.contentView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(saleCount.mas_left);
        make.top.equalTo(saleCount.mas_bottom).offset(margin/2);
    }];
    
    //减号按钮
    UIButton *minusBtn = [UIButton new];
    [self.contentView addSubview:minusBtn];
    [minusBtn setImage:[UIImage imageNamed:@"icon_food_decrease_small_white_bg"] forState:UIControlStateNormal];
    [minusBtn sizeToFit];
    minusBtn.hidden = YES;
    
    
    //数量label
    UILabel *countLbl = [UILabel cz_labelWithText:@"0" fontSize:13 color:[UIColor grayColor]];
    [self.contentView addSubview:countLbl];
    countLbl.hidden = YES;
    
    //加号按钮
    UIButton *plusBtn = [UIButton new];
    [self.contentView addSubview:plusBtn];
    [plusBtn setImage:[UIImage imageNamed:@"icon_food_increase_small"] forState:UIControlStateNormal];
    [plusBtn sizeToFit];
    
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-margin);
        make.centerY.equalTo(priceLabel);
    }];
    
    [countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(plusBtn.mas_left).offset(-margin);
        make.centerY.equalTo(plusBtn);
    }];
    
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countLbl.mas_left).offset(-margin);
        make.centerY.equalTo(countLbl);
    }];

    
    //描述
    UILabel *descLabel = [UILabel cz_labelWithText:@"My library of personal projects is always growing. Here's a list of current projects if you want to check out what else I've been doing as a means to cope with everyday stress of client work: Brixx Letterpress, CSS Font Stack, Hex Color Tool, Minimal WP Themes, Responsive GS, The Design Grid." fontSize:11 color:[UIColor cz_colorWithHex:0x848484]];
    [self.contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dishView.mas_left);
        make.top.equalTo(dishView.mas_bottom).offset(16);
        make.right.equalTo(self.contentView).offset(-margin/2);
        make.bottom.equalTo(self.contentView).offset(-margin/2);
    }];
    
    //监听 + - 按钮点击事件
    [minusBtn addTarget:self action:@selector(changeCountLabel:) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn addTarget:self action:@selector(changeCountLabel:) forControlEvents:UIControlEventTouchUpInside];
    
    //赋值给属性
    _dishView = dishView;
    _nameLabel = nameLabel;
    _saleCount = saleCount;
    _praiseNum = praiseNum;
    _priceLabel = priceLabel;
    _descLabel = descLabel;
    _plusBtn = plusBtn;
    _minusBtn = minusBtn;
    _countLbl = countLbl;

}

- (void)changeCountLabel:(UIButton *)sender{
    if(sender == _minusBtn){
        _count--;
    }else{
        _count++;
        
        
    }
    
    //改变Countlabel数值
    _countLbl.text = @(_count).description;
    //设置Countlabel是否可见
    _countLbl.hidden = !_count;
    
    //减号按钮状态随countlabel状态变化
    _minusBtn.hidden = _countLbl.hidden;
}

@end
