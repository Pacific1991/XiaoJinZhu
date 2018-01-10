//
//  HCBuyCarGoodTableViewCell.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBuyCarGoodTableViewCell.h"
@interface HCBuyCarGoodTableViewCell ()<UITextFieldDelegate>
@property (nonatomic, readwrite, weak) UIImageView *imgView;
@property (nonatomic, readwrite, weak) UIImageView *iconView;
@property (nonatomic, readwrite, weak) UIButton *selectButton;
@property (nonatomic, readwrite, weak) UILabel *nameLabel;
@property (nonatomic, readwrite, weak) UILabel *priceLabel;
@property (nonatomic, readwrite, weak) UILabel *typeLabel;

@property (nonatomic, readwrite, weak) UITextField *buyCountTextField;
@property (nonatomic, readwrite, weak) UIButton *addButton;
@property (nonatomic, readwrite, weak) UIButton *subButton;
@end
@implementation HCBuyCarGoodTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self creatSubViews];
        [self mas_layoutSubViews];
    }
    return self;
}

- (void)setModel:(HCBuyCarModel *)model {
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL imageURLWithString:model.goodsPic]];
    _iconView.highlighted = model.isSelected;
    [_nameLabel setText:model.goodsName];
    NSMutableAttributedString * mustr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@", model.goodsPrice]];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, mustr.length-1)];
    [_priceLabel setAttributedText:mustr];
    _typeLabel.text = [NSString stringWithFormat:@"规格:%@",model.specValue] ;
    [_buyCountTextField setText:[NSString stringWithFormat:@"%@", model.goodsNum]];
}

- (void)setIsDelete:(BOOL)isDelete {
    _isDelete = isDelete;
//    [_addButton setUserInteractionEnabled:!isDelete];
//    [_subButton setUserInteractionEnabled:!isDelete];
    [_buyCountTextField setUserInteractionEnabled:!isDelete];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_buyCountTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.goodsNum = @([textField.text integerValue]);
    [self changeBuyCountSendDelegate];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyCarCellDidBeginEditing:)]) {
        [self.delegate buyCarCellDidBeginEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField isValidAboutInputText:textField shouldChangeCharactersInRange:range replacementString:string decimalNumber:0];
}

#pragma mark - button click action
- (void)countButtonClickAction:(UIButton *)sender {
    NSInteger lastBuyCount = [_buyCountTextField.text integerValue];
    if (sender.tag == 10) {             /// add
        
        lastBuyCount += 1;
    } else {                            /// sub
        lastBuyCount -= 1;
        if (lastBuyCount <= 0) {
            lastBuyCount = 0;
        }
    }
    [_buyCountTextField setText:[NSString stringWithFormat:@"%ld", (long)lastBuyCount]];
    self.model.goodsNum = @(lastBuyCount);
    [self changeBuyCountSendDelegate];
}

- (void)selectButtonClickAction:(UIButton *)sender {
    self.model.isSelected = !self.model.isSelected;
    _iconView.highlighted = self.model.isSelected;
    [self changeBuyCountSendDelegate];
}

- (void)changeBuyCountSendDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyCarCellDidEndEditing:buyCarModel:)]) {
        [self.delegate buyCarCellDidEndEditing:self buyCarModel:self.model];
    }
}

#pragma mark - 创建视图
- (void)creatSubViews {
    UIImageView *imgView = [UIImageView new];
    _imgView = imgView;
    [self.contentView addSubview:_imgView];
    
    UIImageView *iconView = [UIImageView new];
    [iconView setHighlightedImage:[UIImage imageNamed:@"good_select"]];
    [iconView setImage:[UIImage imageNamed:@"mine_set_busine_become_white"]];
    _iconView = iconView;
    [self.contentView addSubview:_iconView];
    
    UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectButton addTarget:self action:@selector(selectButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectButton = selectButton;
    [self.contentView addSubview:_selectButton];
    
    UILabel *nameLabel = [UILabel new];
    [nameLabel setTextAlignment:(NSTextAlignmentLeft)];
    [nameLabel setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
    [nameLabel setFont:MHMediumFont(13.0f)];
    _nameLabel = nameLabel;
    [self.contentView addSubview:_nameLabel];
    
    UILabel *typeLaebl = [UILabel new];
    [typeLaebl setTextAlignment:(NSTextAlignmentLeft)];
    [typeLaebl setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
    [typeLaebl setFont:MHMediumFont(13.0f)];
    _typeLabel = typeLaebl;
    [self.contentView addSubview:_typeLabel];
    
    UILabel *priceLabel = [UILabel new];
    [priceLabel setTextColor:[UIColor colorWithHexString:@"#f64619"]];
    NSMutableAttributedString * mustr = [[NSMutableAttributedString alloc]initWithString:@"¥ 800"];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, mustr.length-1)];
    [priceLabel setAttributedText:mustr];
    _priceLabel = priceLabel;
    [self.contentView addSubview:_priceLabel];
    
    UITextField *buyCountTextField = [UITextField new];
    [buyCountTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [buyCountTextField setDelegate:self];
    [buyCountTextField setTextColor:[UIColor colorWithHexString:@"#4a4a4a"]];
    [buyCountTextField setTextAlignment:(NSTextAlignmentCenter)];
    [buyCountTextField setFont:MHMediumFont(13.0f)];
    buyCountTextField.layer.borderWidth = 0.5;
    buyCountTextField.layer.borderColor = [UIColor colorWithHexString:@"#9b9b9b"].CGColor;
    _buyCountTextField = buyCountTextField;
    [self.contentView addSubview:_buyCountTextField];
    
    UIButton *addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addButton setTag:10];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(countButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitleColor:[UIColor colorWithHexString:@"#4a4a4a"] forState:UIControlStateNormal];
    addButton.layer.borderWidth = 0.5;
    addButton.layer.borderColor = [UIColor colorWithHexString:@"#9b9b9b"].CGColor;
    _addButton = addButton;
    [self.contentView addSubview:_addButton];
    UIButton *subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [subButton setTag:11];
    [subButton setTitle:@"-" forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(countButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [subButton setTitleColor:[UIColor colorWithHexString:@"#4a4a4a"] forState:UIControlStateNormal];
    subButton.layer.borderWidth = 0.5;
    subButton.layer.borderColor = [UIColor colorWithHexString:@"#9b9b9b"].CGColor;
    _subButton = subButton;
    [self.contentView addSubview:_subButton];
}

#pragma mark - 约束视图
- (void)mas_layoutSubViews {
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Margin*1.5);
        make.bottom.equalTo(self.contentView).offset(-Margin * 1.5);
        make.width.equalTo(_imgView.mas_height);
        make.left.equalTo(_iconView.mas_right).offset(Margin/2.0);
    }];
    [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Margin * 2.0);
        make.top.equalTo(self.contentView).offset(Margin * 1.5);
        make.height.equalTo(_imgView).multipliedBy(0.22f);
        make.width.equalTo(_iconView.mas_height);
    }];
    [_selectButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.right.equalTo(_iconView);
    }];
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(Margin);
        make.top.equalTo(_imgView);
        make.height.equalTo(_imgView).multipliedBy(1.0/3.0);
        make.right.equalTo(self.contentView).offset(-Margin*2.0f);
    }];
    [_priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.right.height.equalTo(_nameLabel);
    }];
    [_typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.mas_bottom);
        make.left.height.equalTo(_nameLabel);
        make.width.equalTo(_priceLabel.mas_width).multipliedBy(1.5/3.0);

    }];
    [_addButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-Margin*2.5f);
        make.top.equalTo(_priceLabel.mas_bottom).offset(Margin/2.0);
        make.height.equalTo(_imgView).multipliedBy(1.1/3.0);
        make.width.equalTo(_addButton.mas_height);
    }];
    [_buyCountTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_addButton.mas_left);
        make.top.height.equalTo(_addButton);
        make.width.equalTo(_addButton).multipliedBy(2.3f);
    }];
    [_subButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buyCountTextField.mas_left);
        make.top.equalTo(_buyCountTextField);
        make.size.equalTo(_addButton);
    }];
}
@end
