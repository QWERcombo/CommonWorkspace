//
//  UIColor+Additional.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Additional)
//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;


@end

NS_ASSUME_NONNULL_END
