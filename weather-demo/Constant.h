//
//  Constant.h
//  weather-demo
//
//  Created by Sitanshu Joshi on 1/16/15.
//  Copyright (c) 2015 Sitanshu Joshi. All rights reserved.
//

#ifndef weather_demo_Constant_h
#define weather_demo_Constant_h

// Global
#define kBase_URL               @"http://api.openweathermap.org/data/2.5/"
#define kDB_Store               @"Weather_Demo.sqlite"

// App Specific
#define kAPP_ID                 @"8bb39a6d13150db6be0c76f6575fa56f"
#define kDays_CallBack          14

// City Weather
#define kCity_Weather           @"weather?q=%@"
#define kGeo_Weather            @"weather?lat=%@&lon=%@"
#define kCity_Forecast_Weather  @"forecast/daily?id=%@&cnt=14&APPID=%@"

// Seague Identifier
#define kSegue_Menu_To_City         @"menuToCitySearch"
#define kSegue_City_To_Forecast      @"mycity_to_forecast"

// icon
#define kImg_For_Weathet        @"http://openweathermap.org/img/w/%@.png"

// Cell Identifier
#define kCell_Identifier        @"weatherCell"
#define kTag_Cell_Icon          101
#define kTag_Cell_Name          102
#define kTag_Cell_Desc          103

#endif
