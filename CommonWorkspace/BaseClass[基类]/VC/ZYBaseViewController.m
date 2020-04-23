//
//  DDBaseViewController.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYBaseViewController.h"

@interface ZYBaseViewController ()

@end

@implementation ZYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rt_disableInteractivePop = NO;
    
    [self configurateNavigationBarSetting];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)configurateNavigationBarSetting {
    
    self.rt_disableInteractivePop = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular], NSForegroundColorAttributeName:[UIColor blackColor]}];

    self.navigationController.navigationBar.barTintColor = [UIColor groupTableViewBackgroundColor];
}

@end
