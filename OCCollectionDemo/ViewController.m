//
//  ViewController.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/8.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    button.backgroundColor = UIColor.redColor;
    [button setTitle:@"TAP ME" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onTappedButton:(UIButton *)button {
    MainViewController *viewController = [[MainViewController alloc] init];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationViewController animated:YES completion:nil];
}
@end
