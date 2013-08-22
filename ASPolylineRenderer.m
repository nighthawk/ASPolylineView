//
//  ASPolylineRenderer.m
//
//  Created by Adrian Schoenig on 01/08/13.
//
//

#import "ASPolylineRenderer.h"

@interface ASPolylineRenderer ()

@property (nonatomic, strong) MKPolyline *polyline;

@property (nonatomic, assign) CGPathRef thePath;

@end

@implementation ASPolylineRenderer

- (id)initWithPolyline:(MKPolyline *)polyline
{
	self = [super initWithOverlay:polyline];
	if (self) {
		self.polyline    = polyline;
    [self createThePath];
		
		// defaults
		self.borderColor      = [UIColor blackColor];
		self.backgroundColor  = [UIColor whiteColor];
		self.borderMultiplier = 2.0;
	}
	return self;
}

- (void)dealloc
{
  CGPathRelease(self.thePath);
}

- (void)drawMapRect:(MKMapRect)mapRect
					zoomScale:(MKZoomScale)zoomScale
					inContext:(CGContextRef)context
{
	CGFloat baseWidth = self.lineWidth;

  // nice for debugging
//  CGContextSetRGBFillColor(context, (rand() % 255) / 255.0, 0, 0, 0.1);
//  CGContextFillRect(context, [self rectForMapRect:mapRect]);
  
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

}

- (void)createThePath
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

	self.thePath = path;
//	CGPathRelease(path);
}

#pragma mark - Private helpers

- (void)drawLine:(CGColorRef)color
					 width:(CGFloat)width
		 allowDashes:(BOOL)allowDashes
		forZoomScale:(MKZoomScale)zoomScale
			 inContext:(CGContextRef)context
{
	CGContextAddPath(context, self.thePath);
	
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
