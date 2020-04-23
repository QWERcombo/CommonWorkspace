//
//  DDPromptUtils.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYPromptUtils.h"
#import <SVProgressHUD.h>

@interface ZYPromptUtils()

@property SVProgressHUD *HUD;

@end

@implementation ZYPromptUtils
@synthesize HUD;

+ (ZYPromptUtils *)sharedDDPromptUtils
{
    
    static ZYPromptUtils *ddPromptUtils;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ddPromptUtils = [[ZYPromptUtils alloc] init];
        
    });
    
    return ddPromptUtils;
}

+(void)loading{
    
    [SVProgressHUD showWithStatus:@"loading..."];
    
    [ZYPromptUtils setSVProgressHUDStyle];
}

+ (void)loadingWithMsg:(NSString *)msg{
    
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [ZYPromptUtils setSVProgressHUDStyle];
}

+ (void)hideLoading{
    
    [SVProgressHUD dismiss];
    [ZYPromptUtils setSVProgressHUDStyle];
}

+ (void)promptMsg:(NSString *)msg{
    
    [ZYPromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME];
    
    
}

+ (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [ZYPromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
    
}

+ (void)promptSuccess:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [ZYPromptUtils setSVProgressHUDStyle];
    [SVProgressHUD showSuccessWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismissWithDelay:PROMPT_TIME completion:^{
        promptCompletion();
    }];
}

+ (void)promptError:(NSString *)msg{
    
    [ZYPromptUtils setSVProgressHUDStyle];
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
