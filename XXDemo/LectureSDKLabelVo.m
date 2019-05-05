//
//  LectureSDKLabelVo.m
//  XXDemo
//
//  Created by zsp on 2019/2/19.
//  Copyright © 2019 woop. All rights reserved.
//

#import "LectureSDKLabelVo.h"

@implementation LectureSDKLabelVo


- (NSString*)description {
    return [NSString stringWithFormat:@"label id:%@ name=>%@ parentId=>%@", self.labelId, self.labelName, self.parentId];
}

@end
