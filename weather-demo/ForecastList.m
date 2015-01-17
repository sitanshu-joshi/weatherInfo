//
//  ForecastList.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "ForecastList.h"
#import "City.h"
#import "ListOfCityWeather.h"


@implementation ForecastList

@dynamic code;
@dynamic message;
@dynamic cnt;
@dynamic listOfCity;
@dynamic city;

+(RKEntityMapping *)objectMappingForForecastList:(OPPCodeType)OppCodeType {
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"ForecastList" inManagedObjectStore:[[AppDelegate appDelegate] rkMOS]];
    
    mapping.setDefaultValueForMissingAttributes = TRUE;
    if (OppCodeType == CALL_FORECAST_CITY) {
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"code" : @"code",
                                                      @"message" : @"message",
                                                      @"cnt" : @"cnt",
                                                      }];
        
        [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"city" toKeyPath:@"city" withMapping:[City objectMappingForCity:CALL_FORECAST_CITY]]];
        [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"list" toKeyPath:@"listOfCity" withMapping:[ListOfCityWeather objectMappingForListCity:CALL_FORECAST_CITY]]];
    }
    return mapping;
}


@end
