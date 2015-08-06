# LHAlbumView
sampleAlbum

This is a sample album to let user check their images

Usage:
_imagesAlbum.images = self.images;
self.imagesAlbum.currentIndex = indexPath.row;
self.imagesAlbum.rootScrollView.contentOffset = CGPointMake(indexPath.row * UI_SCREEN_WIDTH, 0);

Note:
be sure if you'r using lazy load.make the property type weak.
