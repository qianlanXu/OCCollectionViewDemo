//
//  CycleViewController.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/7.
//

#import "CycleViewController.h"
#import "CycleCollectionView.h"

@interface CycleViewController ()

@property (nonatomic, strong) CycleCollectionView *cycleView;

@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

-(void)dealloc {
    NSLog(@"dealloc");
}
- (void)createView {
    _cycleView = [[CycleCollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200)];
    _cycleView.data = @[@"Hello", @"World", @"!"];
    _cycleView.autoPage = YES;
    [self.view addSubview:_cycleView];
}

@end
