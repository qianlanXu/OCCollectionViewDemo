//
//  CycleCollectionView.h
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CycleCollectionView : UIView

@property (nonatomic, strong) NSArray<NSString *> *data;

/// 是否自动翻页，默认NO
@property (nonatomic, assign) BOOL autoPage;

@end

NS_ASSUME_NONNULL_END
