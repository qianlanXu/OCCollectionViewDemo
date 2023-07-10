//
//  PictureLayout.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/22.
//

#import "PictureLayout.h"

@implementation PictureLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        // 指的是同一个section 内部 item 的滚动方向的间距
        self.minimumLineSpacing = 30;
        // 表示 同一个section内部间item的 和滚动方向垂直方向的间距
        // 默认在当前列不能排下下一个 Item 的时候自动换列
        // 设置的很大就可以
        self.minimumInteritemSpacing = 2000;
        self.itemSize = CGSizeMake(180, 180);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //每一组头视图的尺寸。如果是垂直方向滑动，则只有高起作用；如果是水平方向滑动，则只有宽起作用
        self.headerReferenceSize = CGSizeMake(30, 30);
    }
    return self;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newArray = [NSMutableArray array];
    // 屏幕中心点在collectionView画布的偏移位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attribute in array) {
        UICollectionViewLayoutAttributes *newAttribute = [attribute copy];
        if (newAttribute.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            [newArray addObject:newAttribute];
            continue;
        }
        
        // item离中心点的偏移位置
        // 中心点的item放大1.5倍，其他依次减少
        CGFloat scale = 1.5 - fabs(centerX - newAttribute.center.x) / self.collectionView.frame.size.width;
        newAttribute.transform = CGAffineTransformScale(newAttribute.transform, scale, scale);
        [newArray addObject:newAttribute];
    }
    return newArray;
}

 //是否每次都计算layout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect proposeRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [self layoutAttributesForElementsInRect:proposeRect];
    CGFloat offset = 1000;
    for (UICollectionViewLayoutAttributes *attribute in array) {
        UICollectionViewLayoutAttributes *newAttribute = [attribute copy];
        if (attribute.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            continue;
        }
        CGFloat newOffset = newAttribute.center.x - (proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5);
        // 绝对距离
        if (fabs(newOffset) < fabs(offset)) {
            // 计算出距离中心最近item的offset
            offset = newOffset;
        }
    }
    return CGPointMake(proposedContentOffset.x + offset, proposedContentOffset.y);
}
@end
