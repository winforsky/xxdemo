//
//  SINDRWorkModel.h
//  SachikoIllustrationComponent
//
//  Created by zsp on 2019/3/25.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

extern const struct SINDRLocalWorkKeyReadable {
    __unsafe_unretained NSString *workId;///<作品ID
    __unsafe_unretained NSString *json;///<具体的作品字符串，由web自行去解析
    __unsafe_unretained NSString *createTime;///<创建时间
    __unsafe_unretained NSString *updateTime;///<更新时间，用于获取本地最新课程排序
    __unsafe_unretained NSString *creator;///<创建者，用于区分保存本机上面的用户
    __unsafe_unretained NSString *studyType;///<学习状态
    __unsafe_unretained NSString *imgLocalPath;///<我的作品图片路径
    __unsafe_unretained NSString *projectLocalPath;///<我的作品projet路径
    __unsafe_unretained NSString *historyLocalPath;///<我的作品history路径
    __unsafe_unretained NSString *imgDentryId;///<我的作品图片路径的DentryId
    __unsafe_unretained NSString *projectDentryId;///<我的作品projet的DentryId
    __unsafe_unretained NSString *historyDentryId;///<我的作品history路径的DentryId
    __unsafe_unretained NSString *isDownload;///<是否已经下载到本地
} SINDRLocalWorkKey;

/**
 从NDR获取到的作品列表的模型
 */
@interface SINDRWorkListModel :MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) NSInteger count;
@end

/**
 NDR 作品的TiItem内容项模型
 */
@interface SINDRWorkTiItemModel :MTLModel <MTLJSONSerializing>
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
 NDR 作品定制属性
 */
@interface SINDRWorkCustomPropertiesModel :MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, assign) BOOL isCompleted;
@end

/**
 NDR 作品国际化模型
 */
@interface SINDRWorkGlobalTitleModel :MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *zhCN;
@end


/**
 NDR 作品模型
 */
@interface SINDRWorkModel :MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSArray *tiItems;
@property (nonatomic, copy) NSString *resource_type_code;
@property (nonatomic, assign) BOOL has_right;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, strong) SINDRWorkCustomPropertiesModel *custom_properties;
@property (nonatomic, copy) NSString *workId;
@property (nonatomic, copy) NSString *container_id;
@property (nonatomic, strong) SINDRWorkGlobalTitleModel *global_title;

- (NSString*)json;

@end


/**
 NDR 相关 本地保存的 与NDR作品对应的额外数据
 */
@interface SINDRLocalWorkModel :MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) SINDRWorkModel *work;///<NDR存储的作品数据
@property (nonatomic, copy) NSString *update_time;///<NDR存储的作品数据, 冗余数据，便于后面的数据库查找
@property (nonatomic, copy) NSString *workId;///<NDR存储的作品数据, 冗余数据，便于后面的数据库查找
@property (nonatomic, assign) NSInteger studyType;///<我的课程:0 未学 1：在学 2学完，非来自ndr
@property (nonatomic, copy) NSString *imgLocalPath;///<我的作品图片路径，非来自ndr
@property (nonatomic, copy) NSString *projectLocalPath;///<我的作品projet路径，非来自ndr
@property (nonatomic, copy) NSString *historyLocalPath;///<我的作品history路径，非来自ndr
@property (nonatomic, copy) NSString *imgDentryId;///<我的作品图片路径的DentryId, 冗余数据，便于后面的使用
@property (nonatomic, copy) NSString *projectDentryId;///<我的作品projet的DentryId, 冗余数据，便于后面的使用
@property (nonatomic, copy) NSString *historyDentryId;///<我的作品history路径的DentryId, 冗余数据，便于后面的使用
@property (nonatomic, assign) BOOL isDownload;///<是否已经下载到本地，非来自ndr

@end

NS_ASSUME_NONNULL_END
