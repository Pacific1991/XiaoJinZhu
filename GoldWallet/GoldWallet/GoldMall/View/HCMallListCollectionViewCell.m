//
//  HCMallListCollectionViewCell.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCMallListCollectionViewCell.h"

@interface HCMallListCollectionViewCell ()

@property (nonatomic, readwrite, strong) UIImageView *productImage;

@property (nonatomic, readwrite, strong) UILabel *productNameLabel;

@property (nonatomic, readwrite, strong) UILabel *LineLabel;

@property (nonatomic, readwrite, strong) UILabel *priceLabel;

@end
@implementation HCMallListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.contentView.layer.cornerRadius = 3.0f;
        [self composeUI];
        [self setDataWithModel];
        [self addConstraint];
    }
    return self;
}

- (void)setDataWithModel{
    _productImage.image = [UIImage imageNamed:@"110"];
    _productNameLabel.text = @"月圆中秋";
    
    NSString * pricestr = [NSString stringWithFormat:@"¥%@",@"1188.00"];
    _priceLabel.text = pricestr;
}
- (void)composeUI {
    //商品数据
    
    _productImage = [[UIImageView alloc]init];
    _productImage.backgroundColor = [UIColor colorWithHexString:@"F6F6F6"];
    _productImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_productImage];
    self.productImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _productNameLabel = [[UILabel alloc]init];
    _productNameLabel.textColor = [UIColor colorWithHexString:@"313131"];
    _productNameLabel.font = [UIFont systemFontOfSize:14*kWidthScale()];
    [self.contentView addSubview:_productNameLabel];
    
    _LineLabel = [[UILabel alloc]init];
    _LineLabel.alpha = 0.1;
    _LineLabel.backgroundColor = [UIColor colorWithHexString:@"000000"];
    [self.contentView addSubview:_LineLabel];
    

    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:14*kWidthScale()];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#FE9E15"];
    [self.contentView addSubview:_priceLabel];
    
 
}

- (void)addConstraint{
    [_productImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0*kHeightScale());
        make.top.equalTo(self.contentView.mas_top).offset(18*kHeightScale());
        make.height.equalTo(@(77*kWidthScale()));
        make.width.equalTo(@(70*kWidthScale()));
    }];
    
   
    [_productNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0*kHeightScale());
        make.top.equalTo(self.productImage.mas_bottom).offset(13*kHeightScale());
        make.height.equalTo(@(15*kWidthScale()));
        make.width.equalTo(@(70*kWidthScale()));
        
    }];
    [_LineLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0*kHeightScale());
        make.top.equalTo(self.productNameLabel.mas_bottom).offset(11.5*kHeightScale());
        make.left.equalTo(self.contentView.mas_left).offset(20*kWidthScale());
        make.height.equalTo(@(1*kWidthScale()));
        
    }];
    
    
    [_priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0*kHeightScale());
        make.top.equalTo(self.LineLabel.mas_bottom).offset(13.5*kHeightScale());
        make.height.equalTo(@(15*kWidthScale()));
    }];
    
    
}

@end
