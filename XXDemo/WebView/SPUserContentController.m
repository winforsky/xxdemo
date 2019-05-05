//
//  SPUserContentController.m
//  XXDemo
//
//  Created by zsp on 2019/5/5.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SPUserContentController.h"
#import "SPScriptMessageHandler.h"

@interface SPUserContentController ()

@property (nonatomic, strong)SPScriptMessageHandler *scriptMessageHandler;

@end

@implementation SPUserContentController

+ (instancetype)shareInstance {
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (instancetype)init {
    if (self=[super init]) {
        self.scriptMessageHandler = [[SPScriptMessageHandler alloc] init];
        [self addScriptMessageHandler];
    }
    return self;
}


/**
 成对添加
 */
- (void)addScriptMessageHandler {
    [self addScriptMessageHandler:self.scriptMessageHandler
                             name:SP_JS_Call_OC_SAVE_HANDLER_NAME];
}


/**
 成对移除
 */
- (void)removeScriptMessageHandler {
    [self removeScriptMessageHandlerForName:SP_JS_Call_OC_SAVE_HANDLER_NAME];
}


- (void)dealloc {
    [self removeScriptMessageHandler];
    _scriptMessageHandler = nil;
}

@end
