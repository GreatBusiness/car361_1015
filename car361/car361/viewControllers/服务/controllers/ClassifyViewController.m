//
//  ClassifyViewController.m
//  car361
//
//  Created by lichaowei on 14-10-16.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ServiceClass.h"
#import "ServiceListController.h"

@interface ClassifyViewController ()
{
    NSArray *dataArray;
}

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = -5;
    
    UIButton *_button_back=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,44)];
    [_button_back addTarget:self action:@selector(clickToBack:) forControlEvents:UIControlEventTouchUpInside];
    [_button_back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    _button_back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:_button_back];
    self.navigationItem.leftBarButtonItems=@[spaceButton,back_item];

    UILabel *_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 21)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"服务类别";
    
    self.navigationItem.titleView = _titleLabel;
    
    
    BOOL serviceUpdate = [LTools cacheBoolForKey:CAR_SERVICE_UPDATED];
    if (!serviceUpdate) {
        [self getClassData];
        
    }else
    {
        dataArray = [DataManager getService];
        
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建视图

#pragma mark - 事件处理

- (void)clickToBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickToDetail:(UIButton *)sender
{
//    (indexPath.section + 1) * 1000 + i
    
    int tag = (int)sender.tag;
    
    ServiceClass *class = [dataArray objectAtIndex:tag / 1000 - 1];
    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
    
    ServiceClass *class_sub = [sub objectAtIndex:tag % 1000];
    
    ServiceListController *detailViewController = [[ServiceListController alloc] initWithNibName:@"ServiceListController" bundle:nil];
    detailViewController.aType = list_other;
    detailViewController.cid = class_sub.id;
    detailViewController.service_sub_name = class_sub.name;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - 网络请求

- (void)getClassData
{
    __weak typeof(dataArray)weakDataArray = dataArray;
    __weak typeof(self)weakSelf = self;
    LTools *tool = [[LTools alloc]initWithUrl:CAR_SERVICE_CLSSES isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
                
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *result_arr = (NSArray *)result;
            for (NSDictionary *aDic  in result_arr) {
                ServiceClass *class = [[ServiceClass alloc]initWithDictionary:aDic];
//                [weakDataArray addObject:class];
                
                [DataManager addService:class.pid serviceName:class.pname];
                
                for (NSDictionary *subDic in class.content) {
                   
                    ServiceClass *class_sub = [[ServiceClass alloc]initWithDictionary:subDic];
                    
                    [DataManager addServiceSubId:class_sub.id regionName:class_sub.name parentId:class.pid];
                    
                }
                
            }
            
            
            [LTools cacheBool:YES ForKey:CAR_SERVICE_UPDATED];
            
            dataArray = [DataManager getService];
            
            [weakSelf.tableView reloadData];
            
        }
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    ServiceClass *class = [dataArray objectAtIndex:section];
//    return class.pname;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, 30.f)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 223/2.f, 39/2.f)];
    [view addSubview:icon];
    
    ServiceClass *class = [dataArray objectAtIndex:section];
    
    NSString *iconName = @"";
    
    NSString *className = [NSString stringWithFormat:@"%@",class.pname];
    
    if ([className rangeOfString:@"美容"].length > 0) {
        iconName = @"m_meirong";
    }else if ([class.pname rangeOfString:@"改装"].length > 0) {
        iconName = @"m_gaizhuang";
    }else if ([class.pname rangeOfString:@"维修"].length > 0) {
        iconName = @"m_weixiu";
    }else if ([class.pname rangeOfString:@"装饰"].length > 0) {
        iconName = @"m_zhuangshi";
    }
    
    icon.image = [UIImage imageNamed:iconName];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    ServiceClass *class = [dataArray objectAtIndex:section];
//    
//    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
//    
//    return sub.count;
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        for (int i = 0 ; i < 10; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(17 + (i % 5) * (13 + 47), 7 + 7 + (i / 5) * (7 + 47), 47, 47);
            btn.tag = 100 * (indexPath.row + 1) + i;
            [cell addSubview:btn];
            btn.layer.cornerRadius = 47 / 2.f;
            btn.layer.borderWidth = 0.5f;
            btn.clipsToBounds = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            btn.titleLabel.numberOfLines = 2;
            
            [btn addTarget:self action:@selector(clickToDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        NSLog(@"---");
    }
    
    
    ServiceClass *class = [dataArray objectAtIndex:indexPath.section];
    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
    for (int i = 0; i < 10; i ++) {
        
        UIButton *btn = (UIButton *)[cell viewWithTag:100 * (indexPath.row + 1) + i];
        if (i < sub.count) {
            
            btn.hidden = NO;
            
            ServiceClass *class_sub = [sub objectAtIndex:i];
            
            [btn setTitle:class_sub.name forState:UIControlStateNormal];
            
            btn.tag = (indexPath.section + 1) * 1000 + i;
            
        }else
        {
            btn.hidden = YES;
        }
        
        btn.layer.borderColor = [self colorForIndex:indexPath.section].CGColor;
        [btn setTitleColor:[self colorForIndex:indexPath.section] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (UIColor *)colorForIndex:(NSInteger)index
{
    
    UIColor *color = [UIColor whiteColor];
    switch (index) {
        case 0:
        {
            color = [UIColor colorWithHexString:@"47aee6"];
        }
            break;
        case 1:
        {
            color = [UIColor colorWithHexString:@"67d31b"];
        }
            break;
        case 2:
        {
            color = [UIColor colorWithHexString:@"ffa76d"];
        }
            break;
        case 3:
        {
            color = [UIColor colorWithHexString:@"f2d209"];
        }
            break;
            
        default:
            break;
    }
    return color;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ServiceClass *class = [dataArray objectAtIndex:indexPath.section];
//    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
//    
//    ServiceClass *class_sub = [sub objectAtIndex:indexPath.row];
//    
//    ServiceListController *detailViewController = [[ServiceListController alloc] initWithNibName:@"ServiceListController" bundle:nil];
//    detailViewController.aType = list_other;
//    detailViewController.cid = class_sub.id;
//    detailViewController.service_sub_name = class_sub.name;
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceClass *class = [dataArray objectAtIndex:indexPath.section];
    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
    
    return sub.count > 5 ? 130 : 80;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
