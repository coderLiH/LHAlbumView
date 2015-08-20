//
//  JTAImagesAlbumView.m
//  gift
//
//  Created by 李允 on 15/6/8.
//  Copyright (c) 2015年 ZhuLuTianXia. All rights reserved.
//

#import "JTAImagesAlbumView.h"
#import "JTAZoomingContentView.h"
#import "UIConstant.h"
#import "UIView+Frame.h"

#import "UIImageView+WebCache.h"

@interface JTAImagesAlbumView ()

@property (nonatomic, strong) UILabel *indexLabel;
@end

@implementation JTAImagesAlbumView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _rootScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _rootScrollView.delegate = self;
        [self addSubview:_rootScrollView];
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 30, UI_SCREEN_WIDTH, 30)];
        [self addSubview:_indexLabel];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont systemFontOfSize:15];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    for (NSInteger i = 0; i < images.count; i++) {
        JTAZoomingContentView *contentView = [[JTAZoomingContentView alloc] initWithFrame:CGRectMake(i * UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        contentView.rootView = self;
        [self.rootScrollView addSubview:contentView];
        [contentView.imageView sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:[UIImage imageNamed:@"defaultImageView"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                contentView.imageView.height = image.size.height / (image.size.width/UI_SCREEN_WIDTH);
                contentView.imageView.y = (UI_SCREEN_HEIGHT - contentView.imageView.height)/2;
                contentView.contentSize = contentView.imageView.size;
            }
        }];
    }
    self.rootScrollView.contentSize = CGSizeMake(images.count * UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    self.rootScrollView.pagingEnabled = YES;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    self.indexLabel.text = [NSString stringWithFormat:@"%tu/%tu", _currentIndex+1,self.images.count];
    
    self.rootScrollView.contentOffset = CGPointMake(currentIndex * UI_SCREEN_WIDTH, 0);
}

#pragma mark UISCrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //1.获取当前的页数
    int currentPage = scrollView.contentOffset.x/UI_SCREEN_WIDTH;
    //2.还原以前的缩放试图
    if (currentPage != self.currentIndex) {
        //取得视图
        NSInteger index = self.currentIndex;
        [self.rootScrollView.subviews[index] setZoomScale:1];
    }
    self.currentIndex = currentPage;
    self.indexLabel.text = [NSString stringWithFormat:@"%tu/%tu", self.currentIndex+1,self.images.count];
}

#pragma mark private action 

- (void)dismiss {
    for (NSInteger i = 0; i < self.rootScrollView.subviews.count; i++) {
        JTAZoomingContentView *view = self.rootScrollView.subviews[i];
        [view setZoomScale:1];
    }
    [self removeFromSuperview];
}

@end
