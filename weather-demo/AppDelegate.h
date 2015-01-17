//
//  AppDelegate.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(AppDelegate *)appDelegate;

@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) NSDateFormatter *formatterForTime;
@property (strong, nonatomic) NSMutableDictionary *dictForImage;

#pragma CoreData
/**
 *   Core Data Objects Declaration
 *   Properties for Core Data
 */
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
#pragma RestKit
/**
 *  RestKit Initialization for Core Mapping Context Object Declaration
 */
@property (nonatomic, strong) NSManagedObjectContext *nsManegedObjectContext;
@property (nonatomic, strong) RKManagedObjectStore *rkMOS;
@property (nonatomic, strong) RKObjectManager *rkObjectManager;
/**
 *  RKObjectManager - Mapping Object Declaration
 */
@property (nonatomic, strong) RKObjectManager *rkomForGetCity;
@property (nonatomic, strong) RKObjectManager *rkomForGetForecastCity;


-(UIImage *)getImageForKey:(NSString *)strKey;

@end

