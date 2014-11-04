//
//  DataManager.m
//  car361
//
//  Created by lichaowei on 14/11/4.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "DataManager.h"
#import "DataBase.h"

#import "RegionClass.h"
#import "ServiceClass.h"

@implementation DataManager

#pragma mark -  数据插入

//一级区域

+ (void)addRegionId:(int)regionId
         regionName:(NSString *)regionName
{
    
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(db, "insert into region(regionid,regionname) values(?,?)", -1, &stmt, nil);//?相当于%@格式
    sqlite3_bind_int(stmt, 1, regionId);
    sqlite3_bind_text(stmt, 2, [regionName UTF8String], -1, NULL);

    result = sqlite3_step(stmt);
    
    NSLog(@"region 添加 %@ brandResult:%d",regionName,result);
    
    sqlite3_finalize(stmt);
}

// 二级区域
+ (void)addRegionSubId:(int)regionId
         regionName:(NSString *)regionName
              parentId:(int)parentId
{
    
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(db, "insert into region_sub(id,name,parentId) values(?,?,?)", -1, &stmt, nil);//?相当于%@格式
    sqlite3_bind_int(stmt, 1, regionId);
    sqlite3_bind_text(stmt, 2, [regionName UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, parentId);
    
    result = sqlite3_step(stmt);
    
    NSLog(@"region_sub 添加 %@ :%d",regionName,result);
    
    sqlite3_finalize(stmt);
}


//一级服务

+ (void)addService:(int)pid
         serviceName:(NSString *)pName
{
    
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(db, "insert into service(pid,pname) values(?,?)", -1, &stmt, nil);//?相当于%@格式
    sqlite3_bind_int(stmt, 1, pid);
    sqlite3_bind_text(stmt, 2, [pName UTF8String], -1, NULL);
    
    result = sqlite3_step(stmt);
    
    NSLog(@"service 添加 %@ result:%d",pName,result);
    
    sqlite3_finalize(stmt);
}

// 二级服务
+ (void)addServiceSubId:(int)serviceId
            regionName:(NSString *)serviceName
              parentId:(int)parentId
{
    
    sqlite3 *db = [DataBase openDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare(db, "insert into service_sub(id,name,parentId) values(?,?,?)", -1, &stmt, nil);//?相当于%@格式
    sqlite3_bind_int(stmt, 1, serviceId);
    sqlite3_bind_text(stmt, 2, [serviceName UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 3, parentId);
    
    result = sqlite3_step(stmt);
    
    NSLog(@"service_sub 添加 %@ result:%d",serviceName,result);
    
    sqlite3_finalize(stmt);
}


#pragma mark -  数据查询

//一级区域
+ (NSArray *)getRegion
{
    //打开数据库
    sqlite3 *db = [DataBase openDB];
    //创建操作指针
    sqlite3_stmt *stmt = nil;
    //执行SQL语句
    int result = sqlite3_prepare_v2(db, "select * from region", -1, &stmt, nil);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int regionId = sqlite3_column_int(stmt, 1);
            NSString *regionName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            RegionClass *region = [[RegionClass alloc]init];
            region.regionid = regionId;
            region.regionname = regionName;
            
            [arr addObject:region];
        }
    }
    sqlite3_finalize(stmt);
    return arr;
}

//一级区域
+ (NSArray *)getRegionSubForRegionId:(int)regionId
{
    //打开数据库
    sqlite3 *db = [DataBase openDB];
    //创建操作指针
    sqlite3_stmt *stmt = nil;
    //执行SQL语句
    int result = sqlite3_prepare_v2(db, "select * from region_sub where parentId = ?", -1, &stmt, nil);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    sqlite3_bind_int(stmt, 1, regionId);
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int regionId = sqlite3_column_int(stmt, 1);
            NSString *regionName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            RegionClass *region = [[RegionClass alloc]init];
            region.id = regionId;
            region.name = regionName;
            
            [arr addObject:region];
        }
    }
    sqlite3_finalize(stmt);
    return arr;
}


//一级服务
+ (NSArray *)getService
{
    //打开数据库
    sqlite3 *db = [DataBase openDB];
    //创建操作指针
    sqlite3_stmt *stmt = nil;
    //执行SQL语句
    int result = sqlite3_prepare_v2(db, "select * from service", -1, &stmt, nil);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int serviceId = sqlite3_column_int(stmt, 1);
            NSString *serviceName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            ServiceClass *service = [[ServiceClass alloc]init];
            service.pid = serviceId;
            service.pname = serviceName;
            
            [arr addObject:service];
        }
    }
    sqlite3_finalize(stmt);
    return arr;
}

//二级服务
+ (NSArray *)getServiceSubForRegionId:(int)regionId
{
    //打开数据库
    sqlite3 *db = [DataBase openDB];
    //创建操作指针
    sqlite3_stmt *stmt = nil;
    //执行SQL语句
    int result = sqlite3_prepare_v2(db, "select * from service_sub where parentId = ?", -1, &stmt, nil);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    sqlite3_bind_int(stmt, 1, regionId);
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int serviceId = sqlite3_column_int(stmt, 1);
            NSString *service_Name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            ServiceClass *service = [[ServiceClass alloc]init];
            service.id = serviceId;
            service.name = service_Name;
            
            [arr addObject:service];
        }
    }
    sqlite3_finalize(stmt);
    return arr;
}


@end
