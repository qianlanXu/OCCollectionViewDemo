//
//  NormalHeaderView.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import "NormalHeaderView.h"

@interface NormalHeaderView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation NormalHeaderView

- (void)dealloc {
    NSLog(@"Normal Header Dealloc");
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.orangeColor;
        _label = [[UILabel alloc] init];
        _label.backgroundColor = UIColor.yellowColor;
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_label sizeToFit];
    _label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

#pragma mark - Public Methods

+ (NSString *)identifier {
    return @"NormalHeaderView";
}

#pragma mark - Setter

- (void)setNumber:(NSString *)number {
    _number = number;
    _label.text = number;
    [self setNeedsLayout];
}
@end
