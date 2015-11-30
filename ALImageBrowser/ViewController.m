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
@property (nonatomic, strong) NSArray *cellData;
@property (nonatomic, strong) ALImageBrowserAnimatorInfo *presentAnimatorInfo;
@property (nonatomic, strong) NSArray *imageBrowserInfoArray;

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
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D310/sign=07e7451cbe315c6043956deebdb1cbe6/f9dcd100baa1cd1195929b29bb12c8fcc3ce2d97.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D310/sign=b872e3b4808ba61edfeece2e713597cc/50da81cb39dbb6fd5b2100580b24ab18972b3751.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/w%3D310/sign=f167760a99504fc2a25fb604d5dde7f0/18d8bc3eb13533fa5cc2692caad3fd1f41345bb8.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D310/sign=6bb3018d48ed2e73fce9802db700a16d/42166d224f4a20a41bead2ce92529822730ed0c7.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://image.baidu.com/search/detail?ct=503316480&z=&tn=baiduimagedetail&ipn=d&word=%E5%AE%A0%E7%89%A9%E8%90%8C%E5%9B%BE&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=-1&cs=4103130088,2567396922&os=2449609077,1374280617&simid=4187926937,800733308&pn=2&rn=1&di=91562822670&ln=1000&fr=&fmq=1448621736184_R&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=&istype=0&ist=&jit=&bdtype=0&gsm=0&objurl=http%3A%2F%2Fimages.99pet.com%2FInfoImages%2Fwm600_450%2F1d770941f8d44c6e85ba4c0eb736ef69.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://img2.imgtn.bdimg.com/it/u=1765676471,761941527&fm=21&gp=0.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/u=933749529,2597643398&fm=21&gp=0.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
        [array addObject:[@{@"url":[NSURL URLWithString:@"http://img0.imgtn.bdimg.com/it/u=3845573724,3286232818&fm=21&gp=0.jpg"],@"isCached":@NO,@"downloadedImage": [[UIImage alloc] init]} mutableCopy]];
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
    vc.infoArray = self.imageBrowserInfoArray;
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
    
}


@end
