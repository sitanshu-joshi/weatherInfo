//
//  MyCityViewController.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "MyCityViewController.h"

@interface MyCityViewController ()

@end

@implementation MyCityViewController

@synthesize txfForCity,txtForCityInfo;
@synthesize activity;
@synthesize viewForCityInfo,lblForCityName,imgForWeatherIcon,lblForCoord,lblTemperature;
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [viewForCityInfo setHidden:YES];
    // Initilaize Location Manager Obj
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    // Only For IOS 8
    [locationManager requestAlwaysAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kSegue_City_To_Forecast]) {
        ForecastViewController *forecastViewController = segue.destinationViewController;
        forecastViewController.arrayOfCity = arrayOfCityList;
        forecastViewController.cityName = strCityName;
    }
}

#pragma mark Location Delegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@",error.description);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [locationManager stopUpdatingLocation];
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    
    device_lat = @(lat).stringValue;
    device_lon = @(lon).stringValue;
    
    [self getCityInfoFromGeoLocation];
}

#pragma mark Get Request
/*
 It will execute the Async Req to get Weather Info from Geo Location.
 If response mapped then it will get with Objects from response.
 */
-(void)getCityInfoFromGeoLocation {
    
    NSString *strForCity = [NSString stringWithFormat:kGeo_Weather,device_lat,device_lon];
    
    [[AppDelegate appDelegate].rkomForGetCity getObjectsAtPath:strForCity parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [activity stopAnimating];
        [viewForCityInfo setHidden:NO];
        // Handled with articleDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        NSLog(@"%ld",operation.HTTPRequestOperation.response.statusCode);
        MyCity *city  = [mappingResult.array objectAtIndex:0];
        strCityID = city.ids;
        [self showWeatherInfoAtUI:city];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [activity stopAnimating];
        [viewForCityInfo setHidden:NO];
        // Transport error or server error handled by errorDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        RKLogError(@"Operation failed with error: %@", error);
    }];
}

/*
 It will execute the Async Req to get Weather Info from given city name by user. User will be be responsible to get data from suggested city.
 If response mapped then it will get with Objects from response.
 */
-(void)getCityInfoFromSearch:(NSString *)strCity {
    
    NSString *strForCity = [NSString stringWithFormat:kCity_Weather,strCity];
    
    [[AppDelegate appDelegate].rkomForGetCity getObjectsAtPath:strForCity parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [activity stopAnimating];
        [viewForCityInfo setHidden:NO];
        // Handled with articleDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        NSLog(@"%ld",operation.HTTPRequestOperation.response.statusCode);
        MyCity *city  = [mappingResult.array objectAtIndex:0];
        strCityID = city.ids;
        [self showWeatherInfoAtUI:city];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [activity stopAnimating];
        [viewForCityInfo setHidden:NO];
        // Transport error or server error handled by errorDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        RKLogError(@"Operation failed with error: %@", error);
    }];
}
/*
 By Using Id of Searched city It will execute more request to get data of Forecast weather info.
 Parameter cityId, Cnt & AppID.
 It will be given 14 days.
 */
-(void)getCityList {
    NSString *strForCity = [NSString stringWithFormat:kCity_Forecast_Weather,strCityID,kAPP_ID];
    
    [activity startAnimating];
    [[AppDelegate appDelegate].rkomForGetForecastCity getObjectsAtPath:strForCity parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // Handled with articleDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        ForecastList *forecast  = [mappingResult.array objectAtIndex:0];
        NSLog(@"%lu",[[[forecast listOfCity] allObjects] count]);
        [self sortingArrayBasedOnDate:[[forecast listOfCity] allObjects]];
        NSLog(@"%ld",operation.HTTPRequestOperation.response.statusCode);
        
        [self performSelector:@selector(redirectToListView) withObject:nil afterDelay:1.0];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // Transport error or server error handled by errorDescriptor
        [activity stopAnimating];
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        RKLogError(@"Operation failed with error: %@", error);
    }];
}

/*
 It will show at UI in UIView and Label/TextView.
 What searched by the user will get the data from weatherinfo and shown here.
 */
-(void)showWeatherInfoAtUI:(MyCity *)myCity {
    Weather *w = [[myCity.weather allObjects] firstObject];
    
    NSDictionary *dictForClouds = (NSDictionary *)myCity.clouds;
    NSDictionary *dictForWind = (NSDictionary *)myCity.wind;
    NSDictionary *dictForSys = (NSDictionary *)myCity.sys;
    NSDictionary *dictForCoord = (NSDictionary *)myCity.coord;
    NSDictionary *dictForMain = (NSDictionary *)myCity.main;
    
    strCityName = [NSString stringWithFormat:@"%@, %@",myCity.name,[dictForSys valueForKey:@"country"]];
    lblForCityName.text = [NSString stringWithFormat:@"%@, %@ : %@",myCity.name,[dictForSys valueForKey:@"country"],w.desc];
    
    lblForCoord.text = [NSString stringWithFormat:@"Geo Coords [%@ , %@]", [dictForCoord valueForKey:@"lat"],[dictForCoord valueForKey:@"lon"]];
    // Get image form local Dict if not then save.
    imgForWeatherIcon.image = [[AppDelegate appDelegate] getImageForKey:w.icon];

    txtForCityInfo.text = [NSString stringWithFormat:@" Wind : %@ m/s \n Humidity: %@\n Clouds: %@ %% \n\n Sunset: %@ \n Sunrise: %@ \n\n Temperature:\n Current: %@ \n Min: %@ \n Max: %@",[dictForWind valueForKey:@"speed"],[dictForMain valueForKey:@"humidity"],[dictForClouds valueForKey:@"all"], [[[AppDelegate appDelegate] formatterForTime] stringFromDate:[NSDate dateWithTimeIntervalSinceNow:[[dictForSys valueForKey:@"sunrise"] floatValue]]],[[[AppDelegate appDelegate] formatterForTime] stringFromDate:[NSDate dateWithTimeIntervalSinceNow:[[dictForSys valueForKey:@"sunset"] floatValue]]],[NSString stringWithFormat:@"%.01f 'C", [[dictForMain valueForKey:@"temp"] floatValue] - 273.15],[NSString stringWithFormat:@"%.01f 'C", [[dictForMain valueForKey:@"temp_min"] floatValue] - 273.15],[NSString stringWithFormat:@"%.01f 'C", [[dictForMain valueForKey:@"temp_max"] floatValue] - 273.15]  ];
    float fTemp = [[dictForMain valueForKey:@"temp"] floatValue];
    lblTemperature.text = [NSString stringWithFormat:@"%.01f 'C", fTemp - 273.15];
    [txfForCity resignFirstResponder];
}

#pragma mark Btn Action Events
// Search by user manually
- (IBAction)btnFindAction:(id)sender {
    [activity startAnimating];
    [viewForCityInfo setHidden:YES];
    NSString *strCity = [txfForCity.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    txfForCity.text = @"";
    [self getCityInfoFromSearch:strCity];
}
// Automatically search weather data based on device geo location
- (IBAction)btnGetGeoLocation:(id)sender {
    [activity startAnimating];
    [viewForCityInfo setHidden:YES];
    [locationManager startUpdatingLocation];
}
// Based on Searched city, It will get more info
- (IBAction)btnMoreInfoEvent:(id)sender {
    [self getCityList];
}
// Back to ViewController
- (IBAction)backToMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// Redirect to List View.
-(void)redirectToListView {
    [activity stopAnimating];
    [self performSegueWithIdentifier:kSegue_City_To_Forecast sender:nil];
}

#pragma mark Util Methods
// This will sort List of Weather info by Day to Day.
-(NSArray *)sortingArrayBasedOnDate:(NSArray *)arrayOfForecast {
    NSSortDescriptor *valueDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dt" ascending:YES] ;
    NSArray * descriptors = [NSArray arrayWithObjects:valueDescriptor1, nil];
    arrayOfCityList = [arrayOfForecast sortedArrayUsingDescriptors:descriptors];
    return arrayOfCityList;
}

@end
