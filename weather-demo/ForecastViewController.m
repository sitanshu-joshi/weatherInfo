//
//  ForecastViewController.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "ForecastViewController.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController

@synthesize arrayOfCity,cityName,lblHeader;
@synthesize tableForCityList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    lblHeader.text = cityName;
    NSLog(@"%lu",(unsigned long)arrayOfCity.count);
}


#pragma mark Table Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayOfCity.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentify = kCell_Identifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
    }
    ListOfCityWeather *cityWeather = [arrayOfCity objectAtIndex:indexPath.row];
    Weather *wther = [[cityWeather.weather allObjects] firstObject];
    NSDictionary *dictForTemp = (NSDictionary *)cityWeather.temp;
    
    UILabel *lblName = (UILabel *)[cell viewWithTag:kTag_Cell_Name];
    
    UILabel *lblDesc = (UILabel *)[cell viewWithTag:kTag_Cell_Desc];
    
    UIImageView *imgIcon = (UIImageView *)[cell viewWithTag:kTag_Cell_Icon];
    
    lblName.text = [NSString stringWithFormat:@"%@, %@ : %@",wther.main,wther.desc, [NSString stringWithFormat:@"%.01f 'C", [[dictForTemp valueForKey:@"day"] floatValue] - 273.15] ];
    
    lblDesc.text = [NSString stringWithFormat:@"wind %@m/s, clouds %@%%, at %@",cityWeather.speed,cityWeather.clouds,[[[AppDelegate appDelegate] formatter] stringFromDate:cityWeather.dt]];
    
    imgIcon.image = [[AppDelegate appDelegate] getImageForKey:wther.icon];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
