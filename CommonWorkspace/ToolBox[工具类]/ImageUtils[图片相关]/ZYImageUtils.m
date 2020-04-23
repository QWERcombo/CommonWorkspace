//
//  DDImageUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYImageUtils.h"

@implementation ZYImageUtils

+ (ZYImageUtils *)sharedDDImageUtils
{
    
    static ZYImageUtils *ddImageUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddImageUtils = [[ZYImageUtils alloc] init];
        
    });
    
    return ddImageUtils;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)gradualImageWithFromColor:(UIColor *)fromColor
                               toColor:(UIColor *)toColor
                                  rect:(CGRect)rect {
    
    NSMutableArray *ar = [NSMutableArray array];
    [ar addObject:(id)fromColor.CGColor];
    [ar addObject:(id)toColor.CGColor];
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([toColor CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    
    CGPoint start;
    
    CGPoint end;
    
    
    start = CGPointMake(0.0, rect.size.height);
    
    end = CGPointMake(rect.size.width, 0.0);
    
    
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth toMaxFileSize:(NSInteger)maxFileSize{
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.5f;
    NSData *imageData = UIImageJPEGRepresentation(newImage, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(newImage, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    
    return compressedImage;
}

- (UIImage *)renderImage:(UIImage *)image
                 toColor:(UIColor *)toColor
                    alpa:(CGFloat)alpa {
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];

    
    CGContextSetFillColorWithColor(context, toColor.CGColor);
    
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    
    CGContextFillRect(context, rect);
    
    UIImage *resulet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resulet;
}

@end
