//
//  SINDRSrtModel.h
//  XXDemo
//
//  Created by zsp on 2019/4/22.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface SINDRSrtModel :MTLModel <MTLJSONSerializing>

@property(nonatomic, assign)NSInteger lineNumber;
@property(nonatomic, assign)CGFloat start;
@property(nonatomic, assign)CGFloat end;
@property(nonatomic, copy)NSString *srt;

@end

@interface SINDRSrtModelManager : NSObject

- (NSMutableArray*)decodeSrtForUrl:(NSString*)url;
- (NSMutableArray*)decodeSrtForData:(NSData*)data;
- (NSString*)srtAtTimeInterval:(CGFloat)timeInterval;


@end

NS_ASSUME_NONNULL_END
