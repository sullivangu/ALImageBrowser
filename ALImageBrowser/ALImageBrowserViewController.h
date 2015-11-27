//
//  ALImageBrowserViewController.h
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALImageBrowserBaseInfo.h"

@class ALImageBrowserViewController;

@protocol ALImageBrowserViewControllerDelegate <NSObject>
@required
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didQuitWithInfo:(ALImageBrowserBaseInfo *)info lastRect:(CGRect)rect;
@optional
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDeleteImageAtInfo:(ALImageBrowserBaseInfo *)info;

@end

typedef NS_ENUM(NSInteger, ALImageBrowserViewLongPressOperationType) {
    ALImageBrowserViewLongPressOperationTypeSave,
    ALImageBrowserViewLongPressOperationTypeDelete,
    ALImageBrowserViewLongPressOperationTypeShare
};

@interface ALImageBrowserViewController : UIViewController

@property (nonatomic, weak) id<ALImageBrowserViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSArray *longpressOperationArray;
@property (nonatomic, assign) NSInteger startIndex;

@end
