//
//  DataManager.h
//  car361
//
//  Created by lichaowei on 14/11/4.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

//区域

+ (void)addRegionId:(int)regionId
         regionName:(NSString *)regionName;

+ (void)addRegionSubId:(int)regionId
            regionName:(NSString *)regionName
              parentId:(int)parentId;

+ (NSArray *)getRegion;

+ (NSArray *)getRegionSubForRegionId:(int)regionId;

//服务

+ (void)addService:(int)pid
       serviceName:(NSString *)pName;

+ (void)addServiceSubId:(int)serviceId
             regionName:(NSString *)serviceName
               parentId:(int)parentId;

+ (NSArray *)getService;

+ (NSArray *)getServiceSubForRegionId:(int)regionId;

@end
