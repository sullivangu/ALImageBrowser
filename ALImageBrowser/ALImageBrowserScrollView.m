//
//  ALImageBrowserScrollView.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/25.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserScrollView.h"
#import "ALImageBrowserLocalInfo.h"
#import "ALImageBrowserRemoteInfo.h"
#import "Masonry.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface ALImageBrowserScrollView () <UIScrollViewDelegate>


@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, strong) ALImageBrowserBaseInfo *info;
@property (nonatomic, strong) UIScrollView *scrollView;

//缺省图片
@property (nonatomic, strong) UIImageView *placeholderImageView;
//最后显示imageview
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ALImageBrowserScrollView


#pragma lifecycle
- (instancetype)initWithImageInfo:(ALImageBrowserBaseInfo *)info rect:(CGRect)rect {
    if (self = [super initWithFrame:rect]) {
        self.info = info;
        [self initUI];
    }
    return self;
}

- (void)dealloc {
    self.imageView = nil;
    self.scrollView = nil;
    NSLog(@"ALImageBrowserScrollView dealloc");
}

#pragma private method
- (void)initUI {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.scrollView];
    
    if (self.info.type == ALImageViewInfoTypeLocalImage) {
        ALImageBrowserLocalInfo *localInfo = (ALImageBrowserLocalInfo *)self.info;
        self.imageView = [[UIImageView alloc] initWithImage:localInfo.localImage];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:self.imageView];
        self.scrollView.contentSize = self.imageView.bounds.size;
        [self configGestures];
        [self setZoomScale];
    }else {
        ALImageBrowserRemoteInfo *remoteInfo = (ALImageBrowserRemoteInfo *)self.info;
        if (remoteInfo.placeHolderImage) {
            self.placeholderImageView = [[UIImageView alloc] initWithImage:remoteInfo.placeHolderImage];
             [self addSubview:self.placeholderImageView];
            [self.placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        }else{
            self.placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
             [self addSubview:self.placeholderImageView];
            [self.placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(40,40));
            }];
        }
        self.placeholderImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.placeholderImageView.userInteractionEnabled = YES;
       
        typeof(self) __weak weakself = self;
        [self.placeholderImageView setImageWithURL:remoteInfo.url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            weakself.placeholderImageView.hidden = YES;
            remoteInfo.downloadedImage = image;
            weakself.imageView = [[UIImageView alloc] initWithImage:image];
            weakself.imageView.contentMode = UIViewContentModeScaleAspectFit;
            weakself.imageView.userInteractionEnabled = YES;
            [weakself.scrollView addSubview:weakself.imageView];
            weakself.scrollView.contentSize = weakself.imageView.bounds.size;
            [weakself configGestures];
            [weakself setZoomScale];
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

    }
}

- (void)configGestures {
    UIGestureRecognizer *touchOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.imageView addGestureRecognizer:touchOnImage];
    UIGestureRecognizer *longPressOnImage = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPressOnImage];
    UITapGestureRecognizer *doubleClickOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickOnImageView:)];
    doubleClickOnImage.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:doubleClickOnImage];
    [touchOnImage requireGestureRecognizerToFail:doubleClickOnImage];
    
    UIGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:touch];
    UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickOnImageView:)];
    doubleClick.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleClick];
    [touch requireGestureRecognizerToFail:doubleClick];
}

- (void)longPress:(UILongPressGestureRecognizer*)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if ([self.imageBrowserDelegate respondsToSelector:@selector(imageBrowserScrollView:longPressAtInfo:)]) {
            [self.imageBrowserDelegate imageBrowserScrollView:self longPressAtInfo:self.info];
        }
    }
}

- (void)singleTap:(UITapGestureRecognizer*)recognizer {
    if ([self.imageBrowserDelegate respondsToSelector:@selector(imageBrowserScrollView:singleTapAtInfo:imageViewCurrentRect:)]) {
        [self.imageBrowserDelegate imageBrowserScrollView:self singleTapAtInfo:self.info imageViewCurrentRect:[self.imageView convertRect:self.imageView.bounds toView:self]];
    }
}


#pragma UIScrollViewDelegate

- (void)doubleClickOnImageView:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize imageViewSize = self.imageView.frame.size;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGFloat verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0;
    CGFloat horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0;
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [self setZoomScale];
}

- (void)setZoomScale {
    CGFloat widthScale = self.scrollView.bounds.size.width / self.imageView.bounds.size.width;
    CGFloat heightScale = self.scrollView.bounds.size.height / self.imageView.bounds.size.height;
    self.scrollView.minimumZoomScale = widthScale < heightScale ? widthScale : heightScale;
    self.scrollView.maximumZoomScale = widthScale > heightScale ? widthScale : heightScale;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
}

#pragma getter/setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc ] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.contentSize = self.imageView.bounds.size;
    }
    return _scrollView;
}

#pragma illeagal init
- (instancetype)init {
    @throw [[NSException alloc] initWithName:@"wrong init method" reason:@"use initWithFrame" userInfo:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        @throw [[NSException alloc] initWithName:@"wrong init method" reason:@"use initWithFrame" userInfo:nil];
    }
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        @throw [[NSException alloc] initWithName:@"wrong init method" reason:@"use initWithFrame" userInfo:nil];
    }
    return nil;
}

@end
