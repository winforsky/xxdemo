//
//  SINDRSrtModel.m
//  XXDemo
//
//  Created by zsp on 2019/4/22.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SINDRSrtModel.h"

@implementation SINDRSrtModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"lineNumber" : @"lineNumber",
             @"start" : @"start",
             @"end" : @"end",
             @"srt" : @"srt"
             };
}
@end

@interface SINDRSrtModelManager ()
@property(nonatomic, strong)NSMutableArray *srtModels;
@end

@implementation SINDRSrtModelManager

/*
 1
 00:00:00,025 --> 00:00:01,150
 大家好
 
 */
- (NSMutableArray*)decodeSrtForUrl:(NSString*)httpurl {
    NSURL *url = [NSURL URLWithString:httpurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [self decodeSrtForData:data];
}

- (NSMutableArray*)decodeSrtForData:(NSData*)data {
    NSString *tmpStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.srtModels=[NSMutableArray array];
    
    NSArray *singlearray=[tmpStr componentsSeparatedByString:@"\r\n"];
    int count = 0;
    SINDRSrtModel *tmpModel;
    for (NSUInteger i = 0, iLen=singlearray.count; i < iLen; i++) {
        
        if ((i % 4) == 0) {
            if (tmpModel) {
                [self.srtModels addObject:[tmpModel copy]];
            }
            tmpModel=[[SINDRSrtModel alloc] init];
            tmpModel.lineNumber=count++;
        }else if ((i % 4) == 1) {
            //时间
            NSString *timeStr = [singlearray objectAtIndex:i];
            NSRange range2 = [timeStr rangeOfString:@" --> "];
            if (range2.location != NSNotFound) {
                NSString *beginstr = [timeStr substringToIndex:range2.location];
                NSString *endstr = [timeStr substringFromIndex:range2.location+range2.length];
                
                NSArray * arr = [beginstr componentsSeparatedByString:@":"];
                NSArray * arr1 = [arr[2] componentsSeparatedByString:@","];
                //将开始时间数组中的时间换化成秒为单位的
                CGFloat teim=[arr[0] floatValue] * 60*60 + [arr[1] floatValue]*60 + [arr1[0] floatValue] + [arr1[1] floatValue]/1000;
                tmpModel.start=teim;
                
                NSArray * array = [endstr componentsSeparatedByString:@":"];
                NSArray * arr2 = [array[2] componentsSeparatedByString:@","];
                //将结束时间数组中的时间换化成秒为单位的
                CGFloat fl=[array[0] floatValue] * 60*60 + [array[1] floatValue]*60 + [arr2[0] floatValue] + [arr2[1] floatValue]/1000;
                tmpModel.end=fl;
            }
        }else if ((i % 4) == 2) {
            //中文字幕
            NSString *subStr = [NSString stringWithFormat:@"%@",[singlearray objectAtIndex:i]];
            tmpModel.srt=subStr;
        }
    }
    
    if (self.srtModels.count>0) {
        return self.srtModels;
    }
    return nil;
}

- (NSString*)srtAtTimeInterval:(CGFloat)timeInterval {
    for (SINDRSrtModel *model in self.srtModels) {
        if (timeInterval>model.start && timeInterval<model.end) {
            return model.srt;
        }
    }
    return nil;
}


@end
