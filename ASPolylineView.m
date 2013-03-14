//
//  ASPolylineView.m
//
//  Created by Adrian Schoenig on 21/02/13.
//
//

#import "ASPolylineView.h"

@interface ASPolylineView ()

@property (nonatomic, strong) MKPolyline *polyline;

@end

@implementation ASPolylineView

- (id)initWithPolyline:(MKPolyline *)polyline
{
	self = [super initWithOverlay:polyline];
	if (self) {
		self.polyline    = polyline;
		
		// defaults
		self.borderColor      = [UIColor blackColor];
		self.borderMultiplier = 2.0;
	}
	return self;
}

- (void)dealloc
{
	CGPathRelease(self.path);
}

- (void)drawMapRect:(MKMapRect)mapRect
					zoomScale:(MKZoomScale)zoomScale
					inContext:(CGContextRef)context
{
	CGFloat baseWidth = self.lineWidth;
	
	// draw the border. it's slightly wider than the specified line width.
	[self drawLine:self.borderColor.CGColor
					 width:baseWidth * self.borderMultiplier
		forZoomScale:zoomScale
			 inContext:context];
	
	// draw the actual line.
	[self drawLine:self.strokeColor.CGColor
					 width:baseWidth
		forZoomScale:zoomScale
			 inContext:context];

	[super drawMapRect:mapRect zoomScale:zoomScale inContext:context];
}

- (void)createPath
{
	// turn the polyline into a path
	CGMutablePathRef path = CGPathCreateMutable();
	BOOL pathIsEmpty = YES;
	
	for (int i = 0; i < self.polyline.pointCount; i++) {
		CGPoint point = [self pointForMapPoint:self.polyline.points[i]];
		
		if (pathIsEmpty) {
			CGPathMoveToPoint(path, nil, point.x, point.y);
			pathIsEmpty = NO;
		} else {
			CGPathAddLineToPoint(path, nil, point.x, point.y);
		}
	}
	
	self.path = path;
}

#pragma mark - Private helpers

- (void)drawLine:(CGColorRef)color
					 width:(CGFloat)width
		forZoomScale:(MKZoomScale)zoomScale
			 inContext:(CGContextRef)context
{

	CGContextAddPath(context, self.path);
	
	// use the defaults which takes care of the dash pattern
	// and other things
	[self applyStrokePropertiesToContext:context atZoomScale:zoomScale];
	
	// now set the colour and width
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetLineWidth(context, width / zoomScale);
	
	CGContextStrokePath(context);
}

@end
