//
//  ServiceListController.m
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ServiceListController.h"
#import "MenuSortView.h"
#import "ListTable.h"

#import "ServiceCell.h"

#import "ServiceInfoClass.h"

#import "RegionClass.h"

#import "Location.h"

#import "ServiceDescriptionController.h"

#import "BusinessDetailViewController.h"

#import "ServiceClass.h"

#import "CustomButtom.h"

@interface ServiceListController ()<UITableViewDataSource,RefreshDelegate>
{
    UIView *menu_back;//选项卡
    MenuSortView *sortView;//排序列表
    ListTable *areaTable;//地区列表
    ListTable *classTable;//服务分类列表
    
//    int param_cid; //服务的id
    int param_region;//城市地区
    int param_area;//城市下级
    float param_square;//范围
    
    NSString *sortStyle;//price 价格；score 评分；trade 人数
    
    MBProgressHUD *loading;
    
    UIButton *openButton;//记录打开的button
    UITapGestureRecognizer *tap;
}

@property(nonatomic,retain)RefreshTableView *table;

@end

@implementation ServiceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat aDis = _aType == list_business ? 44 : 0;
    
    if (_aType == list_business) {
        self.button_back.hidden = YES;
    }
    
    loading = [LTools MBProgressWithText:@"努力加载中" addToView:self.view];
    
    [loading show:YES];

    
    //数据展示table
    _table = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_SIZE.width, SCREEN_SIZE.height  - 49 - 36 - aDis)];
    _table.refreshDelegate = self;
    _table.dataSource = self;
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
//    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToDo:)];
//    
//    [self.view addGestureRecognizer:tap];
//    tap.enabled = NO;
    
    [self createMenuViews];
    [self createAreaAndClassMenu];
    [self createSortMenu];
    
    param_square = 1000;//默认附近1000
    
    [self getServerList];
    
    
    self.titleLabel.text = self.service_sub_name;
    
    [[self buttonForIndex:1] setTitle:self.service_sub_name forState:UIControlStateNormal];
    [[self buttonForIndex:0] setTitle:@"1000米" forState:UIControlStateNormal];
    
    
    //获取 地区数据  和 服务分类数据
    [self getClassData];
    [self getArea];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建视图

- (void)createMenuViews
{
    menu_back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME.size.width, 36)];
    menu_back.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    [self.view addSubview:menu_back];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, menu_back.bottom - 0.5f, menu_back.width, 0.5f)];
    line.backgroundColor = COLOR_TABLE_LINE;
    [menu_back addSubview:line];
    
    CGFloat awidth = ALL_FRAME.size.width / 3.f;
    NSArray *titles = @[@"全城",@"汽车美容",@"默认"];
    for (int i = 0; i < 3; i ++) {
        
        CustomButtom *cust_btn = [[CustomButtom alloc]initWithFrame:CGRectMake(awidth * i, 0, awidth, menu_back.height) title:[titles objectAtIndex:i] target:self action:@selector(clickToOpenMenu:) tag:i + 100];
        [menu_back addSubview:cust_btn];
    }

    
//    CGFloat awidth = ALL_FRAME.size.width / 3.f;
//    NSArray *titles = @[@"全城",@"汽车美容",@"默认"];
//    for (int i = 0; i < 3; i ++) {
//        
//        UIButton *menu_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        menu_btn.frame = CGRectMake(awidth * i, 0, awidth, menu_back.height);
//        [menu_btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
//        [menu_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        [menu_back addSubview:menu_btn];
//        [menu_btn setImage:[UIImage imageNamed:@"hornxia"] forState:UIControlStateNormal];
//        [menu_btn setImage:[UIImage imageNamed:@"hornxiahover"] forState:UIControlStateSelected];
//        
//        [menu_btn setTitleColor:[UIColor colorWithHexString:@"515151"] forState:UIControlStateNormal];
//        [menu_btn setTitleColor:[UIColor colorWithHexString:@"54ad13"] forState:UIControlStateSelected];
//        
//        [menu_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - 5 - 5, 0, 0)];
//        [menu_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,  - awidth - 50 + 30 + 10)];
//        
//        menu_btn.tag = 100 + i;
//        
//        [menu_btn addTarget:self action:@selector(clickToOpenMenu:) forControlEvents:UIControlEventTouchUpInside];
//    }
}

- (void)createAreaAndClassMenu
{
    areaTable = [[ListTable alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, ALL_FRAME.size.height - 30 - menu_back.bottom - 64 - 100) listType:List_Area];
    [self.view addSubview:areaTable];
    [areaTable actionBlock:^(ActionType type, NSString *selectName,NSString *selectId) {
        if (type == Action_Back) {
            
            [self refreshButtonState:0];

        }else if (type == Action_Distance){
            
            NSLog(@"distance %@ id %@",selectName,selectId);
        
            param_square = [selectId intValue];
            
            //根据附近距离条件时
            //区域置 0
            
            param_area = 0;
            param_region = 0;
            
            
        }else if (type == Action_Area){
            
            NSLog(@"area %@ id %@",selectName,selectId);
            
            NSArray *arr = [selectId componentsSeparatedByString:@","];
            if (arr.count > 1) {
                
                int subId = [[arr objectAtIndex:0]intValue];
                int parentId = [[arr objectAtIndex:1]intValue];
                param_region = parentId;//一级城市
                param_area = subId;//二级
            }
            
        }else if (type == Action_WholeCity){
            
            NSLog(@"whole %@ id %@",selectName,selectId);
            
            param_region = 0;//一级城市
            param_area = 0;//二级
            param_square = 1000000;
            
            //根据区域获取时,坐标不要
            
            
        }
        
        if (type == Action_Back) {
            
            return ;
        }
        
        [[self buttonForIndex:0] setTitle:selectName forState:UIControlStateNormal];
        
        [self updateParam];
    }];
    
    
    classTable = [[ListTable alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, ALL_FRAME.size.height - 30 - menu_back.bottom - 64 - 100) listType:List_Service];
    [self.view addSubview:classTable];
    [classTable actionBlock:^(ActionType type, NSString *selectName,NSString *selectId) {
        if (type == Action_Back) {
            
            [self refreshButtonState:1];
            
        }else if (type == Action_Service){
            
            NSLog(@"select %@ id %@",selectName,selectId);
            
            self.cid = [selectId intValue];
            
            [[self buttonForIndex:1] setTitle:selectName forState:UIControlStateNormal];
            
            self.titleLabel.text = selectName;
        }
        
        [self updateParam];
    }];

}

- (void)createSortMenu
{
    __weak typeof(self)weakSelf = self;
//    NSArray *titles = @[@"默认排序",@"距离最近",@"价格由小到大",@"价格由大到小",@"选择人数",@"评价最高",@"最近发布"];
    
    NSArray *titles = @[@"默认",@"价格",@"评分",@"人数"];
    
    sortView = [[MenuSortView alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, 0) titles:titles sortBlock:^(int tag, NSString *sortName, int sortId) {
        
        if (tag == 0) {
            
            [weakSelf refreshButtonState:2];
            
        }else if (tag == 1){
         
            NSLog(@"sort %@ id %d",sortName,sortId);
            
            [[weakSelf buttonForIndex:2] setTitle:sortName forState:UIControlStateNormal];
            
            [weakSelf sortStyle:sortId];
            
            [weakSelf updateParam];
        }
        
    }];
    [self.view addSubview:sortView];
}

//排序方式
- (void)sortStyle:(int)sortId
{
    //price 价格；score 评分；trade 人数
    
    switch (sortId) {
        case 0:
        {
            sortStyle = @"";
        }
            break;
        case 1:
        {
            sortStyle = @"price";
        }
            break;
        case 2:
        {
            sortStyle = @"score";
        }
            break;
        case 3:
        {
            sortStyle = @"trade";
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 事件处理

- (void)tapToDo:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded) {
        
        if (openButton.selected) {
            
            [self refreshButtonState:(int)openButton.tag - 100];
        }
    }
}

/**
 *  0 -- 2 获取button
 */
- (UIButton *)buttonForIndex:(int)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:index + 100];
    return btn;
}

- (void)updateParam
{
    _table.pageNum = 1;
    _table.isReloadData = YES;
    [self getServerList];
}

/**
 *  更新button状态（点击底部）
 *
 *  @param index 0 --> 3
 */

- (void)refreshButtonState:(int)index
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:index + 100];
    
    [self clickToOpenMenu:btn];
}

- (void)clickToOpenMenu:(UIButton *)sender
{

    for (int i = 0; i < 3; i ++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i + 100];
        
        CustomButtom *cus_btn = (CustomButtom *)btn.superview;
        
        if (btn == sender) {
            btn.selected = !btn.selected;
        }else
        {
            btn.selected = NO;
        }
        [cus_btn setSelected:btn.selected];
        
        if (sender.tag == 100) {
            
            [sortView show:NO];
            [classTable showOrHidden:NO];
            [areaTable showOrHidden:sender.selected];
            
            openButton = sender;
            
             tap.enabled = sender.selected;
            
        }else if (sender.tag == 101){
            
            [sortView show:NO];
            [classTable showOrHidden:sender.selected];
            [areaTable showOrHidden:NO];
            openButton = sender;
            tap.enabled = sender.selected;
            
        }else if (sender.tag == 102){
        
            [sortView show:sender.selected];
            [classTable showOrHidden:NO];
            [areaTable showOrHidden:NO];
            openButton = sender;
            tap.enabled = sender.selected;
        }
        
    }
}

#pragma mark - 数据解析

- (void)parseAreaWithArray:(NSArray *)result
{
    if ([result isKindOfClass:[NSArray class]]) {
        
        NSArray *arr = (NSArray *)result;
        
        for (NSDictionary *aDic in arr) {
            
            RegionClass *region = [[RegionClass alloc]initWithDictionary:aDic];
            
            [DataManager addRegionId:region.regionid regionName:region.regionname];
            
            for (NSDictionary *subDic in region.content) {
                
                RegionClass *subRegion = [[RegionClass alloc]initWithDictionary:subDic];

                [DataManager addRegionSubId:subRegion.id regionName:subRegion.name parentId:region.regionid];
                
            }
            
        }
        
        [areaTable reloadDataLeft];
                
        [LTools cacheBool:YES ForKey:CAR_AREA_UPDATED];
    }

}

#pragma mark - 网络请求

- (void)getClassData
{
    
    BOOL serviceUpdate = [LTools cacheBoolForKey:CAR_SERVICE_UPDATED];
    if (serviceUpdate) {
        
        [classTable reloadDataLeft];
        
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    LTools *tool = [[LTools alloc]initWithUrl:CAR_SERVICE_CLSSES isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *result_arr = (NSArray *)result;
            for (NSDictionary *aDic  in result_arr) {
                ServiceClass *class = [[ServiceClass alloc]initWithDictionary:aDic];
                
                [DataManager addService:class.pid serviceName:class.pname];
                
                for (NSDictionary *subDic in class.content) {
                    
                    ServiceClass *class_sub = [[ServiceClass alloc]initWithDictionary:subDic];
                    
                    [DataManager addServiceSubId:class_sub.id regionName:class_sub.name parentId:class.pid];
                    
                }
                
            }
            
            
            [LTools cacheBool:YES ForKey:CAR_SERVICE_UPDATED];

            
            
        }
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
}



- (void)getServerList
{
    //http://www.car361.cn/api.php?c=service&a=showlist&city=beijing&cid=2&region=1&area=3&lng=116.27079010&lat=39.95080947&square=0.5&page=1&type=json
    
    
    Location *loc = [Location shareInstance];
    CLLocationCoordinate2D current = loc.currentCoor;
    
//    int param_cid; //服务的id
//    int param_region;//城市地区
//    int param_area;//城市下级
    
    NSString *city = @"beijing";
    int cid = self.cid; //服务的id
    int region = param_region;
    int area  = param_area;
//    NSString *lng = @"116.27079010";//经度
//    NSString *lat = @"39.95080947";//纬度
    
//    param_area = 0;
//    param_region = 0;
    
    NSString *lng = NSStringFromFloat(current.longitude);//经度
    NSString *lat = NSStringFromFloat(current.latitude);//纬度
    
    
    NSString *square = NSStringFromFloat(param_square);
    //区域不为空
    if (param_area != 0 || param_region != 0) {
        
        lng = @"";
        lat = @"";
        square = @"";
    }
    
    NSString *url = [NSString stringWithFormat:CAR_SERVICE_LIST,city,cid,region,area,lng,lat,square,_table.pageNum,sortStyle];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = (NSArray *)result;
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:arr.count];
            
            for (NSDictionary *aDic in arr) {
                
                ServiceInfoClass *infoClass = [[ServiceInfoClass alloc]initWithDictionary:aDic];
                [tempArr addObject:infoClass];
                
            }
            
            BOOL haveMore = tempArr.count > 0  ? YES : NO;
            
            [_table reloadData:tempArr haveMore:haveMore];
        }
        
        [loading hide:YES];
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        ;
    }];
}

- (void)getArea
{
    BOOL area_updated = [LTools cacheBoolForKey:CAR_AREA_UPDATED];
    
    if (area_updated) {
        
        [areaTable reloadDataLeft];
        
        return;
        
    }
    
    __weak typeof(self)weakSelf = self;
    
    NSString *url = [NSString stringWithFormat:CAR_AREA_STREET];
    LTools *tool = [[LTools alloc]initWithUrl:url isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        [weakSelf parseAreaWithArray:(NSArray *)result];
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
        
    }];
}

#pragma - mark RefreshDelegate <NSObject>

- (void)loadNewData
{
    NSLog(@"loadNewData");
    
    [self getServerList];
}

- (void)loadMoreData
{
    NSLog(@"loadMoreData");
    
    [self getServerList];
    
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ServiceDescriptionController *detail = [[ServiceDescriptionController alloc]init];
//    ServiceInfoClass *info = [_table.dataArray objectAtIndex:indexPath.row];
//    detail.infoClass = info;
//    [self.navigationController pushViewController:detail animated:YES];
    
    BusinessDetailViewController *detail = [[BusinessDetailViewController alloc]init];
    ServiceInfoClass *info = [_table.dataArray objectAtIndex:indexPath.row];
    detail.shopId = info.shopid;
    detail.infoId = info.infoid;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)scrollViewWillBeginDecelerating
{
    if (openButton.selected) {
        
        [self refreshButtonState:(int)openButton.tag - 100];
    }
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _table.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CarSourceCell";
    
    ServiceCell *cell = (ServiceCell *)[LTools cellForIdentify:identifier cellName:@"ServiceCell" forTable:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ServiceInfoClass *info = [_table.dataArray objectAtIndex:indexPath.row];
    [cell setCellWithModel:info];
    
    cell.bottomLine.backgroundColor = COLOR_TABLE_LINE;
    cell.bottomLine.height = 0.5f;
    
    cell.phoneBtn.layer.cornerRadius = 3.f;
    
    cell.shopDetailBtn.layer.cornerRadius = 3.f;

    
    return cell;
    
}



@end
