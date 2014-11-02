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

@interface ServiceListController ()<UITableViewDataSource,RefreshDelegate>
{
    UIView *menu_back;//选项卡
    MenuSortView *sortView;//排序列表
    ListTable *areaTable;//地区列表
    ListTable *classTable;//服务分类列表
}

@property(nonatomic,retain)RefreshTableView *table;

@end

@implementation ServiceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createMenuViews];
    [self createAreaAndClassMenu];
    [self createSortMenu];
    
    
    //数据展示table
    _table = [[RefreshTableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_SIZE.width, SCREEN_SIZE.height  - 49 - 36)];
    _table.refreshDelegate = self;
    _table.dataSource = self;
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
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
    
    CGFloat awidth = ALL_FRAME.size.width / 3.f;
    NSArray *titles = @[@"东直门",@"汽车美容",@"默认排序"];
    for (int i = 0; i < 3; i ++) {
        
        UIButton *menu_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        menu_btn.frame = CGRectMake(awidth * i, 0, awidth, menu_back.height);
        [menu_btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [menu_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [menu_back addSubview:menu_btn];
        [menu_btn setImage:[UIImage imageNamed:@"hornxia"] forState:UIControlStateNormal];
        [menu_btn setImage:[UIImage imageNamed:@"hornxiahover"] forState:UIControlStateSelected];
        
        [menu_btn setTitleColor:[UIColor colorWithHexString:@"515151"] forState:UIControlStateNormal];
        [menu_btn setTitleColor:[UIColor colorWithHexString:@"54ad13"] forState:UIControlStateSelected];
        
        [menu_btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - 5, 0, 0)];
        [menu_btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,  - awidth - 50 + 30)];
        
        menu_btn.tag = 100 + i;
        
        [menu_btn addTarget:self action:@selector(clickToOpenMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createAreaAndClassMenu
{
    areaTable = [[ListTable alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, ALL_FRAME.size.height - 30 - menu_back.bottom - 64) listType:List_Area];
    [self.view addSubview:areaTable];
    [areaTable actionBlock:^(ActionType type, NSString *select) {
        if (type == Action_Back) {
            
            //            self.btn.selected = NO;

        }else if (type == Action_Select){

            NSLog(@"select %@",select);
        }
    }];
    
    
    classTable = [[ListTable alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, ALL_FRAME.size.height - 30 - menu_back.bottom - 64) listType:List_Service];
    [self.view addSubview:classTable];
    [classTable actionBlock:^(ActionType type, NSString *select) {
        if (type == Action_Back) {
            
            
        }else if (type == Action_Select){
            
            NSLog(@"select %@",select);
        }
    }];

}

- (void)createSortMenu
{
    __weak typeof(self)weakSelf = self;
    NSArray *titles = @[@"默认排序",@"距离最近",@"价格由小到大",@"价格由大到小",@"选择人数",@"评价最高",@"最近发布"];
    sortView = [[MenuSortView alloc]initWithFrame:CGRectMake(0, menu_back.bottom, ALL_FRAME.size.width, 0) titles:titles sortBlock:^(int tag, NSString *sortName, int sortId) {
        
        if (tag == 0) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:102];
            [weakSelf clickToOpenMenu:btn];
            
        }else if (tag == 1){
         
            NSLog(@"sort %@ id %d",sortName,sortId);
        }
        
    }];
    [self.view addSubview:sortView];
}

#pragma mark - 事件处理

- (void)clickToOpenMenu:(UIButton *)sender
{
    for (int i = 0; i < 3; i ++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i + 100];
        if (btn == sender) {
            btn.selected = !btn.selected;
        }else
        {
            btn.selected = NO;
        }
        
        if (sender.tag == 100) {
            
            [sortView show:NO];
            [classTable showOrHidden:NO];
            [areaTable showOrHidden:sender.selected];
            
        }else if (sender.tag == 101){
            
            [sortView show:NO];
            [classTable showOrHidden:sender.selected];
            [areaTable showOrHidden:NO];
            
        }else if (sender.tag == 102){
        
            [sortView show:sender.selected];
            [classTable showOrHidden:NO];
            [areaTable showOrHidden:NO];
        }
        
    }
}

#pragma mark - 网络请求

#pragma - mark RefreshDelegate <NSObject>

- (void)loadNewData
{
    NSLog(@"loadNewData");
    
    
}

- (void)loadMoreData
{
    NSLog(@"loadMoreData");
    
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)heightForRowIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CarSourceCell";
    
    ServiceCell *cell = (ServiceCell *)[LTools cellForIdentify:identifier cellName:@"ServiceCell" forTable:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}



@end
