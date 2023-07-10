//
//  SimpleCollectionFlowLayout.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/19.
//

#import "SimpleCollectionFlowLayout.h"
#import "SimpleDecorationView.h"

@implementation SimpleCollectionFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.minimumLineSpacing = 40;
        self.minimumInteritemSpacing = 20;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.itemSize = CGSizeMake(50, 50);
        [self registerClass:SimpleDecorationView.class forDecorationViewOfKind:SimpleDecorationView.identifier];
    }
    return self;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newAttributes = NSMutableArray.array;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        // 临时变量保存,否则可能引起崩溃
        UICollectionViewLayoutAttributes *newAttribute = [attribute copy];
        // 代表item
        if(nil == newAttribute.representedElementKind) {
            if(newAttribute.indexPath.row == 5 && newAttribute.indexPath.section == 2) {
                newAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:5 inSection:2]];
            }
        }
        // 代表UICollectionElementCategorySupplementaryView
        if(newAttribute.representedElementCategory == UICollectionElementCategorySupplementaryView){
            if (newAttribute.indexPath.section == 1) {
                newAttribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
            }
        }
        
        [newAttributes addObject:newAttribute];
    }
    if ([self.collectionView numberOfSections] >1) {
        UICollectionViewLayoutAttributes *decorationAttribute = [self layoutAttributesForDecorationViewOfKind:SimpleDecorationView.identifier atIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        
        [newAttributes addObject:decorationAttribute];
    }
    
    return newAttributes;
}

#pragma mark - 重写系统方法
// 系统一般不会主动调用你你重写的这几个方法（不是绝对不会调用啊，比如下面的移动 Item 的时候，就是系统调用这个方法获取被点击的 Item 的布局属性。所以最好还是实现这几个方法，然后手动在 layoutAttributesForElementsInRect: 中调用），需要你自己在 layoutAttributesForElementsInRect: 中手动调用
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    //最好不要直接修改这个数组里的元素，而是创建一个新的拷贝。否则当你想增删修改 cell 的时候会出现下面的问题，极有可能引起应用崩溃
    UICollectionViewLayoutAttributes *newAttributes = [attributes copy];
    newAttributes.transform = CGAffineTransformMakeRotation(-M_PI_4);
    return newAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    UICollectionViewLayoutAttributes *newAttributes = [attributes copy];
    newAttributes.alpha = 0.8;
    return newAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    UICollectionViewLayoutAttributes *newAttributes = [attributes copy];
    if([elementKind isEqualToString:SimpleDecorationView.identifier]) {
        // 第一个item位置
        NSIndexPath *indexFirst = [NSIndexPath indexPathForItem:0 inSection:1];
        // 最后一个item位置
        NSIndexPath *indexLast = [NSIndexPath indexPathForItem:[self.collectionView numberOfItemsInSection:1] inSection:1];
        UICollectionViewLayoutAttributes *attributeFirst = [self layoutAttributesForItemAtIndexPath:indexFirst];
        UICollectionViewLayoutAttributes *attributeLast = [self layoutAttributesForItemAtIndexPath:indexLast];
        
        newAttributes.frame = CGRectMake(attributes.frame.origin.x, attributeFirst.frame.origin.y, self.collectionView.bounds.size.width, attributeLast.frame.origin.y - attributeFirst.frame.origin.y);
        // 想要作为背景图像，就一定要将其 zIndex 设置为 -1
        newAttributes.zIndex = -1;
        
    }
    return newAttributes;
    
}
@end
