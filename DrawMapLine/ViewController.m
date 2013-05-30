//
//  ViewController.m
//  DrawMapLine
//
//  Created by Wingle Wong on 5/28/13.
//  Copyright (c) 2013 Wingle Wong. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () {
    UIImageView *imageView;//绘画层
    
    CGMutablePathRef pathRef;//手指画线的Path
    
    CLLocationCoordinate2D testLocation;//测试的位置(经纬度)
    
    CGPoint locationConverToImage;//存储转换测试位置的CGPoint
    BOOL isDrawing;

}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *array;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_map release];
    [_locationManager release];
    
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

#pragma mark - 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    //创建path
    
    pathRef=CGPathCreateMutable();

    CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
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
