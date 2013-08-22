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
#import "ASPolylineRenderer.h"

@implementation ASViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	CLLocationCoordinate2D coordinates[6] = {
		CLLocationCoordinate2DMake(-33.932725,151.222),
		CLLocationCoordinate2DMake(-33.9125,151.222), // midway
		CLLocationCoordinate2DMake(-33.892077,151.222),
		CLLocationCoordinate2DMake(-33.937663,151.178),
		CLLocationCoordinate2DMake(-33.912563,151.178), // midway
		CLLocationCoordinate2DMake(-33.895497,151.178),
	};
	
	// draw as two separate overlays to draw a bridge
	CLLocationCoordinate2D first[4] = {
		coordinates[1],
		coordinates[2],
		coordinates[3],
		coordinates[4],
	};

	CLLocationCoordinate2D second[4] = {
		coordinates[4],
		coordinates[5],
		coordinates[0],
		coordinates[1],
	};

	[self.mapView addOverlay:[MKPolyline polylineWithCoordinates:first count:4]];
	[self.mapView addOverlay:[MKPolyline polylineWithCoordinates:second count:4]];
	
	// zoom to all
	[self.mapView setVisibleMapRect:[self mapRectForCoordinates:coordinates count:6]];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
	if ([overlay isKindOfClass:[MKPolyline class]]) {
		ASPolylineView *polylineView = [[ASPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
		polylineView.strokeColor  = [UIColor yellowColor];
		polylineView.lineWidth		= 8.0f;
    polylineView.lineJoin			= kCGLineJoinRound;
    polylineView.lineCap			= kCGLineCapButt;
		return polylineView;
	} else {
		return nil;
	}
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
	if ([overlay isKindOfClass:[MKPolyline class]]) {
		ASPolylineRenderer *polylineRenderer = [[ASPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
		polylineRenderer.strokeColor  = [UIColor yellowColor];
		polylineRenderer.lineWidth		= 8.0f;
    polylineRenderer.lineJoin			= kCGLineJoinRound;
    polylineRenderer.lineCap			= kCGLineCapButt;
		return polylineRenderer;
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
