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

@property(nonatomic, strong)CALayer *secondLayer;
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self configWebView];
    
    [self loadLayer];
}

/**
 Apple doc中还有一句描述是这样的：
 
 When you specify the frame of a layer, position is set relative to the anchor point. When you specify the position of the layer, bounds is set relative to the anchor point.
 
 大意是：当你设置图层的frame属性的时候，position根据锚点（anchorPoint）的值来确定，而当你设置图层的position属性的时候，bounds会根据锚点(anchorPoint)来确定。
 
 这段翻译的上半句根据前面的公式容易理解，后半句可能就有点令人迷惑了，当修改position时，bounds的width与height会随之修改吗？其实,position是点，bounds是矩形，根据锚点(anchorPoint)来确定的只是它们的位置，而不是内部属性。所以，上面这段英文这么翻译就容易理解了：
 
 当你设置图层的frame属性的时候，position点的位置（也就是position坐标）根据锚点（anchorPoint）的值来确定，而当你设置图层的position属性的时候，bounds的位置（也就是frame的orgin坐标）会根据锚点(anchorPoint)来确定。
 
 总结
 1、position是layer中的anchorPoint在superLayer中的位置坐标。
 2、互不影响原则：单独修改position与anchorPoint中任何一个属性都不影响另一个属性。
 3、frame、position与anchorPoint有以下关系：
 frame.origin.x = position.x - anchorPoint.x * bounds.size.width；
 frame.origin.y = position.y - anchorPoint.y * bounds.size.height；
 第2条的互不影响原则还可以这样理解：position与anchorPoint是处于不同坐标空间中的重合点，修改重合点在一个坐标空间的位置不影响该重合点在另一个坐标空间中的位置。
 
 原文来自：http://wonderffee.github.io/blog/2013/10/13/understand-anchorpoint-and-position/
 demo来自：https://www.jianshu.com/p/998a6119a275
 */

- (void)loadLayer {
    CGFloat clockWidht = 380;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, clockWidht, clockWidht)];
    [self.view addSubview:backgroundView];
    backgroundView.backgroundColor = [UIColor lightGrayColor];
    
    UIImage *image = [UIImage imageNamed:@"clock"];
    backgroundView.layer.contents = (__bridge id)image.CGImage;
    
    CALayer *secondLayer = [CALayer layer];
    //注意这里的2次设置frame
    secondLayer.frame = CGRectMake(clockWidht / 2 - 20, 70, 40, 120);
    secondLayer.contentsGravity = kCAGravityResizeAspect;
    secondLayer.contents = (__bridge id)[UIImage imageNamed:@"zhen"].CGImage;
    secondLayer.anchorPoint = CGPointMake(0.5, 1);
    //注意这里的2次设置frame，修改锚点后再次修正frame
//想修改anchorPoint而不想移动layer时，仅仅需要在修改anchorPoint后再重新设置一遍frame就可以达到目的，这时position就会自动进行相应的改变。
    secondLayer.frame = CGRectMake(clockWidht / 2 - 20, 70, 40, 120);
    [backgroundView.layer addSublayer:secondLayer];
    self.secondLayer = secondLayer;
    
    [self startTick];
}
- (void)startTick{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
}

- (void)tick {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    self.secondLayer.transform = CATransform3DMakeRotation(secsAngle, 0, 0, 1);
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
