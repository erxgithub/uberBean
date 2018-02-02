//
//  ViewController.m
//  UberBean
//
//  Created by Eric Gregor on 2018-02-02.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set up the map view
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    // Set up the location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = 10.0;
    self.locationManager.distanceFilter = 5.0;
    [self.locationManager startUpdatingLocation];
    
    [self.view addSubview:self.mapView];
    
    [self.locationManager requestWhenInUseAuthorization];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *latestLocation = [locations lastObject];
    [self.mapView setRegion:MKCoordinateRegionMake(latestLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error
{
    NSLog(@"%@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager requestLocation];
    }
}

@end
