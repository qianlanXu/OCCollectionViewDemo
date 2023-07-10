//
//  NormalCollectionViewCell.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import "NormalCollectionViewCell.h"

@interface NormalCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation NormalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = UIColor.greenColor;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_label sizeToFit];
    _label.center = self.contentView.center;
}

#pragma mark - Public Methods

+ (NSString *)identifier {
    return @"NormalCollectionViewCell";
}

#pragma mark - Setter

- (void)setNumber:(NSString *)number {
    _number = number;
    _label.text = _number;
    [self setNeedsLayout];
}
@end
