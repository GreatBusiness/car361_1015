//
//  AppDelegate.h
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //百度地图
    BMKMapManager* _mapManager;
    CLLocationManager *_locationManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

