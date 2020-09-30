//
//  DDAlertUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseAlertUtils.h"

@implementation BaseAlertUtils

+ (void)showSystemAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                     cancelTitle:(NSString *)cancelTitle
                       doneTitle:(NSString *)doneTitle
                     doneHandler:(void(^)(void))doneHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:doneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        doneHandler();
    }]];
    
    if (cancelTitle.length) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
    }
    
    [[UIViewController currentViewController] presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
