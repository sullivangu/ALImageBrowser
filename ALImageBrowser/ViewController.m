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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ALImageBrowserViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *cellData;

@end

@implementation ViewController

#pragma lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topLayoutGuide);
    }];
}


#pragma getter/setter

- (NSArray *)cellData {
    if (!_cellData) {
        NSMutableArray *array = [@[]mutableCopy];
        ALImageBrowserRemoteInfo *info1 = [[ALImageBrowserRemoteInfo alloc] init];
        info1.url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/w%3D310/sign=07e7451cbe315c6043956deebdb1cbe6/f9dcd100baa1cd1195929b29bb12c8fcc3ce2d97.jpg"];
        info1.rect = CGRectMake(0, 0, 100, 100);
        ALImageBrowserRemoteInfo *info2 = [[ALImageBrowserRemoteInfo alloc] init];
        info2.url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D310/sign=b872e3b4808ba61edfeece2e713597cc/50da81cb39dbb6fd5b2100580b24ab18972b3751.jpg"];
        info2.rect = CGRectMake(0, 0, 100, 100);
        ALImageBrowserRemoteInfo *info3 = [[ALImageBrowserRemoteInfo alloc] init];
        info3.url = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/w%3D310/sign=f167760a99504fc2a25fb604d5dde7f0/18d8bc3eb13533fa5cc2692caad3fd1f41345bb8.jpg"];
        info3.rect = CGRectMake(0, 0, 100, 100);
        ALImageBrowserRemoteInfo *info4 = [[ALImageBrowserRemoteInfo alloc] init];
        info4.url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D310/sign=6bb3018d48ed2e73fce9802db700a16d/42166d224f4a20a41bead2ce92529822730ed0c7.jpg"];
        info4.rect = CGRectMake(0, 0, 100, 100);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"llll"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"llll"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        ALImageBrowserRemoteInfo * info = (ALImageBrowserRemoteInfo *)self.cellData[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:info.rect];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView setImageWithURL:info.url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [cell.contentView addSubview:imageView];
    }
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALImageBrowserViewController *vc = [[ALImageBrowserViewController alloc] init];
    vc.delegate = self;
    vc.infoArray = self.cellData;
    vc.startIndex = indexPath.row;
    vc.longpressOperationArray = @[@(ALImageBrowserViewLongPressOperationTypeSave),@(ALImageBrowserViewLongPressOperationTypeDelete)];
    [self presentViewController:vc animated:YES completion:^{}];
}

         
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 100;
 }

#pragma ALImageBrowserViewControllerDelegate
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didDeleteImageAtInfo:(ALImageBrowserBaseInfo *)info{
    
}
- (void)imageBrowserViewController:(ALImageBrowserViewController *)imageBrowserViewController didQuitWithInfo:(ALImageBrowserBaseInfo *)info lastRect:(CGRect)rect{
    
}

@end
