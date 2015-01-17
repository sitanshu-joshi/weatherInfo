//
//  Weather.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyCity;

@interface Weather : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * ids;
@property (nonatomic, retain) NSString * main;
@property (nonatomic, retain) MyCity *data;
@property (nonatomic, retain) NSManagedObject *data1;

+(RKEntityMapping *)objectMappingForWeather:(OPPCodeType)OppCodeType;

@end
