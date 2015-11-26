//
//  ALImageBrowserView.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageBrowserBaseInfo.h"

@class ALImageBrowserView;

@protocol ALImageBrowserViewDelegate <NSObject>
- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView longPressAtInfo:(ALImageBrowserBaseInfo *)info;
- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView singleTapAtInfo:(ALImageBrowserBaseInfo *)info imageViewCurrentRect:(CGRect)rect;
- (NSArray *)imageBrowserInfoArrayForImageBrowserView:(ALImageBrowserView *)imageBrowserView;
@end
@interface ALImageBrowserView : UIView

@property (nonatomic, weak) id<ALImageBrowserViewDelegate> delegate;
- (void)reloadData;
- (void)reloadDataAtIndex:(NSInteger)index;

@end
