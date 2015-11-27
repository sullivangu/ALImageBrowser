//
//  ViewController.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/25.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ViewController.h"
#import "ALImageBrowserViewController.h"
#import "ALImageBrowserBaseInfo.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Masonry.h"
#import "ALImageBrowserRemoteInfo.h"
#import "ALImageBrowserLocalInfo.h"
#import "ALImageBrowserPresentAnimator.h"
#import "ALImageBrowserDismissAnimator.h"
#import "XXTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ALImageBrowserViewControllerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *cellData;
@property (nonatomic, assign) CGRect presentAnimatorBeginRect;
@property (nonatomic, strong) UIImage *presentAnimatorBeginImage;
@property (nonatomic, assign) CGRect dismissAnimatorBeginRect;
@property (nonatomic, assign) CGRect dismissAnimatorEndRect;
@property (nonatomic, strong) UIImage *dismissAnimatorBeginImage;

@end

@implementation ViewController

#pragma lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"ViewController viewWillAppear");
}

#pragma getter/setter

- (NSArray *)cellData {
    if (!_cellData) {
        NSMutableArray *array = [@[]mutableCopy];
        ALImageBrowserRemoteInfo *info1 = [[ALImageBrowserRemoteInfo alloc] init];
        info1.url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D310/sign=07e7451cbe315c6043956deebdb1cbe6/f9dcd100baa1cd1195929b29bb12c8fcc3ce2d97.jpg"];
        ALImageBrowserRemoteInfo *info2 = [[ALImageBrowserRemoteInfo alloc] init];
        info2.url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D310/sign=b872e3b4808ba61edfeece2e713597cc/50da81cb39dbb6fd5b2100580b24ab18972b3751.jpg"];
        ALImageBrowserRemoteInfo *info3 = [[ALImageBrowserRemoteInfo alloc] init];
        info3.url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/w%3D310/sign=f167760a99504fc2a25fb604d5dde7f0/18d8bc3eb13533fa5cc2692caad3fd1f41345bb8.jpg"];
        ALImageBrowserRemoteInfo *info4 = [[ALImageBrowserRemoteInfo alloc] init];
        info4.url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D310/sign=6bb3018d48ed2e73fce9802db700a16d/42166d224f4a20a41bead2ce92529822730ed0c7.jpg"];
        [array addObject:info1];
        [array addObject:info2];
        [array addObject:info3];
        [array addObject:info4];
        _cellData = array;
    }
    return _cellData;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [_tableview setTableFooterView:view];
    }
    return _tableview;
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"llll"];
    if (!cell) {
        cell = [[XXTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"llll"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    ALImageBrowserRemoteInfo * info = (ALImageBrowserRemoteInfo *)self.cellData[indexPath.row];
    [cell.myImageView sd_setImageWithURL:info.url placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        info.isImageCached = YES;
    }];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    XXTableViewCell *cell = (XXTableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];
    self.presentAnimatorBeginImage = cell.myImageView.image ? cell.myImageView.image : [UIImage imageNamed:@"placeholder"];
    self.presentAnimatorBeginRect = [cell.myImageView convertRect:cell.myImageView.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    ALImageBrowserViewController *vc = [[ALImageBrowserViewController alloc] init];
    vc.delegate = self;
    vc.infoArray = self.cellData;
    vc.startIndex = indexPath.row;
    vc.longpressOperationArray = @[@(ALImageBrowserViewLongPressOperationTypeSave),@(ALImageBrowserViewLongPressOperationTypeDelete)];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self.navigationController presentViewController:vc animated:YES
                                          completion:^{}];
}

         
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 150;
 }

#pragma ALImageBrowserViewControllerDelegate
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDeleteImageAtInfo:(ALImageBrowserBaseInfo *)info{
    
}
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didQuitWithInfo:(ALImageBrowserBaseInfo *)info lastRect:(CGRect)rect{
    self.dismissAnimatorBeginRect = rect;
    self.dismissAnimatorBeginImage = info.image;
    UIImageView *imageView = ((XXTableViewCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cellData indexOfObject:info] inSection:0]]).myImageView;
    self.dismissAnimatorEndRect = [imageView convertRect:imageView.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    
    [imageBrowserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:[ALImageBrowserViewController class]]) {
        ALImageBrowserPresentAnimator *animator = [[ALImageBrowserPresentAnimator alloc] init];
        animator.beginRect = self.presentAnimatorBeginRect;
        animator.image = self.presentAnimatorBeginImage;
        return animator;
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[ALImageBrowserViewController class]]) {
        ALImageBrowserDismissAnimator *animator = [[ALImageBrowserDismissAnimator alloc] init];
        animator.beginRect = self.dismissAnimatorBeginRect;
        animator.image = self.dismissAnimatorBeginImage;
        animator.endRect = self.dismissAnimatorEndRect;
        return animator;
    }else{
        return nil;
    }
}
@end
