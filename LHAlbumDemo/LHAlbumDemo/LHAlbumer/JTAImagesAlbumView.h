//
//  JTAImagesAlbumView.h
//  gift
//
//  Created by 李允 on 15/6/8.
//  Copyright (c) 2015年 ZhuLuTianXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTAImagesAlbumView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *rootScrollView;
/** 必须保证先设置了图后设置入口index */
@property (nonatomic, strong) NSArray   *images;
/** 必须保证先设置了图后设置入口index */
@property (nonatomic, assign) NSInteger currentIndex;
- (void)dismiss;
@end
