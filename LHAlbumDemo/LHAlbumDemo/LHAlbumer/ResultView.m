//
//  ResultView.m
//  kezhuo
//
//  Created by Feng Jingjun on 14-8-11.
//  Copyright (c) 2014年 kezhuo365. All rights reserved.
//

#import "ResultView.h"
#import "UIView+Frame.h"
#import "UIConstant.h"

@interface ResultView()

@property (nonatomic, strong)UIView *view;

@property (nonatomic, strong)UINavigationController *nav;

@end

@implementation ResultView

IMPLEMENT_SHARED_INSTANCE(ResultView);

void (^reloadButtonTapedCallback)(void);

- (void)showResult:(NSString *)des forType:(ResultType)type
{

    [self layoutResultViewWithDes:des forType:type hasKeyBoard:NO];
    [self showFrom:nil];
    if((type != kResultTypeSuccess) && [des isEqualToString: UI_STRING(@"networkUnreachable")]){
        [self showNetWorkErrorView];
        [self insertNetWorkErrorView];
    }
}



- (void)showResult:(NSString *)des forType:(ResultType)type viewController:(UIViewController *)viewController callback:(void (^)(void)) complete{
    [self layoutResultViewWithDes:des forType:type hasKeyBoard:NO];
    [self showFrom:viewController];
    if((type != kResultTypeSuccess) && [des isEqualToString: UI_STRING(@"networkUnreachable")]){
        [self showNetWorkErrorView];
        [self insertNetWorkErrorViewWithViewController:viewController];
    }
    reloadButtonTapedCallback = complete;
}

- (void)showResultWithKeyBoard:(NSString *)des forType:(ResultType)type{
    [self layoutResultViewWithDes:des forType:type hasKeyBoard:YES];
    [self showFrom:nil];
    if((type != kResultTypeSuccess) && [des isEqualToString: UI_STRING(@"networkUnreachable")]){
        [self showNetWorkErrorView];
        [self insertNetWorkErrorView];
    }
}

- (void)showNetWorkErrorView{

    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - UI_TAB_BAR_HEIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH-215*0.5+50)/2, UI_SCREEN_HEIGHT/5, 215*0.5, 171*0.5)];
    UIImage *image = [UIImage imageNamed:@"netWorkError"];
    imageView.image = image;
    [self.view addSubview:imageView];
    [self.view setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:236.0/255.0 blue:235.0/255.0 alpha:1]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, UI_SCREEN_HEIGHT/5 + 171*0.5 + 20, 210, 20)];
    label.numberOfLines = 0;
    [label setText:UI_STRING(@"networkUnreachable")];
    [label setTextColor:[UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label sizeToFit];
    [self.view addSubview:label];
    UIButton *reloadButton = [[UIButton alloc] initWithFrame:CGRectMake((UI_SCREEN_WIDTH-266*0.5)/2, 260, 266*0.5, 71*0.5)];
    [reloadButton setBackgroundImage:[UIImage imageNamed:@"greenBorder"] forState:UIControlStateNormal];
    [reloadButton setTitle:UI_STRING(@"reload") forState:UIControlStateNormal];

    [reloadButton setTitleColor:[UIColor colorWithRed:91.0/255.0 green:200.0/255.0 blue:75.0/255.0 alpha:1] forState:UIControlStateNormal];
    [reloadButton setTitleColor:[UIColor colorWithRed:26.0/255.0 green:116.0/255.0 blue:34.0/255.0 alpha:1] forState:UIControlStateHighlighted];
    [reloadButton addTarget:self action:@selector(reloadButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:reloadButton];
    

}

- (void)insertNetWorkErrorView{

//    RootTabBarViewController *rvc = (RootTabBarViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    int index = (int)rvc.selectedIndex;
//    self.nav = rvc.viewControllers[index];
//    if(rvc.selectedIndex == 0){
//        [self.nav.view addSubview:self.view];
//        for(UIViewController * controller in [self.nav viewControllers]){
//            
//            if([controller.view.subviews containsObject:self.view])
//                [self.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
//            
//            [controller.view addSubview:self.view];
//            break;
//        }
//    }

}

- (void)insertNetWorkErrorViewWithViewController:(UIViewController *)viewController{
    [viewController.view addSubview:self.view];
}

- (void)reloadButtonTaped:(UIButton *)sender{
    [self.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    if(reloadButtonTapedCallback)
        reloadButtonTapedCallback();
}

- (void)layoutResultViewWithDes:(NSString *)des forType:(ResultType)type hasKeyBoard:(BOOL)hasKeyBoard
{
    [self clearSubViews];
    [self.view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    self.frame = CGRectZero;
    
    UILabel *label = (UILabel *)[self viewWithTag:kTipsLabelTag];
    if (nil == label) {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    label.text = des;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.tag = kTipsLabelTag;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 224, 35)];
    bgView.layer.cornerRadius = kCornerRadius;
    if (type == kResultTypeSuccess) {
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    else if(type == kResultTypeTop){
        bgView.backgroundColor = UIColorFromRGBA(0xb7e27a, 0.95);
        bgView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 36);
    }
    else {
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    
    self.tag = kTipsViewTag;
//    [self addSubview:bgImageView];
    [self addSubview:bgView];
    [self addSubview:label];
    
    // 宽度固定 高度可变
    CGRect bgRect = bgView.frame;
    if (label.text.length == 0) {
        return;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName: label.font}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(bgRect.size.width - 20, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGSize size = rect.size;
    rect.origin = CGPointMake(10, 10);
    rect.size.width = bgRect.size.width - 20;
    label.frame = rect;
    label.tag = kTipsLabelTag;
    
    bgRect.size.height = size.height + 20;
    bgView.frame = bgRect;
    
    // 水平居中
    bgRect.origin.x = (UI_SCREEN_WIDTH - bgRect.size.width) / 2;
    // 垂直靠下 底边距为 UI_TIPS_BUTTOM_MARGIN
    if(hasKeyBoard){
        bgRect.origin.y = UI_SCREEN_HEIGHT/3;
    }
    else{
        bgRect.origin.y = UI_SCREEN_HEIGHT - bgRect.size.height - (UI_TAB_BAR_HEIGHT + 16);
    }
    if (type == kResultTypeTop) {
        bgRect.origin.y = 0;
        bgRect.size.width = UI_SCREEN_WIDTH;
        bgView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, kFeedMainSegmentHeight);
        bgView.layer.cornerRadius = 0;
    }
    
    self.frame = bgRect;
    
    self.backgroundColor = [UIColor clearColor];
}
- (void)showFrom:(UIViewController *)vc
{
    if (vc) {
        [vc.view addSubview:self];
        self.alpha = 0.0;
    }else{
        //动画：顶部渐变显示
        UIView *rootView = [[[UIApplication sharedApplication] delegate] window];
        UIView *curSuperView = self.superview;
        if (curSuperView != rootView) {
            [rootView addSubview:self];
            self.alpha = 0.0;
        }
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
    
    // 显示
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    self.alpha = 1.0;
    [UIView commitAnimations];
    
    [self hideAfterDelay:2];
}

- (void)hideAfterDelay:(CGFloat)delay
{
	[self performSelector:@selector(hide) withObject:nil afterDelay:delay];
}

- (void)hide
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finish){
        [self removeFromSuperview];
    }];
    [UIView commitAnimations];
    
}

- (void)clearSubViews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)hideNow{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finish){
        [self removeFromSuperview];
    }];
    [UIView commitAnimations];
}


@end
