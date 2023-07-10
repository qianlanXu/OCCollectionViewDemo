//
//  CircleViewController.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/29.
//

#import "CircleViewController.h"
#import "CustomCircleFlowLayout.h"
#import "SimpleCollectionFlowLayout.h"
#import "NormalCollectionViewCell.h"

@interface CircleViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CustomCircleFlowLayout *circleLayout;
@property (nonatomic, strong) SimpleCollectionFlowLayout *simpleLayout;

@property (nonatomic, strong) UISegmentedControl *control;
@property (nonatomic, assign) NSUInteger cellCount;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    _cellCount = 12;
}

- (void)createView {
    _circleLayout = [[CustomCircleFlowLayout alloc] init];
    _simpleLayout = [[SimpleCollectionFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_circleLayout];
    [_collectionView registerClass:NormalCollectionViewCell.class forCellWithReuseIdentifier:NormalCollectionViewCell.identifier];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteItem)];
    
    _control = [[UISegmentedControl alloc] initWithItems:@[@"circle", @"Flow"]];
    _control.selectedSegmentIndex = 0;
    [_control addTarget:self action:@selector(didChange) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _control;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.collectionView addGestureRecognizer:recognizer];
    
}

#pragma mark - Event

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    NSIndexPath *indexPath;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            //判断手势落点位置是否在路径上
            //方法通过坐标找到对应的 Item
            indexPath = [self.collectionView indexPathForItemAtPoint:[recognizer locationInView:_collectionView]];
            if (indexPath) {
                //在路径上则开始移动该路径上的cell
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[recognizer locationInView:_collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)didChange {
    if (_collectionView.collectionViewLayout == _circleLayout) {
        // 使当前layout失效
        [_collectionView.collectionViewLayout invalidateLayout];
        // 设置新的layout
        [_collectionView setCollectionViewLayout:_simpleLayout animated:YES];
        [_collectionView performBatchUpdates:^{
            _cellCount--;
            [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
        } completion:nil];
    } else {
        [_collectionView.collectionViewLayout invalidateLayout];
        [_collectionView setCollectionViewLayout:_circleLayout animated:YES];
        [_collectionView reloadData];
    }
}

- (void)addItem {
    [_collectionView performBatchUpdates:^{
        _cellCount++;
        [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_cellCount-1 inSection:0]]];
    } completion:nil];
}

- (void)deleteItem {
    [_collectionView performBatchUpdates:^{
        _cellCount--;
        [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_cellCount inSection:0]]];
    } completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cellCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NormalCollectionViewCell.identifier forIndexPath:indexPath];
    cell.number = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - 移动
//返回YES允许其item移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//移动item时回调
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

#pragma mark - 高亮

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:1 animations:^{
        cell.transform = CGAffineTransformMakeScale(2.f, 2.f);
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:1 animations:^{
        cell.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}
@end
