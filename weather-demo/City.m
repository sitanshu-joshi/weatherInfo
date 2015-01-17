//
//  City.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "City.h"


@implementation City

@dynamic coord;
@dynamic country;
@dynamic ids;
@dynamic name;
@dynamic population;
@dynamic data2;

+(RKEntityMapping *)objectMappingForCity:(OPPCodeType)OppCodeType {
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"City" inManagedObjectStore:[[AppDelegate appDelegate] rkMOS]];
    
    mapping.setDefaultValueForMissingAttributes = TRUE;
    if (OppCodeType == CALL_FORECAST_CITY) {
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"coord" : @"coord",
                                                      @"country" : @"country",
                                                      @"id" : @"ids",
                                                      @"name" : @"name",
                                                      @"population" : @"population",
                                                      }];
    }
    return mapping;
}

@end
