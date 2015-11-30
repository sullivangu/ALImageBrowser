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
#import "XXTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ALImageBrowserViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellData;
@property (nonatomic, strong) ALImageBrowserAnimatorInfo *presentAnimatorInfo;
@property (nonatomic, strong) NSMutableArray *imageBrowserInfoArray;

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

#pragma getter/setter

- (NSArray *)cellData {
    if (!_cellData) {
        NSMutableArray *array = [@[]mutableCopy];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D310/sign=07e7451cbe315c6043956deebdb1cbe6/f9dcd100baa1cd1195929b29bb12c8fcc3ce2d97.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D310/sign=b872e3b4808ba61edfeece2e713597cc/50da81cb39dbb6fd5b2100580b24ab18972b3751.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/w%3D310/sign=f167760a99504fc2a25fb604d5dde7f0/18d8bc3eb13533fa5cc2692caad3fd1f41345bb8.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D310/sign=6bb3018d48ed2e73fce9802db700a16d/42166d224f4a20a41bead2ce92529822730ed0c7.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://www.kubeijie.com/data/files/mall/magazine/201307230927507038.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://www.kubeijie.com/data/files/mall/magazine/201307230927556891.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://www.kubeijie.com/data/files/mall/magazine/201307230928076329.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://www.kubeijie.com/data/files/mall/magazine/201307230928118265.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];

        _cellData = [array mutableCopy];
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
    NSMutableDictionary * dict = (NSMutableDictionary *)self.cellData[indexPath.row];
    [cell.myImageView sd_setImageWithURL:dict[@"url"] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            dict[@"isCached"] = @YES;
            dict[@"downloadedImage"] = image;
        }
    }];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    XXTableViewCell *cell = (XXTableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];
    //present动画数据
    ALImageBrowserAnimatorInfo *animatorInfo = [[ALImageBrowserAnimatorInfo alloc] init];
    animatorInfo.beginRect = [cell.myImageView convertRect:cell.myImageView.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    animatorInfo.image = cell.myImageView.image ? cell.myImageView.image : [UIImage imageNamed:@"placeholder"];
    self.presentAnimatorInfo = animatorInfo;
    //
    ALImageBrowserViewController *vc = [[ALImageBrowserViewController alloc] initWithPresentType:ALImageBrowserViewControllerPresentTypeCustomed];
    vc.delegate = self;
    //显示的第一张图片
    vc.startIndex = indexPath.row;
    vc.longpressOperationArray = @[@(ALImageBrowserViewLongPressOperationTypeSave),@(ALImageBrowserViewLongPressOperationTypeDelete)];
    [self.navigationController presentViewController:vc animated:YES
                                          completion:^{}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 150;
}

#pragma ALImageBrowserViewControllerDelegate
- (NSArray *)infoArrayForImageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController {
    //图片数据
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.cellData.count];
    @autoreleasepool {
        for (NSDictionary *dict in self.cellData) {
            if ([dict[@"isCached"] boolValue]) {
                ALImageBrowserLocalInfo *info = [[ALImageBrowserLocalInfo alloc] init];
                info.localImage = dict[@"downloadedImage"];
                info.state = ALImageViewInfoStateImageCached;
                [array addObject:info];
            }else {
                ALImageBrowserRemoteInfo *info = [[ALImageBrowserRemoteInfo alloc] init];
                info.url = dict[@"url"];
                info.placeHolderImage = [UIImage imageNamed:@"placeholder"];
                info.state = ALImageViewInfoStateImageNotCached;
                [array addObject:info];
            }
        }
    }
    self.imageBrowserInfoArray = array;
    return self.imageBrowserInfoArray;
}

- (ALImageBrowserAnimatorInfo *)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didPresentWithInfo:(ALImageBrowserBaseInfo *)info{
    return self.presentAnimatorInfo;
}
- (ALImageBrowserAnimatorInfo *)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDismissWithInfo:(ALImageBrowserBaseInfo *)info{
    ALImageBrowserAnimatorInfo *animatorInfo = [[ALImageBrowserAnimatorInfo alloc] init];
    UIImageView *imageView = ((XXTableViewCell *)[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.imageBrowserInfoArray indexOfObject:info] inSection:0]]).myImageView;
    animatorInfo.image = imageView.image;
    animatorInfo.endRect = [imageView convertRect:imageView.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    return animatorInfo;
}

- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDeleteImageAtInfo:(ALImageBrowserBaseInfo *)info {
    NSInteger index = [self.imageBrowserInfoArray indexOfObject:info];
    [self.imageBrowserInfoArray removeObjectAtIndex:index];
    [self.cellData removeObjectAtIndex:index];
    [self.tableview reloadData];
    [imageBrowserViewController reloadDataAtIndex:index];
}

- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didShareImageAtInfo:(ALImageBrowserBaseInfo *)info {
    
}


@end
