//
//  CommonViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "CommonViewController.h"

#import "ChangshiModel.h"

#import "ChangshiTableViewCell.h"

#import "ChangshiDetailViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    mainTabV=[[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mainTabV];
    mainTabV.delegate=self;
    mainTabV.dataSource=self;
    mainTabV.separatorColor=[UIColor clearColor];
    
    allArr=[NSMutableArray array];
    
    currentpage=1;
    [self loadChangshiData];
    
}

#pragma mark--获取网络数据

-(void)loadChangshiData{
    

    if (currentpage==1) {
        [allArr removeAllObjects];
        
        
    }
    
    hudView=[LTools MBProgressWithText:LOADING_TITLE addToView:self.view];
    
    
    [hudView show:YES];
    
    __weak typeof(hudView)weakview=hudView;
    

    SzkLoadData *loadda=[[SzkLoadData alloc]init];
    
    __weak typeof(mainTabV)weakmainTabV=mainTabV;
    
    [loadda SeturlStr:[NSString stringWithFormat: @"http://www.car361.cn/api.php?c=listnews&a=listnews&classid=24&type=json&page=%d",currentpage] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        [weakview hide:YES afterDelay:0.4];
        
        NSArray *array=(NSArray *)dicinfo;
        
        for (NSDictionary *dic in array) {
            NSLog(@"dic===%@==end=\n",dic);
            
            ChangshiModel *model=[[ChangshiModel alloc]initWithDictionary:dic];
            [allArr addObject:model];
        }
        
        [weakmainTabV reloadData];
        
        
    }];

    

}

#pragma mark--tableviewMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return allArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 87;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    
    ChangshiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (!cell) {
        cell=[[ChangshiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (allArr.count>0) {
        ChangshiModel *model=[allArr objectAtIndex:indexPath.row];
        
        
        
        [cell setSubviewWithModel:model];
        
    }
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChangshiModel *model=[allArr objectAtIndex:indexPath.row];
    
    

    ChangshiDetailViewController *detailVC=[[ChangshiDetailViewController alloc]init];
    detailVC.theid=model.thedetailid;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
    


}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    [self setHidesBottomBarWhenPushed:NO];

    
    


}

- (void)viewWillDisappear:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
