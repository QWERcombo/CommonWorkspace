//
//  JYLWebVC.m
//  JYL_iOS
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ZYWebVC.h"
#import <WebKit/WebKit.h>

@interface ZYWebVC ()<WKUIDelegate>
@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation ZYWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.naviTitle;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    if (self.requestUrl.length) {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]]];
        NSLog(@"%@", self.requestUrl);
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.requestHtmlText.length) {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).width.insets(UIEdgeInsetsMake(20, 15, 20, 15));
        }];
        [self.wkWebView loadHTMLString:self.requestHtmlText baseURL:nil];
    }
}

- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{

    //如果是跳转一个新页面
    if (navigationAction.targetFrame==nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);

}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {

    NSLog(@"createWebViewWithConfiguration");

    if (!navigationAction.targetFrame.isMainFrame) {

        [webView loadRequest:navigationAction.request];

    }

    return nil;
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
