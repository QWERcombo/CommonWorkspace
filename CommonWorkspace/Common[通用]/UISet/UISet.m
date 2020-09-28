//
//  UISet.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UISet.h"
#import "UIImageView+CornerRadius.h"

@implementation UISet

+ (UILabel *)getCustomLabelWithText:(NSString *)labText
                          textColor:(UIColor *)labTextColor
                           textFont:(UIFont *)labTextFont
                      textAlignment:(NSTextAlignment)textAlignment {
 
    UILabel *label = [UILabel new];
    label.text = labText;
    label.font = labTextFont;
    label.textColor = labTextColor;
    label.textAlignment = textAlignment;
    
    return label;
}

+ (UIButton *)getCustomButtonWithBtnTitle:(NSString *)btnTitle
                            btnTitleColor:(UIColor *)btnTitleColor
                             btnTitleFont:(UIFont *)btnTitleFont
                             btnNormalImg:(UIImage *)normalImg
                             btnSelectImg:(UIImage *)selectImg
                                   target:(id)target
                                      sel:(SEL)sel {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:btnTitle forState:UIControlStateNormal];
    [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = btnTitleFont;
    [button setImage:normalImg forState:UIControlStateNormal];
    if (selectImg) {
        [button setImage:selectImg forState:UIControlStateSelected];
    }
    if (sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (UITextField *)getCustomTextFieldWithTextFont:(UIFont *)textFont
                                      textColor:(UIColor *)textColor
                                     isShowLine:(BOOL)isShowLine {
    
    UITextField *tf = [[UITextField alloc] init];
    tf.font = textFont;
    tf.textColor = textColor;
    
    if (isShowLine) {
        UIView *line = [UIView new];
        line.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [tf addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tf);
            make.top.equalTo(tf.mas_bottom);
            make.height.mas_offset(1);
        }];
    }
    
    return tf;
}

+ (UIImageView *)getCustomImageViewCornerType:(ImageViewCornerType)cornerType
                                 cornerRadius:(CGFloat)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc] init];
    if (cornerType == ImageViewCornerType_isCircle) {
        [imageView zy_cornerRadiusRoundingRect];
    } else if (cornerType == ImageViewCornerType_isNormal) {
        [imageView zy_cornerRadiusAdvance:cornerRadius rectCornerType:UIRectCornerAllCorners];
    }
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    return imageView;
}


+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView
                          lineLength:(int)lineLength
                         lineSpacing:(int)lineSpacing
                           lineColor:(UIColor *)lineColor
                         isHorizonal:(BOOL)isHorizonal {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setBounds:lineView.bounds];

    if (isHorizonal) {

        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];

    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {

        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
