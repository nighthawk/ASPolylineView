//
//  ASPolylineView.h
//
//  Created by Adrian Schoenig on 21/02/13.
//
//

#import <MapKit/MapKit.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

@interface ASPolylineView : MKOverlayPathView

/* The color used for the wider border around the polyline.
 * Defaults to black.
 */
@property (nonatomic, strong) UIColor *borderColor;

/* The color used as the backdrop if there's a dash pattern.
 * Defaults to white.
 */
@property (nonatomic, strong) UIColor *backgroundColor;


/* The factor by which the border expands past the line.
 * 1.5 leads to a very thin line.
 * Defaults to 2.0.
 */
@property (nonatomic, assign) CGFloat borderMultiplier;

- (id)initWithPolyline:(MKPolyline *)polyline;

- (MKPolyline *)polyline;

@end

#endif
