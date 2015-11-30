//
//  ALImageBrowserAnimatorInfo.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/30.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALImageBrowserAnimatorInfo : NSObject

@property (nonatomic, assign) CGRect beginRect;
@property (nonatomic, assign) CGRect endRect;
@property (nonatomic, strong) UIImage *image;

@end
