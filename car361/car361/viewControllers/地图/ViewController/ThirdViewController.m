//
//  ThirdViewController.m
//  GMap
//
//  Created by gaomeng on 14/11/23.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
  
}

- (void)availableMapsApps {
    
    BMKPoiInfo *poi = [self.theBMKPoiResult.poiInfoList objectAtIndex:self.theIndexPath.row];
    
    CLLocationCoordinate2D startCoor = _mapView.centerCoordinate;
    CLLocationCoordinate2D endCoor = poi.pt;
    
    
    NSString *toName = poi.name;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",
                               startCoor.latitude, startCoor.longitude, endCoor.latitude, endCoor.longitude, toName];
        
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"未安装百度地图" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BMKPoiInfo *poi = [self.theBMKPoiResult.poiInfoList objectAtIndex:self.theIndexPath.row];
    self.titleLabel.text = poi.name;
    
    
    UIButton *navigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationBtn setTitle:@"导航" forState:UIControlStateNormal];
    navigationBtn.frame = CGRectMake(0, 7, 50, 30);
    navigationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navigationBtn addTarget:self action:@selector(availableMapsApps) forControlEvents:UIControlEventTouchUpInside];
    navigationBtn.layer.cornerRadius = 3.f;
    navigationBtn.layer.borderWidth = 0.5f;
    navigationBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:navigationBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    //地图
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    [_mapView setZoomLevel:16];// 设置地图级别
    _mapView.isSelectedAnnotationViewFront = YES;
    _mapView.delegate = self;//设置代理
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:_mapView];
    
    self.view.backgroundColor=[UIColor orangeColor];
    
    //判断是否开启定位
    if ([CLLocationManager locationServicesEnabled]==NO) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务已被关闭，开启定位请前往 设置->隐私->定位服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }else{
        //定位
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [_locService startUserLocationService];//启动LocationService
        
    }
    
    
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    for (int i = 0; i < self.theBMKPoiResult.poiInfoList.count; i++) {//poiResultList.poiInfoList.count
        
        BMKPoiInfo *poi = [self.theBMKPoiResult.poiInfoList objectAtIndex:i];
        
        NSLog(@"%@",poi.name);
        NSLog(@"%@",poi.address);
        NSLog(@"%@",poi.phone);
        [_poiAnnotationDic setObject:poi forKey:poi.name];
        
        BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
        item.coordinate = poi.pt;
        item.title = poi.name;
        item.subtitle = poi.address;
        [_mapView addAnnotation:item];//addAnnotation方法会掉BMKMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
        
        
    }
    
    
}




#pragma mark - 地图view代理方法 BMKMapViewDelegate
/**
 *根据anntation生成对应的View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    
    //根据上个界面传过来的indexpath 再搜索结果中找到对应的搜索结果信息
    BMKPoiInfo *poi = [self.theBMKPoiResult.poiInfoList objectAtIndex:self.theIndexPath.row];
    //获取到poi搜索结果信息的坐标
    CLLocationCoordinate2D ccc = [annotation coordinate];
    
    
    //判断坐标是否与标注view关联的annotation中的坐标一致
    if (ccc.latitude == poi.pt.latitude && ccc.longitude == poi.pt.longitude) {
        [annotationView setSelected:YES animated:YES];//如果一致 弹出气泡
    }
    
    
    annotationView.image = [UIImage imageNamed:@"gpin.png"];
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    //点击标注是走的回调方法
    
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}


- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    //点击泡泡走的回调
    
    NSLog(@"%s",__FUNCTION__);
    
}



- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}




//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    
    if (userLocation.location){
        [_mapView updateLocationData:userLocation];
        _mapView.centerCoordinate = userLocation.location.coordinate;
        [_locService stopUserLocationService];
    }
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
