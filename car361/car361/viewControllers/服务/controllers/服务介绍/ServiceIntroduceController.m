//
//  ServiceIntroduceController.m
//  car361
//
//  Created by lichaowei on 14/11/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ServiceIntroduceController.h"
#import "IntroduceCell.h"

@interface ServiceIntroduceController ()
{
    UIWebView *web;
    NSString *content;
}

@end

@implementation ServiceIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    LTools *tool = [[LTools alloc]initWithUrl:CAR_SERVICE_INTRODUCE isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            
            content = [result objectForKey:@"content"];
            
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
    
    static NSString *identify = @"IntroduceCell";
    
    if (indexPath.row == 0) {
        
        IntroduceCell *cell = (IntroduceCell *)[LTools cellForIdentify:identify cellName:@"IntroduceCell" forTable:tableView];
        
        [cell setCellForModel:self.infoClass];
        
        return cell;
    }
    
    static NSString *identify2 = @"cellForWeb";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify2];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
        
        web = [[UIWebView alloc]init];
        web.backgroundColor = [UIColor whiteColor];
        web.tag = 1000;
        [cell.contentView addSubview:web];
//        web.scalesPageToFit = YES;
    }
    
    web.frame = CGRectMake(0, 0, ALL_FRAME.size.width, ALL_FRAME.size.height - 35 - 95 - 44);
    [web loadHTMLString:content baseURL:nil];
    
    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 95.f;
    }
    return ALL_FRAME.size.height - 35 - 95 - 44;
}

@end
