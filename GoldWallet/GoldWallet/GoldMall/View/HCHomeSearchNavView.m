//
//  HCHomeSearchNavView.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCHomeSearchNavView.h"
@interface HCHomeSearchNavView ()<UITextFieldDelegate>
@property (nonatomic, readwrite, copy) searchhHomeResult completion;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, readwrite, strong) UIButton *cancleBtn;

@property (nonatomic, readwrite, strong) UILabel *lineLabel;
@end

@implementation HCHomeSearchNavView

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc]init];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"#FE9E15"] forState:UIControlStateNormal];
        
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13*kWidthScale()];
        
        [_cancleBtn addTarget:self action:@selector(backHomeViewcontroller:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancleBtn;
}


+ (instancetype)searchViewWithSearchResult:(searchhHomeResult)block {
    HCHomeSearchNavView *searchView = [[self alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth(), 44.0)];
    searchView.completion = block;
    return searchView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self composeUI];
        
        @weakify(self)
        [[[self.searchTextField.rac_textSignal filter:^BOOL(NSString  *_Nullable value) {
            return value.length != 0;
        }] throttle:0.5] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            if (self.completion) {
                self.completion(x);
            }
        }];
    }
    return self;
}

- (void)composeUI {
    
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
        
        make.width.equalTo(@(300*kWidthScale()));
        
    }];
    
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.backgroundColor = [UIColor colorWithHexString:@"#EFF1F1"];
    
    [self addSubview:_lineLabel];
    
    [self addSubview:self.searchTextField];
    
    [self addSubview:self.cancleBtn];
    
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-12*kWidthScale());
        
        make.centerY.equalTo(self.searchTextField.mas_centerY).with.offset(0*kHeightScale());
        
        make.height.equalTo(@(20*kHeightScale()));
        
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(0*kWidthScale());
        
        make.left.equalTo(self.mas_left);
        
        make.right.equalTo(self.mas_right);
        
        make.height.equalTo(@(0.5*kWidthScale()));
        
    }];
    
    [_searchTextField becomeFirstResponder];
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
    
    
}
- (void)backHomeViewcontroller:(UIButton *)sender{
    [self.viewController.navigationController popViewControllerAnimated:NO];
    
}
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    //    self.completion(searchText);
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 放弃作为第一个响应者，关闭键盘
    [searchBar resignFirstResponder];
}
@end
