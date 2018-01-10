//
//  HCMallSectionCollectionReusableView.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCMallSectionCollectionReusableView.h"

@interface HCMallSectionCollectionReusableView()
@property (nonatomic, readwrite, weak) UIView *backView;
@property (nonatomic, strong) UIImageView *likeGuessImage;
@property (nonatomic, strong) UILabel *likeGuesslabel;
@end
@implementation HCMallSectionCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#F2F3F4"]];
        [self composeUI];
        [self setSectionWithData];
    }
    return self;
}
-(void)setSectionWithData{
    
    [_likeGuessImage setImage:[UIImage imageNamed:@"icon_stars"]];
    _likeGuesslabel.text = @"黄金商品";
}
- (void)composeUI {
    UIView *backView = [UIView new];
    [backView setBackgroundColor:[UIColor colorWithHexString:@"F2F3F4"]];
    _backView = backView;
    [self addSubview:_backView];
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    [self addSubview:_backView];
    
    _likeGuessImage = [[UIImageView alloc]init];
    [_backView addSubview:_likeGuessImage];
    
    
    [_likeGuessImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).with.offset(20*kWidthScale());
        
        make.centerY.equalTo(_backView.mas_centerY).with.offset(0*kHeightScale());
        
        make.height.equalTo(@(18*kWidthScale()));
        
        make.width.equalTo(@(18*kWidthScale()));
        
    }];
    
    _likeGuesslabel = [[UILabel alloc]init];
    _likeGuesslabel.font = [UIFont systemFontOfSize:16*kWidthScale()];
    [_backView addSubview:_likeGuesslabel];
    
    [_likeGuesslabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeGuessImage.mas_right).with.offset(5*kWidthScale());
        
        make.centerY.equalTo(_backView.mas_centerY).with.offset(0*kHeightScale());
        
        make.height.equalTo(@(16*kWidthScale()));
        
    }];
}
@end
