//
//  Weather.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "Weather.h"
#import "MyCity.h"


@implementation Weather

@dynamic desc;
@dynamic icon;
@dynamic ids;
@dynamic main;
@dynamic data;
@dynamic data1;

+(RKEntityMapping *)objectMappingForWeather:(OPPCodeType)OppCodeType {
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"Weather" inManagedObjectStore:[[AppDelegate appDelegate] rkMOS]];
    
    mapping.setDefaultValueForMissingAttributes = TRUE;
    if (OppCodeType == MY_CITY || OppCodeType == CALL_FORECAST_CITY) {
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"id" : @"ids",
                                                      @"main" : @"main",
                                                      @"description" : @"desc",
                                                      @"icon" : @"icon",
                                                      }];
        
    }
    return mapping;
}

@end
