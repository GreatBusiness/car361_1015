//
//  Location.h
//  TuanProject
//
//  Created by 李朝伟 on 13-8-31.
//  Copyright (c) 2013年 COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CurrentLocationDelegate <NSObject>
@optional

-(void)currentLocation:(NSString*)detailAddress city:(NSString *)cityName;

@end

@interface Location : NSObject<CLLocationManagerDelegate>

@property (nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic,assign)id<CurrentLocationDelegate>delegate;

@property(nonatomic,assign)CLLocationCoordinate2D currentCoor;//当前坐标

+ (id)shareInstance;

- (void)startLocation;
- (void)stopLocation;

@end
