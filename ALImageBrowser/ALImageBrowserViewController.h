//
//  ALImageBrowserViewController.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageBrowserBaseInfo.h"
#import "ALImageBrowserAnimatorInfo.h"

@class ALImageBrowserViewController;

@protocol ALImageBrowserViewControllerDelegate <NSObject>
//present动画起始位置
- (ALImageBrowserAnimatorInfo *)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didPresentWithInfo:(ALImageBrowserBaseInfo *)info;
//dimiss动画结束位置
- (ALImageBrowserAnimatorInfo *)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDismissWithInfo:(ALImageBrowserBaseInfo *)info;
//图片操作
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDeleteImageAtInfo:(ALImageBrowserBaseInfo *)info;
@end

typedef NS_ENUM(NSInteger, ALImageBrowserViewLongPressOperationType) {
    ALImageBrowserViewLongPressOperationTypeSave,
    ALImageBrowserViewLongPressOperationTypeDelete,
    ALImageBrowserViewLongPressOperationTypeShare
};

typedef NS_ENUM(NSInteger, ALImageBrowserViewControllerPresentType) {
    ALImageBrowserViewControllerPresentTypeDefault,
    ALImageBrowserViewControllerPresentTypeCustomed,
};

@interface ALImageBrowserViewController : UIViewController

@property (nonatomic, weak) id<ALImageBrowserViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSArray *longpressOperationArray;
@property (nonatomic, assign) NSInteger startIndex;
- (instancetype)initWithPresentType:(ALImageBrowserViewControllerPresentType)presentType;

@end
