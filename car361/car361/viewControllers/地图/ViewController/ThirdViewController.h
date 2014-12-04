//
//  ThirdViewController.h
//  GMap
//
//  Created by gaomeng on 14/11/23.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

#import "FBBaseViewController.h"

@interface ThirdViewController : FBBaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
{
    BMKMapView *_mapView;//地图
    BMKLocationService *_locService;//定位服务

    //信息字典
    NSMutableDictionary *_poiAnnotationDic;

}


@property(nonatomic,strong)BMKPoiResult *theBMKPoiResult;//上个界面传过来的poi搜索结果类
@property(nonatomic,strong)NSIndexPath *theIndexPath;//上个界面传过来的tableview点击index  为了找到具体的BMKPoiInfo对象

@end
