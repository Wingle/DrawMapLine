//
//  ViewController.h
//  DrawMapLine
//
//  Created by Wingle Wong on 5/28/13.
//  Copyright (c) 2013 Wingle Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (retain, nonatomic) IBOutlet MKMapView *map;
- (IBAction)drawFunction:(id)sender;
- (IBAction)cleanFunction:(id)sender;

@end
