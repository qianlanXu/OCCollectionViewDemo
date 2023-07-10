//
//  MainViewController.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/8.
//

#import "MainViewController.h"
#import "NormalViewController.h"
#import "CircleViewController.h"
#import "CycleViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self createView];
}

- (void)createView {
    UIButton *normalLayout = [UIButton buttonWithType:UIButtonTypeCustom];
    normalLayout.frame = CGRectMake(0, 0, 100, 100);
    normalLayout.center = CGPointMake(200, 100);
    normalLayout.backgroundColor = UIColor.redColor;
    [normalLayout setTitle:@"normal" forState:UIControlStateNormal];
    [normalLayout addTarget:self action:@selector(onNormal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalLayout];
    
    UIButton *custom = [UIButton buttonWithType:UIButtonTypeCustom];
    custom.frame = CGRectMake(0, 0, 100, 100);
    custom.center = CGPointMake(200, 200);
    custom.backgroundColor = UIColor.grayColor;
    [custom setTitle:@"custom" forState:UIControlStateNormal];
    [custom addTarget:self action:@selector(onCustom:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:custom];
    
    UIButton *picture = [UIButton buttonWithType:UIButtonTypeCustom];
    picture.frame = CGRectMake(0, 0, 100, 100);
    picture.center = CGPointMake(200, 300);
    picture.backgroundColor = UIColor.systemPinkColor;
    [picture setTitle:@"Picture" forState:UIControlStateNormal];
    [picture addTarget:self action:@selector(onPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picture];
    
    UIButton *customLayout = [UIButton buttonWithType:UIButtonTypeCustom];
    customLayout.frame = CGRectMake(0, 0, 100, 100);
    customLayout.center = CGPointMake(200, 400);
    customLayout.backgroundColor = UIColor.greenColor;
    [customLayout setTitle:@"CustomLayout" forState:UIControlStateNormal];
    [customLayout addTarget:self action:@selector(onCustomLayout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customLayout];
    
    UIButton *cycle = [UIButton buttonWithType:UIButtonTypeCustom];
    cycle.frame = CGRectMake(0, 0, 100, 100);
    cycle.center = CGPointMake(200, 600);
    cycle.backgroundColor = UIColor.orangeColor;
    [cycle setTitle:@"Cycle" forState:UIControlStateNormal];
    [cycle addTarget:self action:@selector(onCycle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cycle];
}

- (void)onNormal:(UIButton *)button {
    NormalViewController *viewController = [[NormalViewController alloc] init];
    viewController.layoutType = NormalLayout;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)onCustom:(UIButton *)button {
    NormalViewController *viewController = [[NormalViewController alloc] init];
    viewController.layoutType = CustomLayout;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)onPicture:(UIButton *)button {
    NormalViewController *viewController = [[NormalViewController alloc] init];
    viewController.layoutType = ShowPictureLayout;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)onCustomLayout:(UIButton *)button {
    CircleViewController *viewController = [[CircleViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)onCycle:(UIButton *)button {
    CycleViewController *viewController = [[CycleViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
