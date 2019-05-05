//
//  LectureVO.m
//  XXDemo
//
//  Created by zsp on 2019/2/21.
//  Copyright © 2019 woop. All rights reserved.
//

#import "LectureVO.h"

@implementation LectureVO

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"lecturer_id" : @"id",
             @"name" : @"name",
             @"photo_id" : @"photo_id",
             @"intro" : @"intro",
             @"labelNames" : @"label_names",
             @"totalCourse" : @"total_course"
             };
}

//+ (NSValueTransformer *)labelNamesJSONTransformer {
//
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[NSString class]];
//}

@end
