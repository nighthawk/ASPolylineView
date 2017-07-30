//
//  ASPolylineRenderer.h
//
//  Created by Adrian Schoenig on 01/08/13.
//
//

#import <MapKit/MapKit.h>

#if TARGET_OS_IPHONE
#define ASColor UIColor
#else
#define ASColor NSColor
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ASPolylineRenderer : MKOverlayPathRenderer

/* The color used for the wider border around the polyline.
 * Defaults to black.
 */
@property (nonatomic, strong) ASColor *borderColor;

/* The color used as the backdrop if there's a dash pattern.
 * Defaults to white.
 */
@property (nonatomic, strong) ASColor *backgroundColor;


/* The factor by which the border expands past the line.
 * 1.5 leads to a very thin line.
 * Defaults to 2.0.
 */
@property (nonatomic, assign) CGFloat borderMultiplier;

- (id)initWithPolyline:(MKPolyline *)polyline;

- (MKPolyline *)polyline;

@end

NS_ASSUME_NONNULL_END
