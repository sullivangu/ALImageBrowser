//
//  ALImageBrowserViewController.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserViewController.h"
#import "ALImageBrowserView.h"
#import "PSTAlertController.h"
#import "MBProgressHUD+ALShowAlert.h"
#import "Masonry.h"
#import "ALImageBrowserPresentAnimator.h"
#import "ALImageBrowserDismissAnimator.h"

@interface ALImageBrowserViewController () <ALImageBrowserViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) ALImageBrowserView *imageBrowserView;
@property (nonatomic, assign) ALImageBrowserViewControllerPresentType presentType;
@property (nonatomic, assign) CGRect dismissAnimatorBeginRect;
@property (nonatomic, strong) ALImageBrowserBaseInfo *dismissBeginImageInfo;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation ALImageBrowserViewController

- (instancetype)initWithPresentType:(ALImageBrowserViewControllerPresentType)presentType {
    if (self = [super init]) {
        self.presentType = presentType;
        if (self.presentType == ALImageBrowserViewControllerPresentTypeCustomed) {
            self.modalPresentationStyle = UIModalPresentationCustom;
            self.transitioningDelegate = self;
        }
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        @throw [[NSException alloc] initWithName:@"wrong init method" reason:@"use initWithPresentType" userInfo:nil];
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageBrowserView];
    self.imageBrowserView.delegate = self;
    [self.imageBrowserView reloadDataAtIndex:self.startIndex];
    [self.imageBrowserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma public method 
- (void)reloadData {
    [self reloadDataAtIndex:0];
}

- (void)reloadDataAtIndex:(NSInteger)index {
    self.infoArray = [self fetchInfoArray];
    if (self.infoArray.count == 0) {
        ALImageBrowserBaseInfo *info = [[ALImageBrowserBaseInfo alloc] init];
        info.state = ALImageViewInfoStateError;
        [self imageBrowserView:self.imageBrowserView singleTapAtInfo:info imageViewCurrentRect:CGRectZero];
        return;
    }
    if (index >= self.infoArray.count) {
        [self.imageBrowserView reloadDataAtIndex:self.infoArray.count - 1];
    }else{
        [self.imageBrowserView reloadDataAtIndex:index];
    }
    
}

#pragma ALImageBrowserViewDelegate
- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView longPressAtInfo:(ALImageBrowserBaseInfo *)info {
    [self popMenuWithInfo:info];
}

- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView singleTapAtInfo:(ALImageBrowserBaseInfo *)info imageViewCurrentRect:(CGRect)rect{
    self.dismissAnimatorBeginRect = rect;
    self.dismissBeginImageInfo = info;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)imageBrowserInfoArrayForImageBrowserView:(ALImageBrowserView *)imageBrowserView {
    return self.infoArray;
}

#pragma menu
- (void)popMenuWithInfo:(ALImageBrowserBaseInfo *)info {
    PSTAlertController *alert = [PSTAlertController actionSheetWithTitle:nil];
    __weak typeof(self) weakself = self;
    [self.longpressOperationArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch ([((NSNumber *)obj) intValue]) {
            case ALImageBrowserViewLongPressOperationTypeSave: {
                [alert addAction:[PSTAlertAction  actionWithTitle:@"保存图片" style:PSTAlertActionStyleDefault handler:^(PSTAlertAction *action) {
                    if (info.image) {
                        [weakself saveImageToAsset:info.image];
                    }
                }]];
            }
                break;
            case ALImageBrowserViewLongPressOperationTypeDelete: {
                [alert addAction:[PSTAlertAction  actionWithTitle:@"删除" style:PSTAlertActionStyleDefault handler:^(PSTAlertAction *action) {
                    if ([weakself.delegate respondsToSelector:@selector(imageBrowserViewController:didDeleteImageAtInfo:)]) {
                        [weakself.delegate imageBrowserViewController:weakself didDeleteImageAtInfo:info];
                    }
                }]];
            }
                break;
            default:
                break;
        }
    }];
    [alert addAction:[PSTAlertAction actionWithTitle:@"取消" style:PSTAlertActionStyleCancel handler:nil]];
    [alert showWithSender:nil controller:self animated:YES completion:nil];
}


- (void)saveImageToAsset:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)didSaveImageToAsset {
    [MBProgressHUD showAlertWithString:@"保存成功" holdingSeconds:0.5 inView:self.view allowUserInteract:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = error? @"保存失败" : @"保存成功";
    [MBProgressHUD showAlertWithString:msg holdingSeconds:0.5 inView:self.view allowUserInteract:YES];
}

#pragma UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:[ALImageBrowserViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(imageBrowserViewController:didPresentWithInfo:)]) {
            ALImageBrowserAnimatorInfo *info = [self.delegate imageBrowserViewController:self didPresentWithInfo:nil];
            if (info) {
                ALImageBrowserPresentAnimator *animator = [[ALImageBrowserPresentAnimator alloc] init];
                animator.beginRect = info.beginRect;
                animator.image = info.image;
                return animator;
            }
        }
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[ALImageBrowserViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(imageBrowserViewController:didDismissWithInfo:)]) {
            if (self.dismissBeginImageInfo.state == ALImageViewInfoStateImageCached) {
                ALImageBrowserAnimatorInfo *info = [self.delegate imageBrowserViewController:self didDismissWithInfo:self.dismissBeginImageInfo];
                ALImageBrowserDismissAnimator *animator = [[ALImageBrowserDismissAnimator alloc] init];
                animator.beginRect = self.dismissAnimatorBeginRect;
                animator.image = info.image;
                animator.endRect = info.endRect;
                return animator;
            }else {
                ALImageBrowserDismissAnimator *animator = [[ALImageBrowserDismissAnimator alloc] init];
                animator.beginRect = CGRectZero;
                animator.image = nil;
                animator.endRect = CGRectZero;
                return animator;
            }
        }
    }
    return nil;
}

#pragma private
- (NSArray *)fetchInfoArray {
    if ([self.delegate respondsToSelector:@selector(infoArrayForImageBrowserViewController:)]) {
        return [self.delegate infoArrayForImageBrowserViewController:self];
    }else{
        return nil;
    }
}
 

#pragma setter/getter
- (ALImageBrowserView *)imageBrowserView {
    if (!_imageBrowserView) {
        _imageBrowserView = [[ALImageBrowserView alloc] init];
    }
    return _imageBrowserView;
}

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [self fetchInfoArray];
    }
    return _infoArray;
}

@end
