//
//  MyFlowLayout.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/28.
//

#import "MyFlowLayout.h"

@interface MyFlowLayout ()

@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation MyFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    _itemCount = 30;
    _attributesArray = [NSMutableArray array];
    CGFloat itemWidth = (UIScreen.mainScreen.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) * 0.5;
    float columnHeight[2] = {self.sectionInset.top, self.sectionInset.bottom};
    for (int i = 0; i < _itemCount; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:index];
        CGFloat itemHeight = arc4random()%150 + 30;
        float minHeight = MIN(columnHeight[0], columnHeight[1]);
        int column = columnHeight[0] < columnHeight[1] ? 0 : 1;
        CGFloat left = self.sectionInset.left + column * (itemWidth + self.minimumInteritemSpacing);
        attributes.frame = CGRectMake(left, minHeight, itemWidth, itemHeight);
        columnHeight[column] += (itemHeight + self.minimumLineSpacing);
        [_attributesArray addObject:attributes];
        _maxHeight = MAX(columnHeight[0], columnHeight[1]);
    }
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesArray;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, _maxHeight);
}
@end
