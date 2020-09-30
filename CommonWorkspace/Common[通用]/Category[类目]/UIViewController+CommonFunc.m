//
//  UIViewController+CommonFunc.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "UIViewController+CommonFunc.h"
#import "BasePromptUtils.h"

@implementation UIViewController (CommonFunc)

#pragma- 网络请求提示器
- (void)loading{
    
    [self endViewEditing];
    [BasePromptUtils loading];
}

- (void)lodingMsg:(NSString *)msg{
    
    [BasePromptUtils loadingWithMsg:msg];
}

//结束页面编辑
- (void)endViewEditing
{
    [self.view endEditing:YES];
}

#pragma 隐藏网络请求指示器
- (void)hideLoading {
    
    [BasePromptUtils hideLoading];
    [self hideStatusLoading];
}

#pragma mark - 气泡提示
//气泡提示
- (void)promptMsg:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    [BasePromptUtils promptMsg:msg];
}

//气泡提示 with block
- (void)promptMsg:(NSString *)msg promptCompletion:(void (^)(void))promptCompletion{
    
    [self hideStatusLoading];
    
    [BasePromptUtils promptMsg:msg promptCompletion:^{
        promptCompletion();
    }];
    
}

- (void)promptMsgOnWindow:(NSString *)msg{
    
    [self hideStatusLoading];
    [self.view endEditing:YES];
    
    [BasePromptUtils promptMsg:msg];
}

- (void)promptReqSuccess:(NSString *)msg{
    
    [BasePromptUtils promptSuccess:msg promptCompletion:^{}];
    
}

//请求超时
- (void)promptRequestTimeOut{
    
    [self hideStatusLoading];
    [self promptMsg:TIP_NETWORK_TIMEOUT];
    
}

//网络请求失败
- (void)promptNetworkFailed{
    
    [self promptMsg:TIP_NETWORK_NO_CONNECTION];
}

#pragma mark - 状态栏网络请求
//显示状态栏网络请求
- (void)showStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//隐藏状态栏网络请求
- (void)hideStatusLoading{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


+ (UIViewController*)currentViewController {
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = ((UITabBarController*)vc).selectedViewController;
            
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController*)vc).visibleViewController;
            
        }
        
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
            
        }else{
            
            break;
        }
        
    }
    
    return vc;
}

+ (__kindof UIViewController *)initViewControllerFromStoryBoardName:(NSString *)storyBoardName {
    return [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end


@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}
@end
