//
//  ForecastViewController.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UITableView *tableForCityList;

@property (weak, nonatomic) NSString *cityName;

@property (strong, nonatomic) NSArray *arrayOfCity;

- (IBAction)btnBackAction:(id)sender;

@end
