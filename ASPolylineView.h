//
//  ASPolylineView.h
//
//  Created by Adrian Schoenig on 21/02/13.
//
//

#import <MapKit/MapKit.h>
#import <Availability.h>

#import "ASPolylineRenderer.h" // Not really needed, but addresses an issue with Carthage

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_DEPRECATED_IOS(2_0, 7_0, "Use ASPolylineRenderer instead")
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

NS_ASSUME_NONNULL_END

