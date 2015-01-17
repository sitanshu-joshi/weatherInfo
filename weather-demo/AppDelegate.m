//
//  AppDelegate.m
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#import "AppDelegate.h"

static AppDelegate *appDelegate;

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize nsManegedObjectContext,managedObjectModel,persistentStoreCoordinator;
@synthesize rkMOS,rkObjectManager,rkomForGetCity, rkomForGetForecastCity;
@synthesize formatter,dictForImage,formatterForTime;

#pragma mark Single-Ton instance of AppDelegate

+(AppDelegate *)appDelegate {
    if (appDelegate == nil) {
        appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Initialize Formatter
    formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"MM/dd"];
    
    formatterForTime = [[NSDateFormatter alloc] init];
    [formatterForTime setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatterForTime setDateFormat:@"HH:MM:SS a"];
    // Intialize Dictionary
    dictForImage = [[NSMutableDictionary alloc] init];
    // Calling RestKit
    [self setupRestKitForInitializeUserMapping];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// ===================================== CoreData + RestKit ====================================

#pragma mark - Core Data stack
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    @try {
        if (nsManegedObjectContext != nil)
        {
            return nsManegedObjectContext;
        }
        
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil)
        {
            nsManegedObjectContext = [[NSManagedObjectContext alloc] init];
            [nsManegedObjectContext setPersistentStoreCoordinator:coordinator];
        }
        return nsManegedObjectContext;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    @try {
        if (managedObjectModel != nil) {
            return managedObjectModel;
        }
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Weather_Demo" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        return managedObjectModel;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    @try {
        if (persistentStoreCoordinator != nil) {
            return persistentStoreCoordinator;
        }
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [searchPaths objectAtIndex:0];
        NSURL *storeURL = [[NSURL fileURLWithPath:documentPath] URLByAppendingPathComponent:kDB_Store];
        
        NSError *error = nil;
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
        [pragmaOptions setObject:@"OFF" forKey:@"synchronous"];
        [pragmaOptions setObject:@"MEMORY" forKey:@"journal_mode"];
        NSDictionary *storeOptions =
        [NSDictionary dictionaryWithObject:pragmaOptions forKey:NSSQLitePragmasOption];
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:storeOptions error:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
            abort();
        }
        
        return persistentStoreCoordinator;
    }
    @catch (NSException *exception) {
        NSLog(@"AppDelegate->persistentStoreCoordinator %@", exception);
    }
}

#pragma mark RestKit Initilization
-(void)setupRestKitForInitializeUserMapping {
    /*
     Setup Initial RestKit ObjectStore & Manager
     */
    rkMOS = [[RKManagedObjectStore alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:kDB_Store];
    [rkMOS addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:@{                                                                                                          NSInferMappingModelAutomaticallyOption: @YES,                                                                                                          NSMigratePersistentStoresAutomaticallyOption: @YES
        }
        error:nil];
    [rkMOS createManagedObjectContexts];
    
    rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kBase_URL]];
    [rkObjectManager setManagedObjectStore:rkMOS];
    
    /*
     Get City Weather Mapping
     */
    rkomForGetCity = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kBase_URL]];
    [rkomForGetCity setManagedObjectStore:rkMOS];
    [rkomForGetCity addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:[[MyCity objectMappingForMyCity:MY_CITY] inverseMapping] objectClass:[MyCity class] rootKeyPath:@"" method:RKRequestMethodGET]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MyCity objectMappingForMyCity:MY_CITY] method:RKRequestMethodGET pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[AppDelegate appDelegate].rkomForGetCity addResponseDescriptor:responseDescriptor];
    /*
     Get List Of Cities Mapping
     */
    rkomForGetForecastCity = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kBase_URL]];
    [rkomForGetForecastCity setManagedObjectStore:rkMOS];
    [rkomForGetForecastCity addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:[[ForecastList objectMappingForForecastList:CALL_FORECAST_CITY] inverseMapping] objectClass:[ForecastList class] rootKeyPath:@"" method:RKRequestMethodGET]];
    
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[ForecastList objectMappingForForecastList:CALL_FORECAST_CITY] method:RKRequestMethodGET pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [rkomForGetForecastCity addResponseDescriptor:responseDescriptor];
}

// This will cache images & get from dictionary when needed during App Execution.

-(UIImage *)getImageForKey:(NSString *)strKey {
    UIImage *img = nil;
    img = [dictForImage valueForKey:strKey];
    if (img == nil) {
        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:kImg_For_Weathet,strKey]]]];
        [dictForImage setValue:img forKey:strKey];
    }
    return img;
}


#pragma mark Testing Methods
-(void)testMethod {
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[MyCity objectMappingForMyCity:MY_CITY] method:RKRequestMethodGET pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [rkomForGetCity addResponseDescriptor:responseDescriptor];
    
    NSString *strForCity = [NSString stringWithFormat:kCity_Weather,@"ahmedabad"];
    
    [rkomForGetCity getObjectsAtPath:strForCity parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // Handled with articleDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
                MyCity *city  = [mappingResult.array objectAtIndex:0];
                NSLog(@"%@",[city base]);
        Weather *w = [[city.weather allObjects] firstObject];
        NSLog(@"%@",w.main);
        
        NSLog(@"%ld",operation.HTTPRequestOperation.response.statusCode);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // Transport error or server error handled by errorDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        RKLogError(@"Operation failed with error: %@", error);
    }];
}

-(void)testMethod1 {
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[ForecastList objectMappingForForecastList:CALL_FORECAST_CITY] method:RKRequestMethodGET pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [rkomForGetForecastCity addResponseDescriptor:responseDescriptor];
    
    NSString *strForCity = [NSString stringWithFormat:kCity_Forecast_Weather,@"1279233",kAPP_ID];
    
    [rkomForGetForecastCity getObjectsAtPath:strForCity parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        // Handled with articleDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        ForecastList *forecast  = [mappingResult.array objectAtIndex:0];
        NSLog(@"%lu",[[[forecast listOfCity] allObjects] count]);
        [self sortingArrayBasedOnDate:[[forecast listOfCity] allObjects]];
        NSLog(@"%ld",operation.HTTPRequestOperation.response.statusCode);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        // Transport error or server error handled by errorDescriptor
        NSLog(@"%@",operation.HTTPRequestOperation.responseString);
        RKLogError(@"Operation failed with error: %@", error);
    }];
}

-(NSArray *)sortingArrayBasedOnDate:(NSArray *)arrayOfForecast {
    NSSortDescriptor *valueDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dt" ascending:YES] ;
    NSArray * descriptors = [NSArray arrayWithObjects:valueDescriptor1, nil];
    NSArray * sortedArray = [arrayOfForecast sortedArrayUsingDescriptors:descriptors];
    for (int i = 0; i < sortedArray.count; i++) {
        ListOfCityWeather *ct = [sortedArray objectAtIndex:i];
        NSLog(@"%@",[formatter stringFromDate:ct.dt]);
    }
    
    return sortedArray;
}

@end
