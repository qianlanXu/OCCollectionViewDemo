//
//  NormalViewController.h
//  OCCollectionDemo
//
//  Created by xu qianlan on 2023/5/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LayoutTypes) {
    NormalLayout,
    CustomLayout,
    ShowPictureLayout,
    CircleLayout
};

@interface NormalViewController : UIViewController

@property (nonatomic, assign) LayoutTypes layoutType;

@end

NS_ASSUME_NONNULL_END
