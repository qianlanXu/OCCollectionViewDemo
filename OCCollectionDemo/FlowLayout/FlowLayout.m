//
//  FlowLayout.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/26.
//

#import "FlowLayout.h"

@interface FlowLayout ()

@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, strong) NSMutableArray *attributeArray;

@end

@implementation FlowLayout

- (void)prepareLayout {
    _itemCount = 30;
    _attributeArray = [NSMutableArray array];
    [super prepareLayout];
    CGFloat itemWidth = (UIScreen.mainScreen.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) * 0.5;
    CGFloat columnHeight[2] = {self.sectionInset.top, self.sectionInset.bottom};
    for (int i = 0; i < _itemCount; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        CGFloat height = arc4random() % 150 + 40;
        int width = 0;
        if (columnHeight[0] < columnHeight[1]) {
            columnHeight[0] = columnHeight[0] + height + self.minimumLineSpacing;
            width = 0;
        } else {
            columnHeight[1] = columnHeight[1] + height + self.minimumLineSpacing;
            width = 1;
        }
        
        attribute.frame = CGRectMake(self.sectionInset.left + width * (itemWidth + self.minimumInteritemSpacing), columnHeight[width] - height - self.minimumLineSpacing, itemWidth, height);
        [_attributeArray addObject:attribute];
    }
    _maxHeight = MAX(columnHeight[0], columnHeight[1]);
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(200, _maxHeight);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributeArray;
}
@end
