//
//  City.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/17/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) id coord;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * ids;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) NSManagedObject *data2;

+(RKEntityMapping *)objectMappingForCity:(OPPCodeType)OppCodeType;

@end
