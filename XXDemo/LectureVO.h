//
//  LectureVO.h
//  XXDemo
//
//  Created by zsp on 2019/2/21.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
NS_ASSUME_NONNULL_BEGIN

@interface LectureVO : MTLModel <MTLJSONSerializing>

/**
 讲师标识
 */
@property (nonatomic, copy) NSString* lecturer_id;

/**
 讲师姓名
 */
@property (nonatomic, copy) NSString* name;

/**
 讲师照片标识
 */
@property (nonatomic, copy) NSString* photo_id;

/**
 讲师简介
 */
@property (nonatomic, copy) NSString* intro;

/**
 讲师标签 add for 讲师基本信息支持自定义字段
 */
@property(nonatomic, copy)NSArray *labelNames;

/**
 课程数 add for 讲师基本信息支持自定义字段
 */
@property(nonatomic, assign)NSInteger totalCourse;

@end

NS_ASSUME_NONNULL_END
