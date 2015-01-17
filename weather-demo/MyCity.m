//
//  MyCity.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "MyCity.h"
#import "Weather.h"


@implementation MyCity

@dynamic base;
@dynamic clouds;
@dynamic cod;
@dynamic coord;
@dynamic dt;
@dynamic ids;
@dynamic main;
@dynamic name;
@dynamic sys;
@dynamic wind;
@dynamic weather;

+(RKEntityMapping *)objectMappingForMyCity:(OPPCodeType)OppCodeType {
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:@"MyCity" inManagedObjectStore:[[AppDelegate appDelegate] rkMOS]];
    
    mapping.setDefaultValueForMissingAttributes = TRUE;
    if (OppCodeType == MY_CITY) {
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"id" : @"ids",
                                                      @"coord" : @"coord",
                                                      @"base" : @"base",
                                                      @"main" : @"main",
                                                      @"wind" : @"wind",
                                                      @"clouds" : @"clouds",
                                                      @"dt" : @"dt",
                                                      @"name" : @"name",
                                                      @"cod" : @"cod",
                                                      @"sys" : @"sys",
                                                      }];
        
        [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"weather" withMapping:[Weather objectMappingForWeather:MY_CITY]]];
    }
    return mapping;
}

@end
