//
//  SecondViewController.m
//  GMap
//
//  Created by gaomeng on 14/11/23.
//  Copyright (c) 2014年 FBLIFE. All rights reserved.
//

#import "SecondViewController.h"




#import "JiaYouZhanTableViewCell.h"




@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate>
{
    MBProgressHUD *loading;
}

@end

@implementation SecondViewController


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)viewWillDisappear:(BOOL)animated {
    _poisearch.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"搜索关键字为:%@",self.wordStr);
    NSLog(@"搜索距离半径为:%@米",self.distanceStr);
    
    self.titleLabel.text = @"加油站";
    
    loading = [LTools MBProgressWithText:@"数据加载中..." addToView:self.view];
    [loading show:YES];
    
    //搜索类
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    
    //判断是否开启定位
    if ([CLLocationManager locationServicesEnabled]==NO) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"定位服务已被关闭，开启定位请前往 设置->隐私->定位服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }else{
        //定位
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [_locService startUserLocationService];//启动LocationService
        
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    
    
//    //地图
//    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
//    [_mapView setZoomLevel:16];// 设置地图级别
//    _mapView.isSelectedAnnotationViewFront = YES;
//    _mapView.delegate = self;//设置代理
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
//
    
    
    
}





#pragma mark - 定位代理方法 定位成功后搜索周边

//在地图View将要启动定位时，会调用此函数
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"start locate");
}


//定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
}


//用户方向更新后，会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _guserLocation = userLocation;
    NSLog(@"heading is %@",userLocation.heading);
}


//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    _guserLocation = userLocation;
    
    if (userLocation.location) {//定位成功
        [_locService stopUserLocationService];
        //发起检索
        _option = [[BMKNearbySearchOption alloc]init];
        _option.pageIndex = curPage;
        _option.radius = [self.distanceStr intValue];//搜索半径
        _option.pageCapacity = 100;//搜索条数 信息多的话tableview要做上提加载更多 这里先取100条数据吧
        _option.location =CLLocationCoordinate2DMake(_guserLocation.location.coordinate.latitude, _guserLocation.location.coordinate.longitude);
        _option.keyword = self.wordStr;
        BOOL flag = [_poisearch poiSearchNearBy:_option];
        if(flag)
        {
            NSLog(@"周边检索发送成功");
        }
        else
        {
            NSLog(@"周边检索发送失败");
        }
        
        
    }
    
    
}

#pragma mark - 搜索周边信息的回调方法
//周边搜索回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    [loading hide:YES];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        self.theBMKPoiResult = poiResultList;
        
        for (int i = 0; i < poiResultList.poiInfoList.count; i++) {
            BMKPoiInfo *poi = [poiResultList.poiInfoList objectAtIndex:i];
            //测试数据:
            NSLog(@"%@",poi.name);//poi名称
            NSLog(@"%@",poi.address);//poi地址
            NSLog(@"%@",poi.phone);//poi电话
            NSLog(@"lat:%f long:%f",poi.pt.latitude,poi.pt.longitude);//poi经纬度 (百度坐标) 根据这个去算距离
            
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:poi.pt.latitude
                                                              longitude:poi.pt.longitude];//初始化每个poi搜索节点的CLLocation
            
            //距离 CLLocationDistance就是double
            CLLocationDistance distance = [location distanceFromLocation:_guserLocation.location];//这个方法比较是CLLocation
            NSString *distanceStr = [NSString stringWithFormat:@"%.2f米",distance];
            
            //把搜索结果放到数组里 供tableview展示
            if (!_tableViewDataArray) {
                _tableViewDataArray = [NSMutableArray arrayWithCapacity:10];
            }
            
            if (poi.phone.length==0) {
                NSDictionary *dic = @{@"name":poi.name,@"distance":distanceStr,@"telephone":@"",  @"address":poi.address};
                [_tableViewDataArray addObject:dic];

            }else{
                
                NSDictionary *dic = @{@"name":poi.name,@"distance":distanceStr,@"telephone":poi.phone,  @"address":poi.address};
                [_tableViewDataArray addObject:dic];

            }
            
            
        }
        
        [_tableView reloadData];
        
    }else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    }else {
        // 各种情况的判断
    }
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JiaYouZhanTableViewCell";
    JiaYouZhanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JiaYouZhanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    NSDictionary *dic = _tableViewDataArray[indexPath.row];
    
    
    __weak typeof(self)wself=self;
    [cell setAllWithDic:dic therow:indexPath thebloc:^(NSIndexPath * indexofpathofRow, int typeofButton) {
        
        
        NSLog(@"row===%@====type===%d",indexofpathofRow,typeofButton);
        
        
        if (typeofButton==2) {
            
            [wself touchtoPushThirdWithindexpath:indexofpathofRow];
        }else{
        
            [wself availableMapsApps:indexofpathofRow];
        }
        
        
        
    }];
    

    
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    ThirdViewController *thirdVc = [[ThirdViewController alloc]init];
//    thirdVc.theBMKPoiResult = self.theBMKPoiResult;
//    thirdVc.theIndexPath = indexPath;
//    
//    [self.navigationController pushViewController:thirdVc animated:YES];
//    
    
}



#pragma mark---点击进入地图

-(void)touchtoPushThirdWithindexpath:(NSIndexPath*)therow{
    
    ThirdViewController *thirdVc = [[ThirdViewController alloc]init];
    thirdVc.theBMKPoiResult = self.theBMKPoiResult;
    thirdVc.theIndexPath = therow;
    [self.navigationController pushViewController:thirdVc animated:YES];

}


#pragma mark--跳转到百度地图

- (void)availableMapsApps:(NSIndexPath*)therow {
    
    BMKPoiInfo *poi = [self.theBMKPoiResult.poiInfoList objectAtIndex:therow.row];
    
    CLLocationCoordinate2D startCoor = _guserLocation.location.coordinate;
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



@end
