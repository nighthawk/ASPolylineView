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
		self.backgroundColor  = [UIColor whiteColor];
		self.borderMultiplier = 2.0;
	}
	return self;
}

- (void)drawMapRect:(MKMapRect)mapRect
					zoomScale:(MKZoomScale)zoomScale
					inContext:(CGContextRef)context
{
	CGFloat baseWidth = self.lineWidth;
	
	// draw the border. it's slightly wider than the specified line width.
	[self drawLine:self.borderColor.CGColor
					 width:baseWidth * self.borderMultiplier
		 allowDashes:NO
		forZoomScale:zoomScale
			 inContext:context];

	// a white background.
	[self drawLine:self.backgroundColor.CGColor
					 width:baseWidth
		 allowDashes:NO
		forZoomScale:zoomScale
			 inContext:context];

	// draw the actual line.
	[self drawLine:self.strokeColor.CGColor
					 width:baseWidth
		 allowDashes:YES
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
	CGPathRelease(path);
}

#pragma mark - Private helpers

- (void)drawLine:(CGColorRef)color
					 width:(CGFloat)width
		 allowDashes:(BOOL)allowDashes
		forZoomScale:(MKZoomScale)zoomScale
			 inContext:(CGContextRef)context
{

	CGContextAddPath(context, self.path);
	
	// use the defaults which takes care of the dash pattern
	// and other things
	if (allowDashes) {
		[self applyStrokePropertiesToContext:context atZoomScale:zoomScale];
	} else {
		// some setting we still want to apply
		CGContextSetLineCap(context, self.lineCap);
		CGContextSetLineJoin(context, self.lineJoin);
		CGContextSetMiterLimit(context, self.miterLimit);
	}
	
	// now set the colour and width
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetLineWidth(context, width / zoomScale);
	
	CGContextStrokePath(context);
}

@end

