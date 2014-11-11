//
//  ShopServiceController.m
//  car361
//
//  Created by lichaowei on 14/11/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShopServiceController.h"
#import "ShopServiceCell.h"

#import "ShopServiceClass.h"

@interface ShopServiceController ()
{
    NSArray *dataArray;
}

@end

@implementation ShopServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getServiceIntroduce];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络请求

- (void)getServiceIntroduce
{
    __weak typeof(self)weakSelf = self;
    LTools *tool = [[LTools alloc]initWithUrl:CAR_SHOP_SERVICE isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:result.count];
            for (NSDictionary *aDic in result) {
                
                ShopServiceClass *aService = [[ShopServiceClass alloc]initWithDictionary:aDic];
                [arr addObject:aService];
            }
            
            dataArray = [NSArray arrayWithArray:arr];
            
            [weakSelf.tableView reloadData];
            
        }
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"ShopServiceCell";
    
    ShopServiceCell *cell = (ShopServiceCell *)[LTools cellForIdentify:identify cellName:@"ShopServiceCell" forTable:tableView];
    
    ShopServiceClass *aService = [dataArray objectAtIndex:indexPath.row];
    [cell setCellWithModel:aService];
    
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
