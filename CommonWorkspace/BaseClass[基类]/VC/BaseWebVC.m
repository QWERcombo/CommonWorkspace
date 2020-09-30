//
//  JYLWebVC.m
//  JYL_iOS
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseWebVC.h"
#import <WebKit/WebKit.h>

@interface BaseWebVC ()<WKUIDelegate>
@property (strong, nonatomic) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UIBarButtonItem *p_backBtn;
@property (nonatomic, strong) UIBarButtonItem *p_closeBtn;
@property (nonatomic, strong) UIBarButtonItem *p_reloadBtn;
@end

@implementation BaseWebVC

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
    
    [self p_setNaviBarButtonItem];
    [self p_addProgressView];
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

#pragma mark - Private
- (void)p_setNaviBarButtonItem {
    
    self.p_backBtn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"global_navi_back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectedToBack)];
    self.p_closeBtn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"global_navi_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectedToClose)];
    
    @weakify(self);
    [RACObserve(self.wkWebView, canGoBack) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            self.navigationItem.leftBarButtonItems = @[self.p_backBtn, self.p_closeBtn];
        } else {
            self.navigationItem.leftBarButtonItems = @[self.p_backBtn];
        }
    }];
    
    self.p_reloadBtn = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"global_navi_reload"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(selectedToReloadData)];
    self.navigationItem.rightBarButtonItem = self.p_reloadBtn;
}
- (void)selectedToBack {
    if (self.wkWebView.canGoBack == 1) {
        [self.wkWebView goBack];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)selectedToClose {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectedToReloadData {
    [self.wkWebView reload];
}

- (void)p_addProgressView {
    [self.wkWebView addSubview:self.progressView];
    @weakify(self);
    [RACObserve(self.wkWebView, estimatedProgress) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:[x floatValue] animated:YES];
        if ([x floatValue] >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }];
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, ([[UIScreen mainScreen]bounds].size.width), 1);
        _progressView.progress = 0.1f;
        _progressView.progressTintColor = UIColor.blueColor;
        [_progressView setProgress:0.0 animated:YES];
    }
    return _progressView;
}

@end
