//
//  HCHeader.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCHeader_h
#define HCHeader_h
                        /** Native Framework*/
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <float.h>
#import <HealthKit/HealthKit.h>
                        /** cocoapods */
#import <Masonry.h>                 /// Masonry
#import <UIImageView+WebCache.h>    /// SD
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import <MJExtension.h>             /// MJ
#import <UIView+Toast.h>            /// Toast
#import <AFNetworking.h>
#import <FMDB.h>                    /// FMDB
#import <MBProgressHUD.h>           /// HUD
#import <SVProgressHUD.h>
#import <ReactiveObjC.h>            /// RAC
//#import <RongIMKit/RongIMKit.h>     /// 融云
//#import <RongIMLib/RongIMLib.h>
//#import <RongCallKit/RongCallKit.h>
//#import <RongCallLib/RongCallLib.h>
#import <YYText.h>                  /// YYKit
#import <YYImage.h>
#import <YYModel.h>
#import "YTKNetwork.h"              /// NetWorking
#import <WHC_ModelSqlite.h>         /// SQLite Model
#import <IQKeyboardManager.h>       /// 键盘管理
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）




/**--------------------------- 友盟 ------------------------*/
#import <UShareUI/UShareUI.h>       /// share
#import <UMSocialCore/UMSocialCore.h>
#import <UMSocialNetwork/UMSocialNetwork.h>


/// Email
#import <UMSocialEmailHandler.h>
/// DingDing
//#import <UMSocialDingDingHandler.h>
/// QQ
#import <TencentOpenAPI/TencentOAuth.h>
/// ReducedQQ
#import <UMSocialQQHandler.h>
/// ReducedSina
#import <UMSocialSinaHandler.h>
/// ReducedWeChat
#import <UMSocialWechatHandler.h>
/// Sina
#import <WeiboSDK.h>
#import <WeiboSDK+Statistics.h> /// 微博埋点
/// SMS
#import <UMSocialSmsHandler.h>
/// WeChat
#import <WechatAuthSDK.h>
#import <WXApi.h>
#import <WXApiObject.h>

/**--------------------------- End ------------------------*/

                        /** gategory */
#import "NSObject+WHC_Model.h"
#import "NSString+HCString.h"
#import "UIColor+HQ8902.h"
#import "UIFont+MHExtension.h"
#import "UIDevice+HCGategory.h"
#import "UIImage+HCGategory.h"
#import "UIView+HCGategory.h"
#import "UIView+HCDisplay.h"
#import "UITextField+HCGategory.h"
#import "UIView+HCEqualMargin.h"
#import "UIButton+HCGategory.h"
#import "UIButton+Extension.h"

#import "NSObject+HCNotification.h"
#import "UIViewController+HCCategory.h"
#import "UIImageView+HRCornerRadius.h"
#import "NSURL+HCCategory.h"

/** 网络加载菊花分类 */
#import "YTKBaseRequest+AnimatingAccessory.h"

                        /** Tools */
/** 用户管理 */
#import "HCAccountTool.h"
/** 文件管理 */
#import "HCFileTool.h"
/** 相册/相机管理 */
#import "HCPhotoPickerTool.h"
/** 网络参数管理 */
#import "HCUrlArgumentsFilter.h"
/** 刷新工具 */
#import "HCRefreshTool.h"
/** 用户信息管理(DB) */
#import "HCDataBaseModel.h"
#import "HCDataBaseManager.h"
/** NSUserDefaultManager */
#import "HCUserDefaultManager.h"
/** BASE Class */
#import "HCBaseNavigationController.h"
#import "HCBaseViewController.h"
/** 省市区选择器 */
#import "AddressPickerView.h"
#import "HUD.h"
#import "HCAccountModel.h"
                        /** 加密 */
#import "HJMd5.h"
#import "Base64.h"
#import "CocoaSecurity.h"
#import <sqlite3.h>             /// SQLite加密

/** 通用视图 */
#import "HCOprationButton.h"

/** 迭代弃用 */
//#import "TitleView.h"
#import "HealthHjManger.h"
#endif /* HCHeader_h */
