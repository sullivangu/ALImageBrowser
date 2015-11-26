//
//  UIImage+AIFExtraMethod.h
//  AIFCore
//
//  Created by Gin on 14-1-27.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AIFExtraMethod)

/*
 * 按照Rect截取Image里一块生成新的image
 */
- (UIImage *)getSubImage:(CGRect)rect;

/*
 * 按照size缩小
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 * 调整图片大小至适合屏幕
 */
- (UIImage *)imageWithAspectFillStyle;

/*
 * 按照VGA缩小
 */
- (UIImage *)scaleToVGA;

/*
 * 获取图片内存大小
 */
- (size_t)imageBytesSize;

/*
 * 反转成向上方向
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/*
 * 按照size缩小
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/*
 * 获取bundle中的图片
 */
+ (UIImage *)imageNamedForBundle:(NSString *)name;

/*
 * 图片模糊处理
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/*
 *iphone5图片处理
 */
+ (UIImage*)imageNamedForDevice:(NSString*)name;

/**
 全屏截图
 */
+ (UIImage *)fullScreenShot;

@end
