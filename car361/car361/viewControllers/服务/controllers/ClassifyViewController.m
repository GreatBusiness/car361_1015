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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ServiceClass *class = [dataArray objectAtIndex:section];
    return class.pname;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    ServiceClass *class = [dataArray objectAtIndex:section];
    
    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];
    
    return sub.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    ServiceClass *class = [dataArray objectAtIndex:indexPath.section];
    NSArray *sub = [DataManager getServiceSubForRegionId:class.pid];

    ServiceClass *class_sub = [sub objectAtIndex:indexPath.row];
    
    cell.textLabel.text = class_sub.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ServiceListController *detailViewController = [[ServiceListController alloc] initWithNibName:@"ServiceListController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
