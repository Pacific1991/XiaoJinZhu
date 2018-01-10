//
//  HCServerInterface.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCServerInterface_h
#define HCServerInterface_h

//static NSString * const HCHostURL = @"http://jk.sybgt.cn";
//static NSString * const HCHostURL = @"http://118.31.21.196";
//static NSString * const HCHostURL = @"http://192.168.1.200";
static NSString * const HCHostURL = @"http://www.jiankangzhuzhang.com";
//static NSString * const HCHostURL = @"http://192.168.1.200:8080";


static NSString * const HCUploadImageURL = @"/Home/Api/uploadFile";
#pragma mark - 登录注册
/** 用户注册 */
static NSString * const HCUserRegisterURL = @"/Home/Api/register";
/** 用户获取验证码 */
static NSString * const HCUsergGetIdentifyingCodeURL = @"/Home/Api/getIdentifyingCode";
/** 忘记密码 */
static NSString * const HCModifyPassURL = @"/Home/Api/modifyPass";
/** 用户登录 */
static NSString * const HCUserLoginURL = @"/Home/Api/userLogin";
/** 用户绑定手机号 */
static NSString * const HCUserBindingMobileURL = @"/Home/Api/bindingMobile";
/** 三方登录 */
static NSString * const HCUserThirdLoginURL = @"/Home/Api/ThirdLogin";
#pragma mark - 首页
/** 首页banner */
static NSString * const HCHomeBannerURL = @"/Home/Api/getBannerBmp";
/** 首页商品详情 */
static NSString * const HCHomeGoodsListURL = @"/Home/Api/getCommodityInfo";
/** 首页测试列表 */
static NSString * const HCHomeTextListURL = @"/Home/Api/testList";
/** 首页推荐文章列表 */
static NSString * const HCHomeArticlesListURL = @"/Home/Api/getArticles";
/** 首页推荐食材 */
static NSString * const HCHomeRecommendFoodURL = @"/Home/Api/Recommend";
/** 首页搜索 */
static NSString * const HCHomeSearchListURL = @"/Home/Api/getSearch";
/** 首页文章头条类型 */
static NSString * const HCHomeArticleTypeURL = @"/Home/Api/articleType";
/** 首页文章头条列表 */
static NSString * const HCHomeArticleListURL = @"/Home/Api/articleList";
/** 首页文章详情 */
static NSString * const HCHomeArticleDetailURL = @"/Home/Api/article";
/** 首页上传步数 */
static NSString * const HCHomeUploadSportsHealthURL = @"/Home/Api/sportsHealth";
/** 首页运动详情 */
static NSString * const HCHomeSportsHealthInfoURL = @"/Home/Api/healthInfo";
/** 首页运动点赞 */
static NSString * const HCHomeSportslikeTapURL = @"/Home/Api/praised";
/** 首页运动取消点赞 */
static NSString * const HCHomeSportscanclelikeTapURL = @"/Home/Api/cancel";
/** 默认地址 */
static NSString * const HCHomeefaultAddressURL = @"/Home/Pay/address";
/** 推送ID */
static NSString * const HCHomeRegistrationIdURL = @"/Home/Jpushs/RegistrationId";

#pragma mark - 生活
/** 生活 */
static NSString * const HCHomeLifeListURL = @"/Home/Api/getClassification";
/** 生活列表 */
static NSString * const HCHomeContentListListURL = @"/Home/Api/getContentList";
/** 生活列表(新) */
static NSString * const HCHomeNewLifeTypeListURL = @"/Home/Api/lifeType";

/** 生活食材列表 */
static NSString * const HCHomeContentLifeFoodListURL = @"/Home/Api/getContentList_a";
/** 生活详情 */
static NSString * const HCHomelifeDetailsInfoURL = @"/Home/Api/lifeDetailsInfo";
/** 生活详情收藏 */
static NSString * const HCHomelifeDetailCollectURL = @"/Home/Api/detailsCollection";

#pragma mark - 优选

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
static NSString * const HCJoinShoppingCartURL = @"/Home/Api/joinCar";
/** 修改购物车商品数量 */
static NSString * const HCarNumSaveOrderURL = @"/Home/Api/carNumSave";
/** 删除购物车商品 */
static NSString * const HCDelShoppingCartURL = @"/Home/Api/cartDel";

/** 添加收货地址 */
static NSString * const HCInsAddressURL = @"/Home/Api/insAddress";
/** 删除收货地址 */
static NSString * const HCDelAddressURL = @"/Home/Api/delAddress";
/** 设置默认收货地址 */
static NSString * const HCUpdStatusURL = @"/Home/Api/updStatus";
/** 编辑收货地址 */
static NSString * const HCUpdAddressURL = @"/Home/Api/updAddress";
/** 收货地址管理 */
static NSString * const HCGetAddressListURL = @"/Home/Api/getAddress";
/** 提交订单 */
//static NSString * const HCOrderSubmissionURL = @"/Home/Api/orderSubmission";
static NSString * const HCOrderSubmissionURL = @"/Home/Pay/getPayorder";
/** 确认订单 */
static NSString * const HCConfirmOrderURL = @"/Home/Api/confirmOrder";


/** 删除订单 */
static NSString * const HCDelOrderURL = @"/Home/Api/delOrder";
/** 支付 */
static NSString * const HCGetPrePayOrderURL = @"/Home/Pay/getPayorder";
#pragma mark - 调养

/** 调养列表 */
static NSString * const HCNursedTypeListURL = @"/Home/Api/nursedType";
/** 调养详情 */
static NSString * const HCNursedContentURL = @"/Home/Api/nursedContent";

#pragma mark - 个人中心
/** 个人中心首页 */
static NSString * const HCPersonCenterURL = @"/Home/Api/Personal";
/** 获取个人信息 */
static NSString * const HCGetPersonalInfoURL = @"/Home/Api/getPersonalInfo";
/** 编辑个人信息 */
static NSString * const HCEditPersonalInfoURL = @"/Home/Api/editPersonal";
/** 获取家人列表 */
static NSString * const HCGetFamilyListURL = @"/Home/Api/getFamily";
/** 我的钱包 */
static NSString * const HCMyWalletURL = @"/Home/Api/wallet";
/** 添加家人 */
static NSString * const HCAddFamilyURL = @"/Home/Api/addFamily";
/** 编辑家人 */
static NSString * const HCSaveFamilyURL = @"/Home/Api/saveFamily";
/** 意见反馈 */
static NSString * const HCFeedBackURL = @"/Home/Api/feedback";
/** 申请商家信息提交 */
static NSString * const HCSupplierURL= @"/Home/Api/supplier";
/** 申请商家信息是否提交申请 */
static NSString * const HCBusinessApplyURL= @"/Home/Api/business";

/** 充值 */
static NSString * const HCRechargeURL = @"/Home/Pay/pay";
/** 获取优惠券 */
static NSString * const HCGetCouponsURL = @"/Home/Api/getCoupons";
/** 提现 */
static NSString * const HCWithdrawalsURL = @"/Home/Api/withdrawals";
/** 提现查询 */
static NSString * const HCProfitURL = @"/Home/Api/profit";


/** 添加银行卡 */
static NSString * const HCAddBankcardURL = @"/Home/Api/addBankcard";
/** 删除银行卡 */
static NSString * const HCDelBankcardURL = @"/Home/Api/delBankcard";
/** 收支明细 */
static NSString * const HCFlowingWaterURL = @"/Home/Api/flowingWater";
/** 商家经营类目 */
static NSString * const HCBusinessCategoryURL = @"/Home/Api/BusinessCategory";

/** 我的订单 */
static NSString * const HCGetOrderListURL = @"/Home/Api/getOrder";
/** 订单详情 */
static NSString * const HCGetOrderInfoURL = @"/Home/Api/order";

/** 我的收藏 */
static NSString * const HCGetFavoritesURL = @"/Home/Api/getFavorites";
/** 取消收藏 */
static NSString * const HCRemoveCollectionURL = @"/Home/Api/removeCollection";

/** 添加收藏 */
static NSString * const HCAddCollectionURL = @"/Home/Api/addCollection";
/** 商品评论 */
static NSString * const HCGoodGetCommentURL = @"/Home/Api/getComment";
/** 添加评论 */
static NSString * const HCInsCommentURL = @"/Home/Api/insComment";
/** 查看评论 */
static NSString * const HCOrderCommentURL = @"/Home/Api/orderComment";
/** 查看是否评论 */
static NSString * const HCOrderGoodsURL = @"/Home/Api/orderGoods";
/** 改变订单评论状态 */
static NSString * const HCCommentStaURL = @"/Home/Api/commentSta";

/** 删除商品评论 */
static NSString * const HCDelCommentURL = @"/Home/Api/delComment";
/** 测试分类 */
static NSString * const HCMineTestTypeURL = @"/Home/Api/testType";
/** 体质测试分类 */
static NSString * const HCBodyTestTypeURL = @"/Home/Test/conList";
/** 测试详情 */
static NSString * const HCMineTestInfoURL = @"/Home/Api/testInfo";
/** 体质测试详情 */
static NSString * const HCBodyTestInfoURL = @"/Home/Test/constitution";
/** 我的体质 */
static NSString * const HCBodyTestconResultInfoURL = @"/Home/Test/conResult";
/** 专家团队 */
static NSString * const HCMineGetExpertTeamURL = @"/Home/Api/getExpertTeam";
/** 账号继承 */
static NSString * const HCMineNumberInheritURL = @"/Home/Api/numberInherit";

/** 邀请好友 */
static NSString * const HCMineInvitingURL = @"/Home/Api/Inviting";
/** 我的继承 */
static NSString * const HCMineInvitinginheritURL = @"/Home/Api/inherit";

/** 家人测试 */
static NSString * const HCMineTestFamilyURL = @"/Home/Test/testFamily";
/** 线下体验 */
static NSString * const HCMinelineListURL = @"/Home/Api/lineList";
/** 测试分享链接 */
static NSString * const HCShareUrlURL = @"/Home/Test/shareUrl";
/** 线下体验详情 */
static NSString * const HCMinelineInfoURL = @"/Home/Api/line";
/** 确认收货 */
static NSString * const HCMineOrderisShipURL = @"/Home/Pay/isShip";
/** 查看物流 */
static NSString * const HCMinegetOrderTracesByJsonURL = @"/Home/Kdn/getOrderTracesByJson";
/** 通知列表 */
static NSString * const HCHomeMineJpushsListURL = @"/Home/Jpushs/jpushs";


#endif /* HCServerInterface_h */
