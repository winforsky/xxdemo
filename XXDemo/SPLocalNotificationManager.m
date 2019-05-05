//
//  SPLocalNotificationManager.m
//  XXDemo
//
//  Created by zsp on 2019/4/16.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SPLocalNotificationManager.h"
#import <UIKit/UIKit.h>


@interface SPLocalNotificationManager ()

@property(nonatomic, strong) NSMutableArray *localNotifications;

@end

@implementation SPLocalNotificationManager
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static SPLocalNotificationManager *manager;
    dispatch_once(&onceToken, ^{
        manager=[[self alloc] init];
    });
    return manager;
}

- (UNNotificationRequest *)addOneNotificationAfter:(NSTimeInterval)timeInterval {
//    UILocalNotification
    UNNotificationContent *content= [[UNNotificationContent alloc] init];
    UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval*60 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"onl" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter]
     addNotificationRequest:request
     withCompletionHandler:^(NSError * _Nullable error) {
         NSLog(@"request had added ok");
     }];
    return request;
    /*
     想播放一段音乐来通知用户有新订单了，要求0延迟。
     
     UILocalNotification *notification=[[UILocalNotification alloc] init];
     if (notification!=nil) {
     NSDate *now=[NSDate new];
     notification.fireDate=[now dateByAddingTimeInterval:0];//立即通知
     notification.repeatInterval=0;//循环次数，
     notification.timeZone=[NSTimeZone defaultTimeZone];
     notification.applicationIconBadgeNumber=0; //应用的红色数字
     notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @”myMusic.caf”
     //去掉下面2行就不会弹出提示框
     notification.alertBody=@”通知内容”;//提示信息 弹出提示框
     notification.alertAction = @”打开”; //提示框按钮
     //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
     */
}

@end
