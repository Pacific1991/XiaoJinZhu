//
//  HCServerInterface.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCServerInterface_h
#define HCServerInterface_h


static NSString * const HCHostURL = @"http://llj.sybgt.cn";

static NSString * const HCUploadImageURL = @"/Home/Api/uploadFile";
#pragma mark - 登录注册


#pragma mark - 商城
/** 商品详情数据 */
static NSString * const HCGoodDetailURL = @"/Home/Api/commodityDetails";
/** 商品类别获取 */
static NSString * const HCGetCommodityTypeURL = @"/Home/Api/preferenceType";
/** 商品类别列表数据 */
static NSString * const HCPreferenceListURL = @"/Home/Api/preferenceList";
/** 购物车列表数据 */
static NSString * const HCShoppingCartListURL = @"/Home/Api/shoppingCart";
/** 购物车数量 */
static NSString * const HCShoppingCartSumURL = @"/Home/Api/cartSum";
/** 加入购物车 */
static NSString * const HCJoinShoppingCartURL = @"/Home/Goods/joinCar";
/** 修改购物车商品数量 */
static NSString * const HCarNumSaveOrderURL = @"/Home/Api/carNumSave";
/** 删除购物车商品 */
static NSString * const HCDelShoppingCartURL = @"/Home/Api/cartDel";
#pragma mark - 产品

#pragma mark - 个人中心

#pragma mark - 首页

#endif /* HCServerInterface_h */
