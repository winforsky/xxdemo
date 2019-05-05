//
//  SINDRCourseModel.h
//  APFCompatibleKit
//
//  Created by zsp on 2019/3/23.
//

#import <Foundation/Foundation.h>
//#import "SICourseModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

/**
 从NDR获取到的课程列表的模型
 */
@interface SINDRCourseListModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) NSInteger count;
@end

/**
 NDR 课程的TiItem内容项模型
 */
@interface SINDRCourseTiItemModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign) NSInteger ti_res_version;
@property (nonatomic, assign) BOOL ti_is_source_file;
@property (nonatomic, copy) NSString *ti_file_flag;
@property (nonatomic, copy) NSString *lc_ti_format;
@property (nonatomic, copy) NSString *ti_storage;
@property (nonatomic, assign) BOOL ti_printable;
@property (nonatomic, assign) long ti_size;
@property (nonatomic, copy) NSString *ti_format;
@end

/**
 NDR 课程定制属性里面的step里面的内容项模型
 */
@interface SINDRCourseStepItemModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@end

/**
 NDR 课程定制属性里面的step模型
 */
@interface SINDRCourseStepModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) SINDRCourseStepItemModel *anim_h;
@property (nonatomic, strong) SINDRCourseStepItemModel *anim_j;
@property (nonatomic, strong) SINDRCourseStepItemModel *subtitle;
@property (nonatomic, strong) SINDRCourseStepItemModel *audio;
@end

/**
 NDR 课程定制属性
 */
@interface SINDRCourseCustomPropertiesModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign) NSInteger difficulty;
//@property (nonatomic, copy) NSString *steps;
@property (nonatomic, copy) NSArray *steps;
@property (nonatomic, copy) NSString *thumbImgName;
@end

/**
 NDR 课程标题国际化模型
 */
@interface SINDRCourseGlobalTitleModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *zhCN;
@end

/**
 NDR 课程模型 以及 我的课程模型  共用
 */
@interface SINDRCourseModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSArray *tiItems;
@property (nonatomic, copy) NSString *resource_type_code;
@property (nonatomic, assign) BOOL has_right;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, strong) SINDRCourseCustomPropertiesModel *custom_properties;
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, copy) NSString *container_id;
@property (nonatomic, strong) SINDRCourseGlobalTitleModel *global_title;

@property (nonatomic, assign) NSInteger studyType;//我的课程:0 未学 1：在学 2学完


//+(void)coverNDRCourseToOldCourse:(SINDRCourseModel*)ndrCourse;
@end

NS_ASSUME_NONNULL_END
