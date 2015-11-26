//
//  ALImageViewLocalInfo.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserLocalInfo.h"

@implementation ALImageBrowserLocalInfo

- (instancetype)init {
    if (self = [super init]) {
        self.type = ALImageViewInfoTypeLocalImage;
    }
    return self;
}

- (UIImage *)image {
    return self.localImage;
}

@end
