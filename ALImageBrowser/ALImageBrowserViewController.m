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
#import "ALImageBrowserDismissAnimator.h"

@interface ALImageBrowserViewController () <ALImageBrowserViewDelegate>

@property (nonatomic, strong) ALImageBrowserView *imageBrowserView;

@end

@implementation ALImageBrowserViewController

- (void)dealloc {
    NSLog(@"ALImageBrowserViewController dealloc");
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

#pragma ALImageBrowserViewDelegate
- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView longPressAtInfo:(ALImageBrowserBaseInfo *)info {
    [self popMenuWithInfo:info];
}

- (void)imageBrowserView:(ALImageBrowserView *)imageBrowserView singleTapAtInfo:(ALImageBrowserBaseInfo *)info imageViewCurrentRect:(CGRect)rect{
    if ([self.delegate respondsToSelector:@selector(imageBrowserViewController:didQuitWithInfo:lastRect:)]) {
        [self.delegate imageBrowserViewController:self didQuitWithInfo:info lastRect:rect];
    }
   // [self dismissViewControllerAnimated:YES completion:^{}];
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
 

#pragma setter/getter
- (ALImageBrowserView *)imageBrowserView {
    if (!_imageBrowserView) {
        _imageBrowserView = [[ALImageBrowserView alloc] init];
    }
    return _imageBrowserView;
}


@end
