//
//  SPScriptMessageHandler.m
//  XXDemo
//
//  Created by zsp on 2019/4/30.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SPScriptMessageHandler.h"


@implementation SPScriptMessageHandler

/*! @abstract Invoked when a script message is received from a webpage.
 @param userContentController The user content controller invoking the
 delegate method.
 @param message The script message received.
 */
#pragma mark -
#pragma mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //js调用方法：window.webkit.messageHandlers.save.postMessage(params);
    if ([message.name isEqualToString:SP_JS_Call_OC_SAVE_HANDLER_NAME]) {
        [self jsCallOc_Save:message];
    } else {
        
    }
}


- (void)jsCallOc_Save:(WKScriptMessage *)message {
    NSString *dataString = message.body;//传递过来的参数
    NSString *cmdString = message.name;//传递过来的命令名称
    self.webView=message.webView;
    
    NSLog(@"cmd(params)=%@(%@)", cmdString, dataString);
    
    [self ocCallJs_saveCb:@"save ok now"];
}

- (void)ocCallJs_saveCb:(id)callbackData {
    NSString *parameter = [NSString stringWithFormat:@"json data for %@", callbackData];
    
    NSString *jsString = [NSString stringWithFormat:@"%@('%@')",SP_OC_Call_JS_SAVE_CB_HANDLER_NAME, parameter];
    
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@-result:%@", SP_OC_Call_JS_SAVE_CB_HANDLER_NAME, result);
    }];
}

@end
