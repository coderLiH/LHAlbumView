//
//  JTAZoomingContentView.h
//  gift
//
//  Created by 李允 on 15/6/9.
//  Copyright (c) 2015年 ZhuLuTianXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JTAImagesAlbumView;
@interface JTAZoomingContentView : UIScrollView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) JTAImagesAlbumView *rootView;
@end
