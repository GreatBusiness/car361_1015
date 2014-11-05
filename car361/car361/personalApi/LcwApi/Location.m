//
//  Location.m
//  TuanProject
//
//  Created by 李朝伟 on 13-8-31.
//  Copyright (c) 2013年 COM. All rights reserved.
//

#import "Location.h"

@implementation Location

+ (id)shareInstance
{
    static dispatch_once_t once_t;
    static Location *location;
    
    dispatch_once(&once_t, ^{
        location = [[Location alloc]init];
    });
    
    return location;
}

- (void)startLocation  //开始定位
{
    NSLog(@"定位start了....");
    [self LocationSetting];
    if ([CLLocationManager locationServicesEnabled]) {
        [_locationManager startUpdatingLocation];
    }
}
- (void)stopLocation
{
    [_locationManager stopUpdatingLocation];
}

- (void)LocationSetting
{
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.distanceFilter = 1000;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    
    
    self.currentCoor = coor;//记录当前坐标
    
    NSLog(@"current location %f",coor.latitude);
    
    CLLocation *location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            if (placemark) {
                
                NSString *cityName = placemark.administrativeArea;//城市或省份
                NSString *detail = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"]objectAtIndex:0];
                
                NSLog(@"地址 == %@",detail);
                [_locationManager stopUpdatingLocation];

                if (_delegate && [_delegate respondsToSelector:@selector(currentLocation:city:)]) {
                    [_delegate currentLocation:detail city:cityName];
                }

            }
        }
    }]; //逆向编码,位置信息得到可读数据
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"获取地理位置失败 == %@",error);
    [_locationManager stopUpdatingLocation];
    if (_delegate && [_delegate respondsToSelector:@selector(currentLocation:city:)]) {
        [_delegate currentLocation:@"未知" city:@"未知"];
    }
}

@end
