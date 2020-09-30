//
//  DDImageUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片操作类
 */
@interface BaseImageUtils : NSObject

/**
 初始化单例
 
 @return 单例对象
 */
+ (BaseImageUtils *)sharedImageUtils;

/**
 颜色转图片
 
 @param color 颜色
 @return img
 */
- (UIImage *)imageWithColor:(UIColor *)color;


/**
 生成渐变色图片
 
 @param fromColor color1
 @param toColor color2
 @param rect 大小
 @return img
 */
- (UIImage *)gradualImageWithFromColor:(UIColor *)fromColor
                               toColor:(UIColor *)toColor
                                  rect:(CGRect)rect;

/**
 压缩图片
 
 @param sourceImage 压缩前img
 @param defineWidth 目标宽
 @param maxFileSize 大小
 @return 压缩后img
 */
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage
                       targetWidth:(CGFloat)defineWidth
                     toMaxFileSize:(NSInteger)maxFileSize;

///压缩图片大小kb
- (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block;

///修改图片的渲染色
- (UIImage *)renderImage:(UIImage *)image
                 toColor:(UIColor *)toColor
                    alpa:(CGFloat)alpa;

@end

NS_ASSUME_NONNULL_END
