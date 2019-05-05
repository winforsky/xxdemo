//
//  ThirdViewController.m
//  XXDemo
//
//  Created by zsp on 2019/4/30.
//  Copyright © 2019 woop. All rights reserved.
//

#import "ThirdViewController.h"

#import <WebKit/WebKit.h>

#import "SPScriptMessageHandler.h"
#import "SPUserContentController.h"

@interface ThirdViewController ()<WKUIDelegate, WKNavigationDelegate>


@property (nonatomic, strong) IBOutlet WKWebView *webView;
@property (nonatomic, strong)WKUserContentController *userContentController;



@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configWebView];
}

- (void)configWebView {
    WKWebViewConfiguration *configuration =[[WKWebViewConfiguration alloc] init];
    configuration.userContentController=[SPUserContentController shareInstance];
    self.userContentController=configuration.userContentController;
    self.webView =[[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.UIDelegate=self;
    self.webView.navigationDelegate=self;
    [self.view addSubview:self.webView];
    
    // 加载测试
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"html"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest]; // 加载页面
}

#pragma mark -
#pragma mark WKUIDelegate 用来响应定制web的UI问题

/**
 拦截window.open() 方法，如果不实现的话，该方法调用则没有响应

 @param webView <#webView description#>
 @param configuration <#configuration description#>
 @param navigationAction <#navigationAction description#>
 @param windowFeatures <#windowFeatures description#>
 @return <#return value description#>
 */
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (navigationAction.request.URL) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:webView.frame configuration:configuration];
        wkWebView.UIDelegate = self;
        wkWebView.navigationDelegate = self;
        [webView loadRequest:navigationAction.request];
        return wkWebView;
    }
    return nil;
}
/**
 拦截alert弹出，使用系统的弹出接管网页的弹出

 @param webView <#webView description#>
 @param message <#message description#>
 @param frame <#frame description#>
 @param completionHandler <#completionHandler description#>
 */
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark WKNavigationDelegate 用来响应定制的web导航问题


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
