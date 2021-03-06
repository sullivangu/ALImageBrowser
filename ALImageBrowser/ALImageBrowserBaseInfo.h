//
//  ALImageViewInfo.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/25.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALImageViewInfoState) {
    ALImageViewInfoStateImageNotCached,
    ALImageViewInfoStateImageCached,
    ALImageViewInfoStateError,
};

typedef NS_ENUM(NSInteger,ALImageViewInfoType) {
    ALImageViewInfoTypeRemoteImage,
    ALImageViewInfoTypeLocalImage
};


@interface ALImageBrowserBaseInfo : NSObject

//本地图片或者远端图片
@property (nonatomic, assign) ALImageViewInfoType type;
@property (nonatomic, strong) NSURL *url;

//状态
@property (nonatomic, assign) ALImageViewInfoState state;

//获取图片
@property (nonatomic, readonly) UIImage *image;

@end
