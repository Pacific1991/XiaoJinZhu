//
//  HCConstString.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCConstString_h
#define HCConstString_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HCBodyTestType) {
    HCBodyTestTypeBody,             // 体质测试
    HCBodyTestTypeSubHealth,        // 亚健康测试
    HCBodyTestTypeIntestinal,       // 肠道测试
    HCBodyTestTypeTits,             // 乳房测试
    HCBodyTestTypeStomchche,        // 胃部测试
    HCBodyTestTypeBlood,            // 血管测试
    HCBodyTestTypeRostatitis,       // 前列腺测试
    HCBodyTestTypeOvarian           // 卵巢测试
};

/**
 我的订单状态
 */
typedef NS_ENUM(NSInteger, HCMyOrderListType) {
    HCMyOrderListTypeAll = 0,               /// 全部
    HCMyOrderListTypeWaitPay,           /// 待支付
    HCMyOrderListTypeWaitRecieve,       /// 待收货
    HCMyOrderListTypeWaitComment,        /// 待评价
    HCMyOrderListTypeWaitSendOut      /// 待发货

};
/**
 登录类型
 */
typedef NS_ENUM(NSInteger, HCLoginType) {
    HCLoginTypePassword = 0,       /// 密码
    HCLoginTypeVerificationCode,       /// 验证码
    HCLoginTypeQQLogin,       /// QQ登录
    HCLoginTypeWeChatLogin,       /// 微信登录
    HCLoginTypeWeiboLogin        /// 微博登录
};

/**
 支付类型
 */
typedef NS_ENUM(NSInteger, HCPayment) {
    HCPaymentNone = 0,
    HCPaymentBalance,           /// 余额支付
    HCPaymentWChat,             /// 微信
    HCPaymentAlipay,            /// 支付宝
    HCPaymentUnionpay,          /// 银联支付
    HCPaymentOrtherPerson,      /// 朋友代付
    HCPaymentGettheGift         /// 领取礼物
};

/**
 测试类型
 */
typedef NS_ENUM(NSInteger, HCTestType) {
    HCTestTypePhysique = 0,     /// 体质测试
    HCTestTypeSubHealth,        /// 亚健康测试
    HCTestTypeIntestinal,       /// 肠道测试
    HCTestTypeTits,             /// 乳房测试
};

typedef NS_ENUM(NSUInteger, HCCollectionVCType) {
    HCCollectionVCTypeGoods = 0,            /// 商品收藏
    HCCollectionVCTypeNews = 1,             /// 资讯收藏
    HCCollectionVCTypeFood = 2,             /// 食谱收藏
    HCCollectionVCTypeDiet = 3,             /// 药膳收藏
    HCCollectionVCTypeMFood = 4,             /// 美食收藏
};

#pragma mark - SQLiteKey
/** Version: 数据库版本 */
static NSString * const SQLiteVersion = @"1.1.1";
/** PasswordKey: 数据库密码 */
static NSString * const SqlitePasswordKey = @"Na^m*$liJ_in";

static NSString * const BaiduPushAppKey = @"demo/ssss";
//友盟 appkey
static NSString * const UmenAppkey = @"5a0944a6b27b0a06a20000a7";
//环信 appkey
static NSString * const EMAppkey = @"1142171102115964#jkzz";
static NSString * const EMApnskey = @"jkzzkaifa";

//JPush appkey
static NSString * const JPushAppkey = @"2e9dc01daaa505be27674e75";
static NSString * const JpushAppScrect = @"7685526f101c725b45373847";

//weixin appkey
static NSString * const WeiXAppkey = @"wxaef55d1fea669618";
static NSString * const WeiXAppScrect = @"7d22591487cfc7cec3a09abb162fad36";
//qq appkey
static NSString * const QQAppkey = @"1106534500";
static NSString * const QQAppScrect = @"L4KWrh64SWZb7Bl1";
//weibo appkey
static NSString * const WeiboAppKey = @"2187964282";
static NSString * const WeiboAppScrect = @"381a806b775f4ed81aedfee9bb221dcf";

#pragma mark - 全局变量
static CGFloat const kAMinute = 60.0f;
static CGFloat const kAnHour = 3600.0f;
static CGFloat const Margin = 8.0f;
static CGFloat const kNavigationTitleHeight = 64.0f;

#pragma mark - 
static NSString * const UserHeadPlaceHolderImageName = @"mine_head";

#pragma mark - 通知
/// Exp
static NSString * const NSNotificationNameExample = @"DealSeatResult";
/** 
 Condition: 登陆成功 
 Action: 刷新个人中心界面
 */
static NSString * const HCNotiMineVCDoRefreshTarget = @"HCNotiMineVCDoRefreshTarget";

#pragma mark - 评论
/** 文本行高 */
static CGFloat const CommentLineSpacing = 4.0;


#endif /* HCConstString_h */
