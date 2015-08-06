//
//  ResultView.h
//  kezhuo
//
//  Created by Feng Jingjun on 14-8-11.
//  Copyright (c) 2014年 kezhuo365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#define kTipsViewTag        1900
#define kTipsImageViewTag   1901
#define kTipsLabelTag       1902

typedef enum ResultType
{
    kResultTypeSuccess,
    kResultTypeFailed,
    kResultTypeNotif,
    kResultTypeTop
}ResultType;

@interface ResultView : UIView

DECLARE_SHARED_INSTANCE(ResultView);

- (void)showResult:(NSString *)des forType:(ResultType)type;

- (void)showResult:(NSString *)des forType:(ResultType)type viewController:(UIViewController *)viewController callback:(void (^)(void)) complete;

- (void)showResultWithKeyBoard:(NSString *)des forType:(ResultType)type;

- (void)hideNow;

@end
