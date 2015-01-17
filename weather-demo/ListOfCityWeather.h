//
//  ListOfCityWeather.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ForecastList, Weather;

@interface ListOfCityWeather : NSManagedObject

@property (nonatomic, retain) NSNumber * clouds;
@property (nonatomic, retain) NSNumber * deg;
@property (nonatomic, retain) NSDate * dt;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) id temp;
@property (nonatomic, retain) NSSet *weather;
@property (nonatomic, retain) ForecastList *list;
@end

@interface ListOfCityWeather (CoreDataGeneratedAccessors)

- (void)addWeatherObject:(Weather *)value;
- (void)removeWeatherObject:(Weather *)value;
- (void)addWeather:(NSSet *)values;
- (void)removeWeather:(NSSet *)values;

+(RKEntityMapping *)objectMappingForListCity:(OPPCodeType)OppCodeType;

@end
