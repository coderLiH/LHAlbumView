//
//  JTAZoomingContentView.m
//  gift
//
//  Created by 李允 on 15/6/9.
//  Copyright (c) 2015年 ZhuLuTianXia. All rights reserved.
//

#import "JTAZoomingContentView.h"
#import "JTAImagesAlbumView.h"
#import "UIConstant.h"
#import "UIView+Frame.h"
#import "ResultView.h"

@class JTAComboDetailViewController;
@class JTAToyDetailViewController;

@interface JTAZoomingContentView ()<UIScrollViewDelegate, UIActionSheetDelegate>

@end
@implementation JTAZoomingContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 2.;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (UI_SCREEN_HEIGHT - UI_SCREEN_WIDTH/1.42)/2 , UI_SCREEN_WIDTH, UI_SCREEN_WIDTH/1.42)];
        [self addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(save:)];
        [_imageView addGestureRecognizer:longP];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [tap requireGestureRecognizerToFail:doubleTap];// 要求不是双击才执行单击
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void)dismiss {
    [self.rootView dismiss];
}
static  int currentScale = 1;
#define MaxScale     4
#define MinScale     1

- (void)doubleTap:(UITapGestureRecognizer *)doubleTap {
//    if (self.zoomScale == 1.) {
//        [self setZoomScale:2. animated:YES];
//    } else {
//        [self setZoomScale:1. animated:YES];
//    }
    //当前倍数等于最大放大倍数
    //双击默认为缩小到原图
    if (currentScale == MaxScale) {
        currentScale = MinScale;
        [self setZoomScale:currentScale animated:YES];
        return;
    }
    //当前等于最小放大倍数
    //双击默认为放大到最大倍数
    if (currentScale == MinScale) {
        currentScale = MaxScale;
        [self setZoomScale:currentScale animated:YES];
        return;
    }
    
    CGFloat aveScale = MinScale + (MaxScale - MinScale) / 2.0;//中间倍数
    
    //当前倍数大于平均倍数
    //双击默认为放大最大倍数
    if (currentScale >= aveScale) {
        currentScale = MaxScale;
        [self setZoomScale:currentScale animated:YES];
        return;
    }
    
    //当前倍数小于平均倍数
    //双击默认为放大到最小倍数
    if (currentScale < aveScale) {
        currentScale = MinScale;
        [self setZoomScale:currentScale animated:YES];
        return;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.subviews.firstObject;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.pinchGestureRecognizer.scale > 1.) {
        CGFloat xcenter = self.width/2,ycenter = self.height/2;
        xcenter = self.contentSize.width > self.frame.size.width?self.contentSize.width/2 :xcenter;
        ycenter = self.contentSize.height > self.frame.size.height ?self.contentSize.height/2 : ycenter;
        self.imageView.center = CGPointMake(xcenter, ycenter);
        self.contentSize = self.imageView.size;
    } else {
        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
        (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
        (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
    }
}

- (void)save:(UILongPressGestureRecognizer *)longP {
    if (self.imageView.image && longP.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"保存到相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存" otherButtonTitles: nil];
        [sheet showInView:self];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo {
    if (!error) {
        [[ResultView sharedInstance] showResult:@"保存成功" forType:kResultTypeSuccess];
    } else {
        [[ResultView sharedInstance] showResult:@"保存失败" forType:kResultTypeFailed];
    }
}

- (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated {
    [super setZoomScale:scale animated:animated];
    
    CGFloat xcenter = self.width/2,ycenter = self.height/2;
    xcenter = self.contentSize.width > self.frame.size.width?self.contentSize.width/2 :xcenter;
    ycenter = self.contentSize.height > self.frame.size.height ?self.contentSize.height/2 : ycenter;
    self.imageView.center = CGPointMake(xcenter, ycenter);
    self.contentSize = CGSizeMake(self.imageView.width, self.imageView.height);
    
}

@end
