//
//  NormalCollectionViewCell.h
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *number;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
