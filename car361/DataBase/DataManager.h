//
//  DataManager.h
//  car361
//
//  Created by lichaowei on 14/11/4.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (void)addRegionId:(int)regionId
         regionName:(NSString *)regionName;

+ (void)addRegionSubId:(int)regionId
            regionName:(NSString *)regionName
              parentId:(int)parentId;

+ (NSArray *)getRegion;

+ (NSArray *)getRegionSubForRegionId:(int)regionId;

@end
