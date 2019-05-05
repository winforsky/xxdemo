//
//  LectureSDKLabelVo.h
//  XXDemo
//
//  Created by zsp on 2019/2/19.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LectureSDKLabelVo : NSObject

@property (nonatomic, copy) NSString* labelId;

@property (nonatomic, copy) NSString* labelName;

@property (nonatomic, copy) NSString* parentId;

@property (nonatomic, copy) NSArray* children;

@end

NS_ASSUME_NONNULL_END
