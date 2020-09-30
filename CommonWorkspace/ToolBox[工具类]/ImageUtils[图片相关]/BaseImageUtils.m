//
//  DDImageUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseImageUtils.h"

@implementation BaseImageUtils

+ (BaseImageUtils *)sharedImageUtils
{
    
    static BaseImageUtils *ddImageUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        ddImageUtils = [[BaseImageUtils alloc] init];
        
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


- (void)compressedImageFiles:(UIImage *)image
                     imageKB:(CGFloat)fImageKBytes
                  imageBlock:(void(^)(UIImage *image))block {
    
    __block UIImage *imageCope = image;
    CGFloat fImageBytes = fImageKBytes * 1024;//需要压缩的字节Byte
    
    __block NSData *uploadImageData = nil;
    
    uploadImageData = UIImageJPEGRepresentation(imageCope, 1);
//    NSLog(@"图片压前缩成 %fKB",uploadImageData.length/1024.0);
    CGSize size = imageCope.size;
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    if ((uploadImageData.length > fImageBytes) && (fImageBytes > 0)) {
        
        /* 宽高的比例 **/
        CGFloat ratioOfWH = imageWidth/imageHeight;
        /* 压缩率 **/
        CGFloat compressionRatio = fImageBytes/uploadImageData.length;
        /* 宽度或者高度的压缩率 **/
        CGFloat widthOrHeightCompressionRatio = sqrt(compressionRatio);
        
        CGFloat dWidth   = imageWidth *widthOrHeightCompressionRatio;
        CGFloat dHeight  = imageHeight*widthOrHeightCompressionRatio;
        if (ratioOfWH > 0) { /* 宽 > 高,说明宽度的压缩相对来说更大些 **/
            dHeight = dWidth/ratioOfWH;
        }else {
            dWidth  = dHeight*ratioOfWH;
        }
        
        imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
        uploadImageData = UIImageJPEGRepresentation(imageCope, 1);
        
//        NSLog(@"当前的图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        //微调
        NSInteger compressCount = 0;
        /* 控制在 1M 以内**/
        while (uploadImageData.length > fImageBytes) {
            /* 再次压缩的比例**/
            CGFloat nextCompressionRatio = 0.9;
            
            if (uploadImageData.length > fImageBytes) {
                dWidth = dWidth*nextCompressionRatio;
                dHeight= dHeight*nextCompressionRatio;
            }else {
                dWidth = dWidth/nextCompressionRatio;
                dHeight= dHeight/nextCompressionRatio;
            }
            
            imageCope = [self drawWithWithImage:imageCope width:dWidth height:dHeight];
            uploadImageData = UIImageJPEGRepresentation(imageCope, 1);
            
            /*防止进入死循环**/
            compressCount ++;
            if (compressCount == 10) {
                break;
            }
            
        }
        
//        NSLog(@"图片已经压缩成 %fKB",uploadImageData.length/1024.0);
        imageCope = [[UIImage alloc] initWithData:uploadImageData];
        block(imageCope);

    } else {
        block(imageCope);
    }
}
/* 根据 dWidth dHeight 返回一个新的image**/
- (UIImage *)drawWithWithImage:(UIImage *)imageCope width:(CGFloat)dWidth height:(CGFloat)dHeight{
    
    UIGraphicsBeginImageContext(CGSizeMake(dWidth, dHeight));
    [imageCope drawInRect:CGRectMake(0, 0, dWidth, dHeight)];
    imageCope = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCope;
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
