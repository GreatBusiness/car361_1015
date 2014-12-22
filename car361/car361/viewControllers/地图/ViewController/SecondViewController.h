//
//  SecondViewController.h
//  GMap
//
//  Created by gaomeng on 14/11/23.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "ThirdViewController.h"

#import "FBBaseViewController.h"



@interface SecondViewController : FBBaseViewController

{
    
    UITableView *_tableView;//主tableview
    NSMutableArray *_tableViewDataArray;//tableview的数据源
    
    
    BMKMapView *_mapView;//地图

    
    
    //定位相关
    BMKLocationService *_locService;//定位服务
    BMKUserLocation *_guserLocation;//用户位置
    
    
    //检索相关
    BMKNearbySearchOption *_option;
    BMKPoiSearch* _poisearch;
    int curPage;
    
    
    
}

//用于接收上一个vc传过来用户搜索的参数
@property(nonatomic,strong)NSString *wordStr;//搜索关键字
@property(nonatomic,strong)NSString *distanceStr;//距离半径

//搜索完成后从百度得到的周边信息
@property(nonatomic,strong)BMKPoiResult *theBMKPoiResult;//百度封装的类 我们需要用的是它里面的BMKPoiInfo对象



@end
