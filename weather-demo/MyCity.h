//
//  MyCity.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Weather;

@interface MyCity : NSManagedObject

@property (nonatomic, retain) NSString * base;
@property (nonatomic, retain) id clouds;
@property (nonatomic, retain) NSNumber * cod;
@property (nonatomic, retain) id coord;
@property (nonatomic, retain) NSDate * dt;
@property (nonatomic, retain) NSString * ids;
@property (nonatomic, retain) id main;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id sys;
@property (nonatomic, retain) id wind;
@property (nonatomic, retain) NSSet *weather;
@end

@interface MyCity (CoreDataGeneratedAccessors)

- (void)addWeatherObject:(Weather *)value;
- (void)removeWeatherObject:(Weather *)value;
- (void)addWeather:(NSSet *)values;
- (void)removeWeather:(NSSet *)values;

+(RKEntityMapping *)objectMappingForMyCity:(OPPCodeType)OppCodeType;

@end
