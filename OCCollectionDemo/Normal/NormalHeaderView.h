//
//  NormalHeaderView.h
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *number;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
