//
//  ListOfCityWeather.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "ListOfCityWeather.h"
#import "ForecastList.h"
#import "Weather.h"


@implementation ListOfCityWeather

@dynamic clouds;
@dynamic deg;
@dynamic dt;
@dynamic humidity;
@dynamic pressure;
@dynamic speed;
@dynamic temp;
@dynamic weather;
@dynamic list;

+(RKEntityMapping *)objectMappingForListCity:(OPPCodeType)OppCodeType {
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"ListOfCityWeather" inManagedObjectStore:[[AppDelegate appDelegate] rkMOS]];
    
    mapping.setDefaultValueForMissingAttributes = TRUE;
    if (OppCodeType == CALL_FORECAST_CITY) {
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"clouds" : @"clouds",
                                                      @"deg" : @"deg",
                                                      @"dt" : @"dt",
                                                      @"humidity" : @"humidity",
                                                      @"pressure" : @"pressure",
                                                      @"speed" : @"speed",
                                                      @"temp" : @"temp",
                                                      }];
        [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"weather" withMapping:[Weather objectMappingForWeather:CALL_FORECAST_CITY]]];
    }
    return mapping;
}

@end
