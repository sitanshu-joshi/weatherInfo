//
//  MyCityViewController.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MyCityViewController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate> {
    NSArray *arrayOfCityList;
    NSString *strCityID;
    NSString *strCityName;
    
    NSString *device_lat;
    NSString *device_lon;
}

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextField *txfForCity;
@property (weak, nonatomic) IBOutlet UIView *viewForCityInfo;
@property (weak, nonatomic) IBOutlet UITextView *txtForCityInfo;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;

@property (weak, nonatomic) IBOutlet UIImageView *imgForWeatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblForCityName;
@property (weak, nonatomic) IBOutlet UILabel *lblForCoord;


- (IBAction)btnFindAction:(id)sender;

- (IBAction)btnGetGeoLocation:(id)sender;

- (IBAction)btnMoreInfoEvent:(id)sender;

@end
