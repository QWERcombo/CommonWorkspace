//
//  UIView+Additional.h
//  CommonWorkspace
//
//  Created by mac on 2020/9/28.
//  Copyright © 2020 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Additional)

///自定义圆角
- (void)setCornerByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii viewBounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
