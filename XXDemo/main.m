//
//  main.m
//  XXDemo
//
//  Created by zsp on 2019/2/11.
//  Copyright © 2019 woop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void testSync()
{
    NSObject* obj = [NSObject new];
    @synchronized (obj) {
        
    }
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
