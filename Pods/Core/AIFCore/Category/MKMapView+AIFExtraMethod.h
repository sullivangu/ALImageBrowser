//
//  MKMapView+AIFExtraMethod.h
//  AIFCore
//
//  Created by Gin on 14-1-27.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <MapKit/MapKit.h>

#define MAP_LEVEL_EXCHANGE 3

@interface MKMapView (AIFExtraMethod)

@property (nonatomic, assign) NSUInteger zoomLevel;
@property (nonatomic, assign) NSUInteger baiduZoomLevel;

//zoom level
- (void)setZoomLevel:(NSUInteger)zoomLevel
            animated:(BOOL)animated;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

//distance
- (CLLocationDistance)distanceBetweenCGPointA:(CGPoint)a CGPointB:(CGPoint)b;
- (CLLocationDistance)distanceOfCurrentViewFromTopToEnd;

//annotations
- (BOOL)hasAnnotationsInView;
- (BOOL)isOutOfMapViewWithAnnotation:(id<MKAnnotation>)annotation;


@end
