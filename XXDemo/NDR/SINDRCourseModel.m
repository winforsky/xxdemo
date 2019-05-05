//
//  SINDRCourseModel.m
//  APFCompatibleKit
//
//  Created by zsp on 2019/3/23.
//

#import "SINDRCourseModel.h"

@implementation SINDRCourseListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"items" : @"items",
             @"count" : @"count"
             };
}

+ (NSValueTransformer *)itemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SINDRCourseModel class]];
}
@end

@implementation SINDRCourseTiItemModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"ti_res_version" : @"ti_res_version",
             @"ti_is_source_file" : @"ti_is_source_file",
             @"ti_file_flag" : @"ti_file_flag",
             @"lc_ti_format" : @"lc_ti_format",
             @"ti_storage" : @"ti_storage",
             @"ti_printable" : @"ti_printable",
             @"ti_size" : @"ti_size",
             @"ti_format" : @"ti_format"
             };
}
@end

@implementation SINDRCourseStepItemModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name" : @"name",
             @"url" : @"url"
             };
}
@end

@implementation SINDRCourseStepModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"title" : @"title",
             @"name" : @"name",
             @"anim_h" : @"anim_h",
             @"anim_j" : @"anim_j",
             @"subtitle" : @"subtitle",
            @"audio" : @"audio"
             };
}
@end

@implementation SINDRCourseCustomPropertiesModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"difficulty" : @"difficulty",
             @"steps" : @"steps",
             @"thumbImgName" : @"thumbImgName"
             };
}

+ (NSValueTransformer *)stepsJSONTransformer {
    return [MTLValueTransformer
            transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
                NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *steps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSArray* rlt = [MTLJSONAdapter modelsOfClass:[SINDRCourseStepModel class] fromJSONArray:steps error:nil];
                return rlt;
            } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
                id tmpRlt=[MTLJSONAdapter JSONArrayFromModels:value error:nil];
                NSData *tmpData =[NSJSONSerialization dataWithJSONObject:tmpRlt options:0 error:nil];
                if (tmpData) {
                    NSString *rlt =[[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
                    return rlt;
                }
                return @"";
            }];
}

@end

@implementation SINDRCourseGlobalTitleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"zhCN" : @"zh-CN"
             };
}
@end

@implementation SINDRCourseModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"creator" : @"creator",
             @"update_time" : @"update_time",
             @"create_time" : @"create_time",
             @"tiItems" : @"ti_items",
             @"resource_type_code" : @"resource_type_code",
             @"has_right" : @"has_right",
             @"language" : @"language",
             @"custom_properties" : @"custom_properties",
             @"courseId" : @"id",
             @"container_id" : @"container_id",
             @"global_title" : @"global_title"
             };
}

+ (NSValueTransformer *)tiItemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SINDRCourseTiItemModel class]];
}

//+(void)coverNDRCourseToOldCourse:(SINDRCourseModel*)ndrCourse {
//    
//}
@end
