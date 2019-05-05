//
//  SPUserContentController.h
//  XXDemo
//
//  Created by zsp on 2019/5/5.
//  Copyright © 2019 woop. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SPScriptMessageHandler;

@interface SPUserContentController : WKUserContentController

@property (nonatomic, strong, readonly)SPScriptMessageHandler *scriptMessageHandler;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
