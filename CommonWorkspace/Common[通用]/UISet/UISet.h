//
//  UISet.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ImageViewCornerType) {
    ImageViewCornerType_isNone,
    ImageViewCornerType_isNormal,
    ImageViewCornerType_isCircle,
};

@interface UISet : NSObject

///Label
+ (UILabel *)getCustomLabelWithText:(NSString *)labText
                          textColor:(UIColor *)labTextColor
                           textFont:(UIFont *)labTextFont
                      textAlignment:(NSTextAlignment)textAlignment;

///Button
+ (UIButton *)getCustomButtonWithBtnTitle:(null_unspecified NSString *)btnTitle
                            btnTitleColor:(null_unspecified UIColor *)btnTitleColor
                             btnTitleFont:(null_unspecified UIFont *)btnTitleFont
                             btnNormalImg:(null_unspecified UIImage *)normalImg
                             btnSelectImg:(null_unspecified UIImage *)selectImg
                                   target:(null_unspecified id)target
                                      sel:(null_unspecified SEL)sel;

///TextField
+ (UITextField *)getCustomTextFieldWithTextFont:(UIFont *)textFont
                                      textColor:(UIColor *)textColor
                                     isShowLine:(BOOL)isShowLine;

///UIImageView
///isCircle 0.圆角 1.圆形
///cornerRadius 圆角值
+ (UIImageView *)getCustomImageViewCornerType:(ImageViewCornerType)cornerType
                                 cornerRadius:(CGFloat)cornerRadius;

///绘制虚线
///param lineView:       需要绘制成虚线的view
///param lineLength:     虚线的宽度
///param lineSpacing:    虚线的间距
///param lineColor:      虚线的颜色
///param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                         isHorizonal:(BOOL)isHorizonal;

@end

NS_ASSUME_NONNULL_END
