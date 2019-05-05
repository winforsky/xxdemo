//
//  SPScriptMessageHandler.h
//  XXDemo
//
//  Created by zsp on 2019/4/30.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

// JS 交互方法名
#define SP_JS_Call_OC_SAVE_HANDLER_NAME @"save"     ///< 保存数据

// oc回调js
#define SP_OC_Call_JS_SAVE_CB_HANDLER_NAME @"saveCb"    ///< 保存数据的回调函数

@interface SPScriptMessageHandler : NSObject<WKScriptMessageHandler>

@property(nonatomic, weak)WKWebView *webView;

@end

NS_ASSUME_NONNULL_END
