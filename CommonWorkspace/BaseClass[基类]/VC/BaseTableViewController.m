//
//  ZYBaseTableViewController.m
//  DDLife
//
//  Created by 赵越 on 2020/4/23.
//  Copyright © 2020 赵越. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
