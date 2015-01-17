//
//  ForecastList.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, ListOfCityWeather;

@interface ForecastList : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * cnt;
@property (nonatomic, retain) NSSet *listOfCity;
@property (nonatomic, retain) City *city;
@end

@interface ForecastList (CoreDataGeneratedAccessors)

- (void)addListOfCityObject:(ListOfCityWeather *)value;
- (void)removeListOfCityObject:(ListOfCityWeather *)value;
- (void)addListOfCity:(NSSet *)values;
- (void)removeListOfCity:(NSSet *)values;

+(RKEntityMapping *)objectMappingForForecastList:(OPPCodeType)OppCodeType;

@end
