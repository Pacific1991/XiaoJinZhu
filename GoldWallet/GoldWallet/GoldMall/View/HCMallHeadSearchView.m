//
//  HCMallHeadSearchView.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCMallHeadSearchView.h"

@interface HCMallHeadSearchView ()<UITextFieldDelegate>
@property (nonatomic, readwrite, copy) searchResult completion;
@property (nonatomic, readwrite, strong) UITextField *searchTextField;
@property (nonatomic, readwrite, strong) UIButton *searchBtn;
@end

@implementation HCMallHeadSearchView

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        
    }
    return _searchTextField;
}

+ (instancetype)searchViewWithSearchResult:(searchResult)block {
    HCMallHeadSearchView *searchView = [[self alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth(), 45.0*kHeightScale())];
    searchView.completion = block;
    return searchView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self composeUI];

    }
    return self;
}

- (void)composeUI {

    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_searchBtn];
    [_searchBtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    
    [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10.5*kWidthScale());
        
        make.centerY.equalTo(self.mas_centerY).with.offset(0*kHeightScale());
        
        make.height.equalTo(@(35*kHeightScale()));
        
        make.width.equalTo(@(70*kWidthScale()));
        
    }];
    
    [self addSubview:self.searchBtn];
    
    
    _searchTextField = [[UITextField alloc] init];
    [self addSubview:self.searchTextField];
    _searchTextField.font = [UIFont systemFontOfSize:11*kWidthScale()];
    _searchTextField.placeholder = @"搜索商品";
    [_searchTextField setBackgroundColor:[UIColor colorWithHexString:@"#F2F3F4"]];
    _searchTextField.delegate = self;
    _searchTextField.tintColor= [UIColor colorWithHexString:@"999999"];
    _searchTextField.layer.masksToBounds = YES;
    _searchTextField.layer.cornerRadius = 30*kHeightScale()/2;
//    _searchTextField.layer.borderWidth = 0.5f;
//    _searchTextField.layer.borderColor = [UIColor colorWithHexString:@"C6C6C6"].CGColor;
    
    UIImageView *imgvFangdj = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5.5, 30, 16)];
    imgvFangdj.clipsToBounds = YES;
    imgvFangdj.contentMode = UIViewContentModeScaleAspectFit;
    [imgvFangdj setImage:[UIImage imageNamed:@"icon_search"]];
    _searchTextField.leftView =imgvFangdj;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [_searchTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(12*kWidthScale());
        
        make.centerY.equalTo(self.mas_centerY).with.offset(0*kHeightScale());
        
        make.height.equalTo(@(30*kHeightScale()));
        
        make.width.equalTo(@(275*kWidthScale()));
        
    }];
    
}

- (void)searchBtnClick:(UIButton *)sender {
    if (self.searchmallTip) {
        self.searchmallTip();
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length) {
        self.completion(textField.text);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_delegate EnterSearchResult];
    
}

@end
