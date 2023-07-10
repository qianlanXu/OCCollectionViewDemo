//
//  CycleCollectionView.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/3.
//

#import "CycleCollectionView.h"
#import "CycleCell.h"

@interface CycleCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat scrollInterval;

@end

@implementation CycleCollectionView

- (void)dealloc {
    NSLog(@"view dealloc");
    // 要没有引用的时候，self才会调用dealloc,要在removeFromSuperView把定时器关掉
//    [_timer invalidate];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [_timer invalidate];
    NSLog(@"view removeFromSuperview %p", self.superview);
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    NSLog(@"%s",__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 要比collectionView的高度小
    layout.itemSize = CGSizeMake(self.bounds.size.width, 100);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 用户滑动的时候scrollView停在scrollView的bounds的倍数的位置，不会停在手动滑的随机位置，而是view的frame整数倍的位置
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:CycleCell.class forCellWithReuseIdentifier:CycleCell.identifier];
    [self addSubview:_collectionView];
    
    CGFloat pageControlHeight = 35.f;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - pageControlHeight, self.bounds.size.width, pageControlHeight)];
    _pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
    _pageControl.currentPageIndicatorTintColor = UIColor.blackColor;
    [self addSubview:_pageControl];
    
    _scrollInterval = 3.f;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(scrollNext) userInfo:nil repeats:YES];
    _timer.fireDate = NSDate.distantFuture;
    
    _autoPage = NO;
}

#pragma mark - Setter

- (void)setAutoPage:(BOOL)autoPage {
    _autoPage = autoPage;
    NSDate *date = autoPage ? [NSDate dateWithTimeIntervalSinceNow:_scrollInterval] : [NSDate distantFuture];
    _timer.fireDate = date;
}

// 在第一个和最后一个插入数据
- (void)setData:(NSArray<NSString *> *)data {
    _titles = [NSMutableArray arrayWithArray:data];
    [_titles insertObject:data.lastObject atIndex:0];
    [_titles addObject:data.firstObject];
    [_collectionView setContentOffset:CGPointMake(_collectionView.bounds.size.width, _collectionView.contentOffset.y) animated:NO];
    _pageControl.numberOfPages = data.count;
}

#pragma mark - 轮播方法
- (void)scrollNext {
    if(_collectionView.isDragging) {
        return;
    }
    CGFloat targetX = _collectionView.contentOffset.x + _collectionView.bounds.size.width;
    [_collectionView setContentOffset:CGPointMake(targetX, _collectionView.contentOffset.y) animated:YES];
}

- (void)cycleScroll {
    NSInteger page = _collectionView.contentOffset.x / _collectionView.bounds.size.width;
    
    if (page == 0) { // 滑到最左边
        _collectionView.contentOffset = CGPointMake(_collectionView.bounds.size.width * (_titles.count - 2), _collectionView.contentOffset.y);
        _pageControl.currentPage = _titles.count - 2;
    } else if (page == _titles.count - 1) { // 滑到最右边
        _collectionView.contentOffset = CGPointMake(_collectionView.bounds.size.width, _collectionView.contentOffset.y);
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage = page - 1;
    }
}

// 手动拖拽结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cycleScroll];
    // 如果自动播放，手动拖拽结束后间隔一段时间自动播放
    if(_autoPage) {
        _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_scrollInterval];
    }
}

// 自动播放结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self cycleScroll];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CycleCell.identifier forIndexPath:indexPath];
    cell.title = _titles[indexPath.row];
    return cell;
}


@end
