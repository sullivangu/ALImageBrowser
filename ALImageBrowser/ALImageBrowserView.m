//
//  ALImageBrowserView.m
//  ALImageBrowser
//
//  Created by Sullivan.Gu on 15/11/26.
//  Copyright © 2015年 Sullivan.Gu. All rights reserved.
//

#import "ALImageBrowserView.h"
#import "ALImageBrowserScrollView.h"
#import "Masonry.h"

@interface ALImageBrowserView () <UIScrollViewDelegate, ALImageBrowserScrollViewDelegate>

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, readonly) NSArray *infoArray;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIPageControl *pageControl;

@end

@implementation ALImageBrowserView

- (instancetype)init {
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (self = [super initWithFrame:CGRectMake(0, 0,self.screenWidth , self.screenHeight)]) {
        [self initUI];
    }
    return self;
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

- (void)reloadData {
    [self reloadDataAtIndex:0];
}

- (void)reloadDataAtIndex:(NSInteger)index {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake(self.infoArray.count * self.screenWidth, self.screenHeight);
    @autoreleasepool {
        for (int index = 0; index != self.infoArray.count; index++) {
            ALImageBrowserScrollView *scrollView = [[ALImageBrowserScrollView alloc] initWithImageInfo:self.infoArray[index] rect:CGRectMake(self.screenWidth * index, 0, self.screenWidth, self.screenHeight)];
            scrollView.imageBrowserDelegate = self;
            [self.scrollView addSubview:scrollView];
        }
    }
    self.scrollView.contentOffset = CGPointMake(index * self.screenWidth, 0);
    self.pageControl.numberOfPages = self.scrollView.contentSize.width/self.scrollView.frame.size.width;
    self.pageControl.currentPage = index;

}

#pragma private
- (void)initUI {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.scrollView];

    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
}

#pragma getter/setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.clipsToBounds = YES;
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.tintColor = [UIColor darkGrayColor];
    }
    return _pageControl;
}

- (NSArray *)infoArray {
    return [self infoArrayFromDelegate];
}

- (NSArray *)infoArrayFromDelegate {
    if ([self.delegate respondsToSelector:@selector(imageBrowserInfoArrayForImageBrowserView:)]) {
        return [self.delegate imageBrowserInfoArrayForImageBrowserView:self];
    }else {
        return nil;
    }
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.screenWidth;
}

#pragma ALImageBrowserScrollViewDelegate
- (void)imageBrowserScrollView:(ALImageBrowserScrollView *)imageBrowserScrollView longPressAtInfo:(ALImageBrowserBaseInfo *)info {
    if ([self.delegate respondsToSelector:@selector(imageBrowserView:longPressAtInfo:)]) {
        [self.delegate imageBrowserView:self longPressAtInfo:info];
    }
}

- (void)imageBrowserScrollView:(ALImageBrowserScrollView *)imageBrowserScrollView singleTapAtInfo:(ALImageBrowserBaseInfo *)info imageViewCurrentRect:(CGRect)rect{
    if ([self.delegate respondsToSelector:@selector(imageBrowserView:singleTapAtInfo:imageViewCurrentRect:)]) {
        [self.delegate imageBrowserView:self singleTapAtInfo:info imageViewCurrentRect:rect];
    }
}

@end
