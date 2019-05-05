//
//  ViewController.m
//  XXDemo
//
//  Created by zsp on 2019/2/11.
//  Copyright © 2019 woop. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Mantle/Mantle.h>
#import <Masonry/Masonry.h>

#import "LectureVO.h"
#import "LectureSDKLabelVo.h"

#import "LectureStarTipView.h"

#import "SINDRCourseModel.h"
#import "SINDRWorkModel.h"
#import <UserNotifications/UserNotifications.h>

#import <objc/runtime.h>

#import "SINDRSrtModel.h"


@interface ViewController ()

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UIImageView *bgImageView;
@property(nonatomic, strong)UILabel *textLabel;
@property(nonatomic, strong)LectureStarTipView *starTipView;

@property(nonatomic, strong)NSMutableArray *mutableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self loadData];
//    [self loadJsonDataForNDRCourse];
//    [self loadJsonDataForNDRWork];
//    [self loadJsonDataForLecture];
//    [self loadImageViewWithCycle];
//    [self loadSysncDemo];
    
//    [self addLottieView];
//    [self loadSrtData];
}

- (void)loadSrtData {
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"srt" ofType:@"txt"]];
    SINDRSrtModelManager *manager= [[SINDRSrtModelManager alloc] init];
    [manager decodeSrtForData:data];
    NSString *tmpSrt = [manager srtAtTimeInterval:12];
    NSLog(@"tmpSrt = %@", tmpSrt);
}

- (void) addLottieView {
    
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

- (void)loadSysncDemo {
    self.mutableArray =[NSMutableArray arrayWithCapacity:5];
    for (int i=0; i<5; i++) {
        [self.mutableArray addObject:[NSString stringWithFormat:@"object-%d", i]];
    }
    
    [self testSysnc];
}

- (void)updateMutableArray:(NSString*)value {
//    线程间的同步
    @synchronized (self) {
        for (int i=0; i<self.mutableArray.count; i++) {
            NSString *currentObject = [self.mutableArray objectAtIndex:i];
            [self.mutableArray replaceObjectAtIndex:i withObject:[currentObject stringByAppendingFormat:@"-%@", value]];
            NSLog(@"data = %@", [self.mutableArray objectAtIndex:i]);
        }
    }
    
    [self.mutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
}

- (void)testSysnc {
    NSString *foo=@"foo";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateMutableArray:foo];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateMutableArray:foo];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateMutableArray:foo];
    });
}


- (void)loadData {
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"f001" ofType:@"json"]];
    NSMutableArray *tmpArray = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
    
    NSMutableArray *rebuildDatas=[self rebuildLabelData:tmpArray];
    NSLog(@"data = %@", rebuildDatas);
}

- (void)loadImageViewWithCycle {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    imageView.image=[UIImage imageNamed:@"Brochu"];
    self.imageView=imageView;
    [self.view addSubview:imageView];
    
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(120);
    }];
    
    imageView.layer.cornerRadius=60;
    imageView.layer.masksToBounds=YES;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:imageView.bounds];
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 10.f;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.strokeStart = 0.f;
    layer.strokeEnd = 1.f;
    layer.path=path.CGPath;
    [imageView.layer addSublayer:layer];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 220, 35)];
    UIImage *tmpImage=[UIImage imageNamed:@"elearning_lecturer_label"];
    bgImageView.image=[tmpImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 36, 0, 15)];
    self.bgImageView=bgImageView;
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.imageView.mas_bottom);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(35);
    }];
    
    self.textLabel=[[UILabel alloc] init];
    self.textLabel.textColor=[UIColor purpleColor];
    self.textLabel.font=[UIFont systemFontOfSize:16];
    self.textLabel.text=@"明星赛明星赛导师";
    [self.view addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView).offset(4);
        make.leading.equalTo(self.bgImageView).offset(30);
    }];
    
    self.starTipView=[[LectureStarTipView alloc] init];
    [self.view addSubview:self.starTipView];
    [self.starTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imageView);
        make.height.mas_equalTo(35);
        make.width.mas_greaterThanOrEqualTo(120);
    }];
    
    [self.starTipView updateViewWithData:@"对方"];
}

- (void)loadJsonDataForNDRCourse {
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ndr-course" ofType:@"json"]];
    NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
    
    NSError *error;
    
    SINDRCourseModel *model =[MTLJSONAdapter modelOfClass:[SINDRCourseModel class] fromJSONDictionary:dict error:&error];
    
//    NSArray *steps = [NSJSONSerialization JSONObjectWithData:[model.custom_properties.steps dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//    NSArray* rlt = [MTLJSONAdapter modelsOfClass:[SINDRCourseStepModel class] fromJSONArray:steps error:&error];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }else{
        NSLog(@"model = %@", model);
    }
    
    NSDictionary *tmpDict = [MTLJSONAdapter JSONDictionaryFromModel:model error:nil];
    NSData *tmpData = [NSJSONSerialization dataWithJSONObject:tmpDict options:0 error:nil];
    NSString *tmpStr = [[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
    NSLog(@"tmpStr= %@", tmpStr);
    
}

- (void)loadJsonDataForNDRWork {
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ndr-course-1" ofType:@"json"]];
    NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
    
    NSError *error;
    
    SINDRWorkModel *model =[MTLJSONAdapter modelOfClass:[SINDRWorkModel class] fromJSONDictionary:dict error:&error];
    
    //    NSArray *steps = [NSJSONSerialization JSONObjectWithData:[model.custom_properties.steps dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    //    NSArray* rlt = [MTLJSONAdapter modelsOfClass:[SINDRCourseStepModel class] fromJSONArray:steps error:&error];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }else{
        NSLog(@"model = %@", model);
    }
    
    NSDictionary *tmpDict = [MTLJSONAdapter JSONDictionaryFromModel:model error:nil];
    NSData *tmpData = [NSJSONSerialization dataWithJSONObject:tmpDict options:0 error:nil];
    NSString *tmpStr = [[NSString alloc] initWithData:tmpData encoding:NSUTF8StringEncoding];
    NSLog(@"tmpStr= %@", tmpStr);
    
}

- (void)loadJsonDataForLecture {
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lecture" ofType:@"json"]];
    NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil] mutableCopy];
    
    NSError *error;
    
    NSArray* rlt = [MTLJSONAdapter modelsOfClass:[LectureVO class] fromJSONArray:dict[@"items"] error:&error];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }else{
        NSLog(@"count = %@", @(rlt.count));
    }
}

- (NSMutableArray*)rebuildLabelData:(NSArray*)labels {
    NSMutableArray *tmpArray=[NSMutableArray array];
    for (NSDictionary *dic in labels) {
        NSMutableArray *innerTmpArray=[NSMutableArray array];
        [self rebuildLabelFrom:dic appendTo:innerTmpArray];
        if (innerTmpArray.count>0) {
            [tmpArray addObject:innerTmpArray];
        }
    }
    return tmpArray;
}

- (void)rebuildLabelFrom:(NSDictionary*)dic appendTo:(NSMutableArray*)array {
    NSArray *tmpKeys = dic.allKeys;
    if (tmpKeys.count>0) {
        LectureSDKLabelVo *label = [[LectureSDKLabelVo alloc]init];
        if ([tmpKeys containsObject:@"label_id"]) {
            label.labelId=dic[@"label_id"];
        }
        if ([tmpKeys containsObject:@"label_name"]) {
            label.labelName=dic[@"label_name"];
        }
        if ([tmpKeys containsObject:@"parent_id"]) {
            label.parentId=dic[@"parent_id"];
        }
        NSLog(@"%@", label);
        [array addObject:label];
        
        if ([tmpKeys containsObject:@"children"]) {
            [self rebuildLabelData:dic[@"children"] appendTo:array];
        }
        
    }
}

- (void)rebuildLabelData:(NSArray*)labels appendTo:(NSMutableArray*)array {
    for (NSDictionary *dic in labels) {
        NSMutableArray *innerTmpArray=[NSMutableArray array];
        [self rebuildLabelFrom:dic appendTo:innerTmpArray];
        if (innerTmpArray.count>0) {
            [array addObjectsFromArray:innerTmpArray];
        }
    }
}


@end
