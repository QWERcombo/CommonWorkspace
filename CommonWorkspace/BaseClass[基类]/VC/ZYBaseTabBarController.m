//
//  DDBaseTabBarController.m
//  DDLife
//
//  Created by 赵越 on 2019/7/11.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "ZYBaseTabBarController.h"
#import "ZYBaseNavigationController.h"
#import "HomeViewController.h"
#import "QuotationViewController.h"
#import "ContractViewController.h"
#import "MineViewController.h"

@interface ZYBaseTabBarController ()

@end

@implementation ZYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.translucent = NO;
        
        // 通过appearance统一设置UITabbarItem的文字属性
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];  // 设置文字大小
        attrs[NSForegroundColorAttributeName] = TABBAR_TITLE_UNSELECT;  // 设置文字的前景色

        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = TABBAR_TITLE_SELECT;

        UITabBarItem * item = [UITabBarItem appearance];
        // 设置appearance
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        HomeViewController *home = [HomeViewController initViewControllerFromStoryBoardName:@"Home"];
        home.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_select"];
        home.tabBarItem.image = [UIImage imageNamed:@"tab_home_unselect"];
        [home.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [home.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        home.tabBarItem.tag = 101;
        ZYBaseNavigationController *homeNavi = [[ZYBaseNavigationController alloc] initWithRootViewController:home];
        homeNavi.tabBarItem.title = @"首页";
        home.title = homeNavi.tabBarItem.title;
        [self addChildViewController:homeNavi];
        
        
        QuotationViewController *service = [QuotationViewController initViewControllerFromStoryBoardName:@"Quotation"];
        service.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_course_select"];
        service.tabBarItem.image = [UIImage imageNamed:@"tab_course_unselect"];
        [service.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [service.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        service.tabBarItem.tag = 102;
        ZYBaseNavigationController *serviceNavi = [[ZYBaseNavigationController alloc] initWithRootViewController:service];
        service.title = service.tabBarItem.title;
        serviceNavi.tabBarItem.title = @"行情";
        service.title = serviceNavi.tabBarItem.title;
        [self addChildViewController:serviceNavi];
        
        
        ContractViewController *intelligent = [ContractViewController initViewControllerFromStoryBoardName:@"Contract"];
        intelligent.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_intelligent_select"];
        intelligent.tabBarItem.image = [UIImage imageNamed:@"tab_intelligent_unselect"];
        [intelligent.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [intelligent.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        intelligent.tabBarItem.tag = 103;
        ZYBaseNavigationController *intelligentNavi = [[ZYBaseNavigationController alloc] initWithRootViewController:intelligent];
        intelligentNavi.tabBarItem.title = @"合约";
        intelligent.title = intelligentNavi.tabBarItem.title;
        [self addChildViewController:intelligentNavi];
        
        
        MineViewController *me = [MineViewController initViewControllerFromStoryBoardName:@"Mine"];
        me.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_me_select"];
        me.tabBarItem.image = [UIImage imageNamed:@"tab_me_unselect"];
        [me.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [me.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        me.tabBarItem.tag = 104;
        ZYBaseNavigationController *meNavi = [[ZYBaseNavigationController alloc] initWithRootViewController:me];
        meNavi.tabBarItem.title = @"我的";
        me.title = meNavi.tabBarItem.title;
        [self addChildViewController:meNavi];
        
        
    }
    return self;
}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
