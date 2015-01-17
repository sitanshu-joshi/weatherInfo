//
//  ViewController.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize btnForCity;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btnForCity.layer.cornerRadius = 75;
    btnForCity.layer.masksToBounds = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)btnCityEvent:(id)sender {
    [self performSegueWithIdentifier:kSegue_Menu_To_City sender:nil];
}


@end
