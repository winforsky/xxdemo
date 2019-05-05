//
//  UIImage+SVGManager.h
//  XXDemo
//
//  Created by zsp on 2019/4/29.
//  Copyright © 2019 woop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SVGManager)
+ (UIImage*)svgImageNamed:(NSString*)name size:(CGSize)size;
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;
@end

NS_ASSUME_NONNULL_END
