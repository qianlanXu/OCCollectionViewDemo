//
//  SimpleDecorationView.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/21.
//

#import "SimpleDecorationView.h"

@interface SimpleDecorationView ()

@property (nonatomic, strong) UIView *decorationView;

@end

@implementation SimpleDecorationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _decorationView = [[UIView alloc] init];
        _decorationView.backgroundColor = UIColor.blueColor;
        [self addSubview:_decorationView];
    }
    return self;
}

+ (NSString *)identifier {
    return @"SimpleDecorationView";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _decorationView.frame = self.bounds;
}

- (void)dealloc {
    NSLog(@"Simple decoration dealloc");
}
@end
