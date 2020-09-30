//
//  DDAlertUtils.h
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 弹窗提示
 */
@interface BaseAlertUtils : NSObject

+ (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                     cancelTitle:(NSString *)cancelTitle
                       doneTitle:(NSString *)doneTitle
                     doneHandler:(void(^)(void))doneHandler;


@end

NS_ASSUME_NONNULL_END
