//
//  UIConstant.h
//  kezhuo
//
//  Created by Feng Jingjun on 14-7-9.
//  Copyright (c) 2014年 kezhuo365. All rights reserved.
//

#define Device_iphone5              ([[UIScreen mainScreen] bounds].size.height == 568)
#define Device_iphone6              ([[UIScreen mainScreen] bounds].size.height == 667)
#define Device_iphone6p             ([[UIScreen mainScreen] bounds].size.height == 736)
#define UI_MARGIN                   10
#define UI_CUSTOMVIEW_HEIGHT        0.1
#define UI_NAVIGATION_BAR_HEIGHT    44
#define UI_NAVIGATION_STATUS_HEIGHT 64
#define UI_TOOLBAR_HEIGHT           44
#define UI_TAB_BAR_HEIGHT           49
#define UI_STATUS_BAR_HEIGHT        20
#define UI_SCREEN_WIDTH             ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT            ([[UIScreen mainScreen] bounds].size.height)
#define UI_VISIBLE_HEIGHT           UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT - UI_NAVIGATION_BAR_HEIGHT - UI_TAB_BAR_HEIGHT
#define UI_VISIBLE_HEIGHT_NO_TAB    UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT - UI_NAVIGATION_BAR_HEIGHT
#define UI_IPHONE4                  960
#define UI_IPHONE5                  1136
#define UI_KEYBOARD_HEIGHT          200
#define UI_EMOTION_HEIGHT           216
#define UI_PUBLISHBAR_HEIGHT        43
#define TAGSTRING                   @" "
#define kUIElementLeftMargin        15
#define newUIElementLeftMargin      5
#define kUIElementTopMargin         15
#define kUIBarLikeElementHeight     44
#define kUIButtonWidth              34
#define kUIMARGIN                   28
#define kUIBarLeftMargin            19

//触发上拉加载的高度
#define kFeedTrigFetchingHeight     10

#define kDragRefreshHeight          96


//默认发布feed背景色
#define kDefaultFeedBgColor         -65794

//发布feed图片固定宽度及长宽比
#define kDefaultFeedImageWidth      720
#define kDefaultFeedImageHeight     1280
#define kWidthAndHeightRatio        0.75

#define kPublisherPhotoSize         30

#define kButtonHeight               39
#define kLabelHeight                39

//圆角半径[layer setCornerRadius]使用
#define kCornerRadius               5


#define kShouldFetchOffsetHeight                -44
#define kMinFeedCellHeight                      64
#define kFeedTextFont                           16.0f
#define kFeedTableFooterViewHeight              44
#define kCollegeFunctionViewHeight              44
#define kTopOffSet                              44
#define kFeedTableY                             -44
#define kFeedMainSegmentHeight                  40


#define UIColorFromRGB(rgbValue) \
                [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
                green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 \
                blue:((float)((rgbValue) & 0xFF))/255.0 \
                alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
                [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
                green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 \
                blue:((float)((rgbValue) & 0xFF))/255.0 \
                alpha:(alphaValue)]

#define RGBColor(Red,Green,Blue)  [UIColor colorWithRed:(Red/255.0) green:(Green/255.0) blue:(Blue/255.0) alpha:1.0f]

#define UI_TITLE_TYPE1_NORMAL_COLOR     [UIColor whiteColor]
#define UI_TITLE_TYPE1_DISABLED_COLOR   [UIColor colorWithRed:160.f/255.f green:160.f/255.f blue:160.f/255.f alpha:1.0f]
#define UI_TITLE_TYPE1_SHADOW_COLOR     [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f]
#define UI_TITLE_TYPE4_NORMAL_COLOR     [UIColor colorWithRed:45.f/255.f green:110.f/255.f blue:136.f/255.f alpha:1.0f]
#define UI_TITLE_TYPE4_DISABLED_COLOR   [UIColor colorWithRed:160.f/255.f green:160.f/255.f blue:160.f/255.f alpha:1.0f]
#define UI_TITLE_TYPE4_SHADOW_COLOR     [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.3f]

#define UI_COLOR_VIEWCONTROLLERS_BG     [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define UI_COLOR_BAR_TINT_COLOR         [UIColor colorWithRed:87.0/255.0 green:190.0/255.0 blue:61.0/255.0 alpha:1]


