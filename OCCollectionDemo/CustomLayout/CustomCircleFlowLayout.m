//
//  CustomCircleFlowLayout.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/27.
//

#import "CustomCircleFlowLayout.h"

@interface CustomCircleFlowLayout ()

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) NSMutableSet* insertedRowSet;
@property (nonatomic, strong) NSMutableSet* deletedRowSet;

@end

@implementation CustomCircleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    CGSize size = self.collectionView.bounds.size;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _center = CGPointMake(size.width * 0.5, size.height * 0.5);
    _radius = size.width / 2.5;
    
    _insertedRowSet = NSMutableSet.set;
    _deletedRowSet = NSMutableSet.set;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = NSMutableArray.array;
    for (NSInteger i = 0; i < _cellCount; i++) {
        // 这里的所有布局属性都需要我们自己实现，没有父类方法可以调用了
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(70, 70);
    // 从-M_PI_2的地方开始
    CGFloat x = _center.x + _radius * cosf(2 * indexPath.item * M_PI / _cellCount - M_PI_2);
    CGFloat y = _center.y + _radius * sinf(2 * indexPath.item * M_PI / _cellCount - M_PI_2);
    attributes.center = CGPointMake(x, y);
    attributes.transform3D = CATransform3DMakeRotation(2 * M_PI * indexPath.item / _cellCount, 0, 0, 1);
    return attributes;
}
@end
