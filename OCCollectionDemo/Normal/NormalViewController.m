//
//  NormalViewController.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import "NormalViewController.h"
#import "NormalCollectionViewCell.h"
#import "NormalHeaderView.h"
#import "SimpleCollectionFlowLayout.h"
#import "PictureLayout.h"
#import "CustomCircleFlowLayout.h"
#import "FlowLayout.h"

@interface NormalViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, assign) NSUInteger sectionCount;

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _count = 30;
    _sectionCount = 5;
    self.navigationItem.title = @"Normal";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    [self createView];
    
}

#pragma mark - Private Methods

- (void)addItem:(id)sender {
    [_collectionView performBatchUpdates:^{
        [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:29 inSection:0]]];
        [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:2 inSection:0]]];
    } completion:^(BOOL finish){
        NSLog(@"finish is  %d", finish);
    }];
}

#pragma mark - Custom UI

- (void)createView {
    UICollectionViewFlowLayout *layout = [self selectLayout:_layoutType];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = UIColor.redColor;
    _collectionView.allowsMultipleSelection = YES;
    [_collectionView registerClass:NormalCollectionViewCell.class forCellWithReuseIdentifier:NormalCollectionViewCell.identifier];
    [_collectionView registerClass:NormalHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NormalHeaderView.identifier];
    [self.view addSubview:_collectionView];
}

- (UICollectionViewFlowLayout *)selectLayout:(LayoutTypes)type {
    UICollectionViewFlowLayout *layout;
    // switch里面不能定义临时变量
    switch (type) {
        case NormalLayout:
            // switch一个整体块，里面定义的临时变量属于整个switch，如果只在某个分支里初始化会导致其他分支未初始化
            layout = [[UICollectionViewFlowLayout alloc] init];
            layout.minimumLineSpacing = 20;
            layout.minimumInteritemSpacing = 40;
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            layout.itemSize = CGSizeMake(40, 40);
            layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
            break;
        case CustomLayout:
            layout = [[SimpleCollectionFlowLayout alloc] init];
            layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
            break;
        case ShowPictureLayout:
            layout = [[PictureLayout alloc] init];
            break;
        case CircleLayout:
            layout = [[CustomCircleFlowLayout alloc] init];
            break;
        case Flow:
            layout = [[FlowLayout alloc] init];
            break;;
        default:
            break;
    }
    return layout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sectionCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NormalCollectionViewCell.identifier forIndexPath:indexPath];
    cell.number = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NormalHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NormalHeaderView.identifier forIndexPath:indexPath];
    headerView.number = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
    return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中
    //[collectionView deselectItemAtIndexPath:indexPath animated:NO];
    // 通过 indexPath 获取当前 cell
    NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.number = @"tap";
    cell.backgroundView.backgroundColor = UIColor.yellowColor;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.number = @"unTap";
    cell.backgroundView.backgroundColor = UIColor.orangeColor;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.number = @"height";
    cell.backgroundView.backgroundColor = UIColor.blueColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalCollectionViewCell *cell = (NormalCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.number = @"unhighlight";
    cell.backgroundView.backgroundColor = UIColor.blueColor;
}

// 是否对cell点击事件响应
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(10, 10);
    }
    return CGSizeMake(100, 100);
}



@end
