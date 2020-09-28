//
//  UIView+Additional.m
//  CommonWorkspace
//
//  Created by mac on 2020/9/28.
//  Copyright © 2020 赵越. All rights reserved.
//

#import "UIView+Additional.h"

@implementation UIView (Additional)

- (void)setCornerByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii viewBounds:(CGRect)bounds {
    
    [self layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
}

@end
