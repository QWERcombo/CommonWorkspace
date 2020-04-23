//
//  UISet.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UISet.h"

@implementation UISet

- (void)setNormalView:(UIView *)targetView
         cornerRadius:(CGFloat)cornerRadius
{
    
    targetView.layer.cornerRadius = cornerRadius;
    
    targetView.layer.masksToBounds = YES;
    
}



@end
