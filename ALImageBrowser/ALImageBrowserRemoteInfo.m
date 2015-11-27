//
//  ALImageViewRemoteInfo.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserRemoteInfo.h"

@implementation ALImageBrowserRemoteInfo


- (instancetype)init {
    if (self = [super init]) {
        self.type = ALImageViewInfoTypeRemoteImage;
    }
    return self;
}

- (UIImage *)image {
    return self.downloadedImage;
}

@end
