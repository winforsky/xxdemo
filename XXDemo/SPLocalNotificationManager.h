//
//  SPLocalNotificationManager.h
//  XXDemo
//
//  Created by zsp on 2019/4/16.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface SPLocalNotificationManager : NSObject

@property(nonatomic, strong, readonly) NSMutableArray *localNotifications;

+ (instancetype)shareInstance;

- (UNNotificationRequest *)addOneNotificationAfter:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
