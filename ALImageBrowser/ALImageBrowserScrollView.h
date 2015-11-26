//
//  ALImageBrowserScrollView.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/25.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageBrowserBaseInfo.h"

@class ALImageBrowserScrollView;

@protocol ALImageBrowserScrollViewDelegate <NSObject>

- (void)imageBrowserScrollView:(ALImageBrowserScrollView *)imageBrowserScrollView longPressAtInfo:(ALImageBrowserBaseInfo *)info;
- (void)imageBrowserScrollView:(ALImageBrowserScrollView *)imageBrowserScrollView singleTapAtInfo:(ALImageBrowserBaseInfo *)info imageViewCurrentRect:(CGRect)rect;
@end

@interface ALImageBrowserScrollView : UIScrollView

- (instancetype)initWithImageInfo:(ALImageBrowserBaseInfo *)info rect:(CGRect)rect;
@property (nonatomic, weak) id<ALImageBrowserScrollViewDelegate> imageBrowserDelegate;

@end
