//
//  ASViewController.m
//  PolylineExample
//
//  Created by Adrian Schoenig on 2/05/13.
//  Copyright (c) 2013 Adrian Schoenig. All rights reserved.
//

#import "ASViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "ASPolylineView.h"

@implementation ASViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	CLLocationCoordinate2D coordinates[5] = {
		CLLocationCoordinate2DMake(-33.962725,151.241913),
		CLLocationCoordinate2DMake(-33.937663,151.178741),
		CLLocationCoordinate2DMake(-33.895497,151.148529),
		CLLocationCoordinate2DMake(-33.892077,151.218567),
		CLLocationCoordinate2DMake(-33.962725,151.241913),
	};
	
	MKPolyline *myLine = [MKPolyline polylineWithCoordinates:coordinates count:5];
	[self.mapView addOverlay:myLine];
	[self.mapView setVisibleMapRect:[self mapRectForCoordinates:coordinates count:5]];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
	if ([overlay isKindOfClass:[MKPolyline class]]) {
		ASPolylineView *polylineView = [[ASPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
		polylineView.strokeColor  = [UIColor yellowColor];
		polylineView.lineWidth		= 4.0f;
    polylineView.lineJoin			= kCGLineJoinBevel;
    polylineView.lineCap			= kCGLineCapRound;
		return polylineView;
	} else {
		return nil;
	}
}

- (MKMapRect)mapRectForCoordinates:(CLLocationCoordinate2D *)coordinates
														 count:(NSUInteger)count
{
  MKMapRect mapRect = MKMapRectNull;
	for (int i = 0; i < count; i++) {
    MKMapPoint mapPoint = MKMapPointForCoordinate(coordinates[i]);
    MKMapRect newRect = MKMapRectMake(mapPoint.x, mapPoint.y, 1.0, 1.0);
    mapRect = MKMapRectUnion(mapRect, newRect);
  }
  return mapRect;
}


@end
