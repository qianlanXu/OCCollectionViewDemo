//
//  CycleCell.m
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/3.
//

#import "CycleCell.h"

@interface CycleCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation CycleCell

+ (NSString *)identifier {
    return @"CycleCellId";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.backgroundColor = UIColor.yellowColor;
    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _textLabel.font = [UIFont fontWithName:@"AmericanTypeWriter" size:50];
    _textLabel.textColor = UIColor.blackColor;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _textLabel.text = title;
}

@end
