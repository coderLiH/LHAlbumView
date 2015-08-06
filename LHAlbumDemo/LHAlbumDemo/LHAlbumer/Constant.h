//
//  Constant.h
//  kezhuo
//
//  Created by Feng Jingjun on 14-7-9.
//  Copyright (c) 2014年 kezhuo365. All rights reserved.
//

#define DECLARE_SHARED_INSTANCE(className)  \
+ (className *)sharedInstance;

#define IMPLEMENT_SHARED_INSTANCE(className)  \
+ (className *)sharedInstance \
{ \
static dispatch_once_t onceToken; \
static className *sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[self alloc] init]; \
}); \
return sharedInstance; \
}

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#ifdef DEBUG
#define debugLog(format, ...) NSLog(format, ##__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)          // Nothing
#define debugMethod()
#endif

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define UI_STRING(key)          NSLocalizedString(key, nil)

#define JTAImageSrcName(file) [@"UMSocialSDKResourcesNew.bundle/SnsPlatform" stringByAppendingPathComponent:file]

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ApplicationSettings

#define kShareBaseURL               @"http://www.giftsfeeling.com/v?"
#define kHostURL                    @"hostURL"
#define kIsPreview                  @"isPreview"
#define kAccountToken               @"accountToken"
#define kCurrentUserName            @"currentUserName"
#define kLastLoginUserName          @"lastLoginUserName"
#define kUserPassword               @"us3rP@ssword"
#define kUserInfo                   @"userInfo"
#define kShallReceivePushMsgs       @"shallReceivePushMsgs"
#define kShouldRegisterApns         @"shouldRegisterApns"
#define kSearchHistories            @"searchHistories"
#define kLastSelectFeedFlowIndex    @"lastSelectFeedFlowIndex"
#define kLogin                      @"login"
#define kNeedReLogin                @"needReLogin"
#define kUserVerifiedStatus         @"userVerifiedStatus"
#define kUserCanModify              @"canModify"
#define kUserCM                     @"userCM"

// 网络请求自动重试次数
#define kNetworkRetry               2


///////////////////////////////////////////////////////////////////////////////////////////////////

// YTKRequest 自定义
#define kResponseKeywordCode           @"code"
#define kResponseKeywordMsg            @"msg"
#define kResponseKeywordData           @"data"
// 数据库存储用户头像 取巧
#define kLihaoKeyUserAvatar            @"kLihaoKeyUserAvatar"
typedef NS_ENUM(NSUInteger, JTAOrderStateType) {
    JTAOrderStateTypeWaitPay,      // 待付款
    JTAOrderStateTypeCancel,       // 订单已取消
    JTAOrderStateTypeWillDeliver,  // 待配送
    JTAOrderStateTypeDeliviering,  // 配送中
    JTAOrderStateTypeArrival,      // 已送到
    JTAOrderStateTypeWillDead,     // 即将到期
    JTAOrderStateTypeOnPickUp,     // 已出发取货
    JTAOrderStateTypeRecycled,     // 玩具已收回
    JTAOrderStateTypeOrderReleted, // 玩具已续租
    JTAOrderStateTypeWillReletting,// 玩具即将续租
    JTAOrderStateTypeReletting,    // 续租中
    JTAOrderStateTypeRefunding,    // 押金退还中
    JTAOrderStateTypeRefunded,     // 押金已退还
    JTAOrderStateTypeCompeleted    // 已完成
};

typedef NS_ENUM(NSUInteger, JTATimeCellType) {
    JTATimeCellTypeSubmitChoice,      // 订单提交
    JTATimeCellTypeSubmitUnchoice,    // 订单提交
    JTATimeCellTypeDetailOnly,        // 订单详情
    JTATimeCellTypeDetailRelet,       // 订单详情
    JTATimeCellTypeDetailRecycle      // 订单详情
};

typedef NS_ENUM(NSUInteger, JTAMiddleInfoViewType) {
    JTAMiddleInfoViewTypeSubmit,  // 订单提交
    JTAMiddleInfoViewTypeOrder    // 订单详情
};

typedef NS_ENUM(NSUInteger, JTARentUnitType) {
    JTARentUnitTypeWeek,  // 周
    JTARentUnitTypeMonth, // 月
    JTARentUnitTypeYear   // 年
};
typedef NS_ENUM(NSUInteger, JTACreateAddressControllerType) {
    JTACreateAddressControllerTypeCreate,  // 创建
    JTACreateAddressControllerTypeEdit     // 编辑
};
typedef enum SexType {
    kSexTypeMan,
    kSexTypeWoman
}SexType;


typedef NS_ENUM(NSUInteger, JTAOrderSubmitType) {
    JTAOrderSubmitOnly,  // 单独的订单提交
    JTAOrderSubmitRelet, // 续租的订单提交
    JTAOrderToPay,       // 从订单详情进入支付页面(普通订单)
    JTAOrderReletToPay,  // 从订单详情进入支付页面(续租订单)
    JTAOrderDetail       // 进入订单详情页
};

typedef NS_ENUM(NSUInteger, JTATimeSourceType) {
    JTATimeSourceDeliverTime, // 送货时间
    JTATimeSourceTakeTime     // 取货时间
};

typedef NS_ENUM(NSUInteger, JTALPType) {// 落地页
    JTALPTypeMainPage,    // 首页
    JTALPTypeSuitDetail,  // 套餐详情
    JTALPTypeToyDetail,   // 玩具详情
    JTALPTypeOrderList,   // 订单列表
    JTALPTypeOrderDetail, // 订单详情
    JTALPTypeMsgCenter,   // 消息中心
    JTALPTypeWebPage      // 推广web页
};

typedef enum ResponseContentType
{
    kResponseContentTypeCode,
    kResponseContentTypeMsg,
    kResponseContentTypeData
}ResponseContentType;

typedef enum ResponseStatus
{
    kResponseNetworkError = -1,                     //网络超时
    kResponseStatusSuccess = 0,                     //成功
    kResponseStatusFeedReportSuccess = 0,           //感谢您的贡献，我们会尽快对这条刻卓进行审核
    kResponseStatusCommentReportSuccess = 0,        //感谢您的贡献，我们会尽快对这条评论进行审核
    kResponseUserExist = 101,                       //用户已存在
    kResponsePasswordError = 102,                   //密码错误
    kResponseCheckCodeError = 103,                  //校验码错误
    kResponseCookieError = 104,                     //cookie验证失败
    kResponseUserNotLogin = 105,                    //用户未登录
    kResponsePermissionDenied = 106,                //权限不足
    kResponseUsernameFormatError = 107,             //用户名格式不对
    kResponseUserBlockFeed = 108,                   //您正在被审核身份，从小黑屋出来之后才能剥洋葱噢
    kResponseUserBlockComment = 108,                //您正在被菜农审核身份，暂时不能对洋葱进行评论
    kResponseUserBlockOperation = 108,              //您正在被菜农审核身份，暂时不能对洋葱进行操作
    kResponseUserNotExit = 109,                     //用户不存在
    kResponseInvalidInput = 201,                    //无效的输入，请检查输入参数
    kResponseFrequentOperation = 202,               //操作过于频繁
    kResponsePassAudit = 203,                       //已通过审核
    kResponseWaitForAudit = 204,                    //等待审核，暂不允许扩散
    kResponseFollowReachLimit = 207,                //关注达到上限
    kResponseDBError = 301,                         //数据存储错误
    kResponseServerError = 401,                     //服务端错误
    kResponseUnknownError = 402,                    //未知错误
    kResponseImageServerError = -1111,              //图片服务器错误
}ResponseStatus;

// 获取版本号CFBundleShortVersionString
#define APP_BUILD_VERSION   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 支付相关的宏定义

#define QQ_URL                  @"mqq://"
#define WECHAT_URL              @"weixin://"
#define WEIBO_URL               @"weibo://"

#define tempURL  @"http://192.168.199.240:8080"


#pragma mark XCodeColors
// 配置log 颜色
#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

#if 0
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
#endif

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#ifdef DEBUG
#define debugBlue(format, ...) NSLog((XCODE_COLORS_ESCAPE @"fg24,116,205;" format XCODE_COLORS_RESET), ##__VA_ARGS__) //强调
#define debugGreen(format, ...) NSLog((XCODE_COLORS_ESCAPE @"fg84,139,84;" format XCODE_COLORS_RESET), ##__VA_ARGS__) //成功
#define debugRed(format, ...) NSLog((XCODE_COLORS_ESCAPE @"fg205,92,92;" format XCODE_COLORS_RESET), ##__VA_ARGS__)   //失败
#else
#define debugBlue(...)
#define debugGreen(...)
#define debugRed(...)
#endif

