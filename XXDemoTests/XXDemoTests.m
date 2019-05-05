//
//  XXDemoTests.m
//  XXDemoTests
//
//  Created by zsp on 2019/2/11.
//  Copyright © 2019 woop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPLocalNotificationManager.h"
#import <UserNotifications/UserNotifications.h>

@interface XXDemoTests : XCTestCase

@end

@implementation XXDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAddOneNotification {
    SPLocalNotificationManager *manager = [SPLocalNotificationManager shareInstance];
    XCTAssertNotNil(manager, "manager must not nil");
    UNNotificationRequest *request = [manager addOneNotificationAfter:1];
    XCTAssertNotNil(request, @"request must not nil");
}

- (void)testAsyncAction {
    XCTestExpectation *expectation = [self expectationWithDescription:@"async desc"];
    __block int count = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(1);
        count=count+6;
        XCTAssertEqual(count, 6, "count added start with 0 by 6");
        NSLog(@"count = %d", count);
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        NSLog(@"error at: %@", error.localizedDescription);
    }];
    
}

@end
