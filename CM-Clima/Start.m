//
//  ViewController.m
//  CM-Clima
//
//  Created by 0x00 on 17/07/15.
//  Copyright (c) 2015 jesusnajar. All rights reserved.
//

#import "Start.h"
#import <GoogleMaps/GoogleMaps.h>

#define nUagLat 20.695306
#define nUagLng -103.418190


//google maps

@import GoogleMaps;

#define         nLocalizing     0
#define         nLocalized      1

//Localization
float                   mlatitude;
float                   mlongitude;
static int              iLocalizeState = nLocalizing;


NSMutableArray          *maPlacesTitle;
NSMutableArray          *maPlacesSnippet;
NSMutableArray          *maPlacesLat;
NSMutableArray          *maPlacesLng;


//google maps


@interface Start ()

@end

@implementation Start {

GMSMapView          *mapView;
GMSMarker           *markerLocation;
GMSCameraPosition   *camera;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //Location
    
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    [self initPlaces];
    
    mstTemp = [[NSString alloc] init];
    mstTempMax = [[NSString alloc] init];
    mstTempMin = [[NSString alloc] init];
    mstPressure = [[NSString alloc] init];
    mstHumidity = [[NSString alloc] init];
    [self initData];
    [self initController];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    NSDictionary *jsonResponse = [Declarations getWeather:nUagLat and:nUagLng];
    [Parser parseWeather:jsonResponse];
    print(NSLog(@"mstTemp = %@", mstTemp))
    print(NSLog(@"mstTempMax = %@", mstTempMax))
    print(NSLog(@"mstTempMin = %@", mstTempMin))
    print(NSLog(@"mstPressure = %@", mstPressure))
    print(NSLog(@"mstHumidity = %@", mstHumidity))
}

- (void)initController {
}


//mapas

//------------------------------------------------------------
- (void)initPlaces {
    maPlacesLat     = [[NSMutableArray alloc] initWithObjects: @"20.674815", @"20.710549",@"20.677541",@"20.682093", nil];
    maPlacesLng     = [[NSMutableArray alloc] initWithObjects: @"-103.387295", @"-103.412525",@"-103.432751",@"-103.462570", nil];
    maPlacesTitle   = [[NSMutableArray alloc] initWithObjects: @"Minerva", @"Andares", @"Galerías", @"Omnilife", nil];
    maPlacesSnippet = [[NSMutableArray alloc] initWithObjects: @"Av Vallarta", @"Zapopan",@"Fashion Mall", @"Chivas", nil];
    
    
}
/**********************************************************************************************/
#pragma mark - Maps methods
/**********************************************************************************************/
- (void) paintMap {
    [mapView removeFromSuperview];
    camera                      = [GMSCameraPosition cameraWithLatitude:mlatitude longitude:mlongitude zoom:14.0];
    mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame               = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    mapView.myLocationEnabled   = YES;
    
    [self.view addSubview:mapView];
    //[self.view bringSubviewToFront:self.lblName];
    //[self.view bringSubviewToFront:self.lblCountry];
}
//------------------------------------------------------------
- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    marker.title            = @"UAG";
    marker.snippet          = @"Clase de Maestría";
    marker.appearAnimation  = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    CLLocationCoordinate2D position;
    NSLog(@"maPlacesTitle.count %d", (int)maPlacesTitle.count);
    for (int i = 0; i<maPlacesTitle.count; i++)
    {
        CGFloat lat                     = (CGFloat)[maPlacesLat[i] floatValue];
        CGFloat lng                     = (CGFloat)[maPlacesLng[i] floatValue];
        NSLog(@"Marker lat %f, long %f", lat, lng);
        position                        = CLLocationCoordinate2DMake(lat, lng);
        markerLocation                  = [GMSMarker markerWithPosition:position];
        markerLocation.icon             = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        markerLocation.title            = maPlacesTitle[i];
        markerLocation.snippet          = maPlacesSnippet[i];
        markerLocation.appearAnimation  = kGMSMarkerAnimationPop;
        markerLocation.map              = mapView;
    }
}
/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
            //self.lblCountry.text = country;
            //self.lblName.text = addressName;
            //self.lblName.adjustsFontSizeToFitWidth = YES;
        }
        
        mlatitude = self.locationManager.location.coordinate.latitude;
        mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", mlatitude);
        NSLog(@"mlongitude = %f", mlongitude);
        if (iLocalizeState == nLocalizing) {
            [self paintMap];
            [self paintMarker];
            iLocalizeState = nLocalized;
        }
    }];
    
}



//end mapas



- (IBAction)btnClima:(id*)sender {
    
    self.lblTemp.text       = mstTemp;
    self.lblMax.text        = mstTempMax;
    self.lblMin.text        = mstTempMin;
    self.lblPressure.text   = mstPressure;
    self.lblHumidity.text   = mstHumidity;

}
@end
