//
//  DDPromptUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BasePromptUtils.h"
#import <SVProgressHUD.h>

@interface BasePromptUtils()

@property SVProgressHUD *HUD;

@end

@implementation BasePromptUtils
@synthesize HUD;

+(void)loading{
    
    [SVProgressHUD showWithStatus:@"loading..."];
    
    [BasePromptUtils setSVProgressHUDStyle];
}

+ (void)loadingWithMsg:(NSString *)msg{
    
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [BasePromptUtils setSVProgressHUDStyle];
}

+ (void)hideLoading{
    
    [SVProgressHUD dismiss];
    [BasePromptUtils setSVProgressHUDStyle];
}

+ (void)promptMsg:(NSString *)msg{
    
    [BasePromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
    
}

+ (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [BasePromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
    
}

+ (void)promptSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [BasePromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showSuccessWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
}

+ (void)promptError:(NSString *)msg{
    
    [BasePromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
}

+ (void)setSVProgressHUDStyle{
    
    CGFloat phoneVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (phoneVersion > 9) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
    
}


@end
