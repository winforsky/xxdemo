//
//  SINDRWorkModel.m
//  SachikoIllustrationComponent
//
//  Created by zsp on 2019/3/25.
//

#import "SINDRWorkModel.h"

const struct SINDRLocalWorkKeyReadable SINDRLocalWorkKey = {
    .workId = @"workId",
    .json = @"json",
    .createTime = @"createTime",
    .updateTime = @"updateTime",
    .creator = @"creator",
    .studyType = @"studyType",
    .imgLocalPath = @"imgLocalPath",
    .projectLocalPath = @"projectLocalPath",
    .historyLocalPath = @"historyLocalPath",
    .imgDentryId = @"imgDentryId",
    .projectDentryId = @"projectDentryId",
    .historyDentryId = @"historyDentryId",
    .isDownload = @"isDownload"
};

@implementation SINDRWorkListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"items" : @"items",
             @"count" : @"count"
             };
}

+ (NSValueTransformer *)itemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SINDRWorkModel class]];
}
@end

@implementation SINDRWorkTiItemModel
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

@implementation SINDRWorkCustomPropertiesModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"courseId" : @"courseId",
             @"isCompleted" : @"isCompleted"
             };
}
@end

@implementation SINDRWorkGlobalTitleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"zhCN" : @"zh-CN"
             };
}
@end

@implementation SINDRWorkModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"creator" : @"creator",
             @"update_time" : @"update_time",
             @"create_time" : @"create_time",
             @"tiItems" : @"ti_items",
             @"resource_type_code" : @"resource_type_code",
             @"has_right" : @"has_right",
             @"language" : @"language",
             @"custom_properties" : @"custom_properties",
             @"workId" : @"id",
             @"container_id" : @"container_id",
             @"global_title" : @"global_title"
             };
}

+ (NSValueTransformer *)tiItemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SINDRWorkTiItemModel class]];
}

- (NSString*)json {
    NSDictionary * tmpRlt = [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
    NSData *tmpData =[NSJSONSerialization dataWithJSONObject:tmpRlt options:0 error:nil];
    if (tmpData) {
        NSString *rlt =[[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
        return rlt;
    }
    return nil;
}
@end

@implementation SINDRLocalWorkModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

@end
