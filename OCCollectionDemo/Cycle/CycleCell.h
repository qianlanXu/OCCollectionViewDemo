//
//  CycleCell.h
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CycleCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
