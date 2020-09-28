//
//  UILabel+AttributedText.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UILabel+AttributedText.h"

@implementation UILabel (AttributedText)


+ (NSMutableAttributedString *)getAttributedStringWithFullText:(NSString *)fullText
                                                   replaceText:(NSString *)replaceText
                                                     textColor:(UIColor *)color
                                                      textFont:(UIFont *)font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullText];
    
    NSArray *replaceRangeArr = [replaceText componentsSeparatedByString:@"-"];
    
    for (NSString *replaceSubText in replaceRangeArr) {
        NSRange replaceSubRange = [fullText rangeOfString:replaceSubText];
        
        if (font) {
            [attributedString addAttribute:NSFontAttributeName value:font range:replaceSubRange];
        }
        
        if (color) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:replaceSubRange];
        }
        
    }
    
    return attributedString;
}

@end
