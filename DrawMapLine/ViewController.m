//
//  ViewController.m
//  DrawMapLine
//
//  Created by Wingle Wong on 5/28/13.
//  Copyright (c) 2013 Wingle Wong. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define MAXIMUM_ZOOM 20

@interface ViewController () {
    UIImageView *imageView;//绘画层
    
    CGMutablePathRef pathRef;//手指画线的Path
    
    CLLocationCoordinate2D testLocation;//测试的位置(经纬度)
    
    CGPoint locationConverToImage;//存储转换测试位置的CGPoint
    
    NSInteger zoomLevel;
    BOOL isDrawing;

}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSMutableArray *polylines;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.map setDelegate:self];
    
    [self.locationManager startUpdatingLocation];
    self.map.showsUserLocation = YES;
    
    MKCoordinateSpan theSpan;
    
    theSpan.latitudeDelta=0.03;
    
    theSpan.longitudeDelta=0.03;
    
    MKCoordinateRegion theRegion={ {0.0, 0.0 }, { 0.0, 0.0 } };
    
    theRegion.center=self.locationManager.location.coordinate;
    
    theRegion.span=theSpan;
    
    [self.map setRegion:theRegion animated:YES];
    isDrawing = NO;
    
    //---
    MKPolyline *polyline = nil;
    CLLocationCoordinate2D points[2];
    points[0] = CLLocationCoordinate2DMake(0.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(0.0, 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(10.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(10.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(20.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(20.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(30.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(30.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(40.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(40.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(50.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(50.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(60.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(60.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(70.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(70.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(80.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(80.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-10.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-10.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-20.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-20.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-30.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-30.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-40.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-40.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-50.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-50.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-60.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-60.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-70.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-70.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-80.0 , -180.0);
    points[1] = CLLocationCoordinate2DMake(-80.0 , 180.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    // --longitude
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 0.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 0.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 10.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 10.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 20.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 20.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 30.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 30.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 40.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 40.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 50.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 50.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 60.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 60.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 70.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 70.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 80.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 80.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 90.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 90.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 100.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 100.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 110.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 110.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 120.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 120.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 130.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 130.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 140.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 140.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 150.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 150.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 160.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 160.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , 170.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , 170.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -10.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -10.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -20.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -20.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -30.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -30.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -40.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -40.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -50.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -50.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -60.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -60.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -70.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -70.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -80.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -80.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -90.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -90.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -100.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -100.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -110.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -110.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -120.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -120.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -130.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -130.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -140.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -140.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -150.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -150.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -160.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -160.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];
    
    memset(points, 0, 2*sizeof(CLLocationCoordinate2D));
    points[0] = CLLocationCoordinate2DMake(-90.0 , -170.0);
    points[1] = CLLocationCoordinate2DMake(90.0 , -170.0);
    polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.polylines addObject:polyline];

    
    [self.map addOverlays:self.polylines];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_map release];
    [_locationManager release];
    [_polylines release];
    
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMap:nil];
    [super viewDidUnload];
}

#pragma mark - get Methods
- (CLLocationManager *) locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10.0;
    }
    return _locationManager;
}

- (NSMutableArray *) array {
    if (_array == nil) {
        _array = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _array;
}

- (NSMutableArray *) polylines {
    if (_polylines == nil) {
        _polylines = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _polylines;
}

#pragma mark - utility methods
- (NSUInteger)zoomLevelForMapRect:(MKMapRect)mRect withMapViewSizeInPixels:(CGSize)viewSizeInPixels
{
    NSUInteger tmp_zoomLevel = MAXIMUM_ZOOM; // MAXIMUM_ZOOM is 20 with MapKit
    MKZoomScale zoomScale = mRect.size.width / viewSizeInPixels.width; //MKZoomScale is just a CGFloat typedef
    double zoomExponent = log2(zoomScale);
    tmp_zoomLevel = (NSUInteger)(MAXIMUM_ZOOM - ceil(zoomExponent));
    return tmp_zoomLevel;
}

#pragma mark - IBAction methods

- (IBAction)drawFunction:(id)sender {
    if (isDrawing) {
        return;
    }
    isDrawing = YES;
    imageView=[[[UIImageView alloc] initWithFrame:self.map.frame] autorelease];
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 5.0;
    imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(3, 3);
    imageView.layer.shadowOpacity = 0.7;
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:imageView];
    
    imageView.userInteractionEnabled=YES;

    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 90, 79, 133, 1.0);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor greenColor].CGColor);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
    
    //地理坐标转换成点
    testLocation.latitude=self.locationManager.location.coordinate.latitude;
    
    testLocation.longitude=self.locationManager.location.coordinate.longitude;
    
    locationConverToImage=[self.map convertCoordinate:testLocation toPointToView:imageView];
    
     NSLog(@"111 %f",locationConverToImage.x);
     NSLog(@"222 %f",locationConverToImage.y);
}

- (IBAction)cleanFunction:(id)sender {
    if (imageView && isDrawing) {
        isDrawing = NO;
        [imageView removeFromSuperview];//删除绘图层
        [self.array removeAllObjects];
        
        [self.map removeAnnotations:self.map.annotations];//删除大头针
        
        UIGraphicsEndImageContext();//删除画布
    }
    
}

#pragma mark - MapviewDelegate methods
- (MKAnnotationView*) mapView: (MKMapView*) mapView viewForAnnotation: (id<MKAnnotation>) annotation{
    
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    
    if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                     
                                     initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
    
    pinView.pinColor = MKPinAnnotationColorPurple;
    
    pinView.animatesDrop = YES;
    
    [mapView.userLocation setTitle:@"欧陆经典"];
    
    [mapView.userLocation setSubtitle:@"vsp"];
    
    return pinView;
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView *lineview=[[MKPolylineView alloc] initWithOverlay:overlay];
        lineview.strokeColor=[[UIColor blackColor] colorWithAlphaComponent:0.7];
        lineview.lineWidth=1.0;
//        lineview.fillColor= [UIColor redColor];
        return lineview;
        
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    zoomLevel = [self zoomLevelForMapRect:mapView.visibleMapRect withMapViewSizeInPixels:mapView.bounds.size];
    NSLog(@"%d",zoomLevel);
    return;
}

#pragma mark - 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!isDrawing) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    //创建path
    
    pathRef=CGPathCreateMutable();

    CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!isDrawing) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    CGPoint pastLocation = [touch previousLocationInView:imageView];
    
    //画线
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), location.x, location.y);
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        
    //更新Path
    
    CGPathAddLineToPoint(pathRef, NULL, location.x, location.y);
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!isDrawing) {
        return;
    }
    
    CGPathCloseSubpath(pathRef);
    
    if (CGPathContainsPoint(pathRef, NULL, locationConverToImage, NO)) {
        
        NSLog(@"point in path!");
        
        MKPointAnnotation *pointAnnotation = nil;
        
        pointAnnotation = [[MKPointAnnotation alloc] init];
        
        pointAnnotation.coordinate = self.locationManager.location.coordinate;
        
        pointAnnotation.title = @"大头针";
        
        [self.map addAnnotation:pointAnnotation];
        
    }
}




@end
