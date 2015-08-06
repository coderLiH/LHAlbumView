//
//  ViewController.m
//  LHAlbumDemo
//
//  Created by 李允 on 15/8/6.
//  Copyright (c) 2015年 liyun. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "UIConstant.h"
#import "UIView+AutoLayout.h"
#import "UIImageView+WebCache.h"
#import "JTAImagesAlbumView.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UICollectionView *imagesView;
@property (nonatomic, weak) JTAImagesAlbumView *imagesAlbum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imagesView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell addSubview:imageView];
    
    [imageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:cell];
    [imageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:cell];
    [imageView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:cell];
    [imageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:cell];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.images[indexPath.row]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.imagesAlbum.currentIndex = indexPath.row;
    self.imagesAlbum.rootScrollView.contentOffset = CGPointMake(indexPath.row * UI_SCREEN_WIDTH, 0);
}

- (JTAImagesAlbumView *)imagesAlbum {
    if (!_imagesAlbum) {
        JTAImagesAlbumView *view = [[JTAImagesAlbumView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        _imagesAlbum = view;
        [self.view addSubview:_imagesAlbum];
        _imagesAlbum.images = self.images;
    }
    return _imagesAlbum;
}

- (UICollectionView *)imagesView {
    if (!_imagesView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((UI_SCREEN_WIDTH-2*UI_MARGIN)/3, (UI_SCREEN_WIDTH-2*UI_MARGIN)/3);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        _imagesView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT) collectionViewLayout:layout];
        _imagesView.dataSource = self;
        _imagesView.delegate = self;
        [_imagesView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_imagesView];
    }
    return _imagesView;
}
- (NSArray *)images {
    if (!_images) {
        _images = @[@"http://ia.topit.me/a/f9/0a/1101078939e960af9al.jpg",@"http://img0.pconline.com.cn/pconline/1305/06/3284531_43_165537_8.jpg",@"http://images.yoka.com/pic/beauty/starface/2011/U199P1T117D236928F2577DT20110110120933.jpg",@"http://img2.iqilu.com/ed/10/07/15/27/135_100715112106_1.jpg",@"http://images.yoka.com/pic/beauty/starface/2011/U199P1T117D236913F2577DT20110110120633.jpg"];
    }
    return _images;
}

@end
