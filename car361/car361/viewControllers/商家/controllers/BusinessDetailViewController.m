//
//  BusinessDetailViewController.m
//  car361
//ss
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BusinessDetailViewController.h"
//服务介绍
#import "FuwujieshaoModel.h"
#import "FuwujieshaoView.h"
//商家介绍
#import "ShangjiaJieShaoModel.h"
#import "ShangjiajieshaoView.h"
//商家服务
#import "ShangjiafuwuModel.h"
#import "shangjiafuwuTableViewCell.h"
//用户评价

#import "UserCommentModel.h"
#import "UserCommentTableViewCell.h"
#import "RatingBar.h"

#define SECTION_HEIGHT 35 //选项 高度

@interface BusinessDetailViewController (){
    
    
    FuwujieshaoView *_fuwujieshaoV;
    UIView *section_view;//选项view
    UIView *indicator_view;//选择指示器
}

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.titleLabel.text=@"服务商家";
    
    mainScroV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, SECTION_HEIGHT, ALL_FRAME_WIDTH,ALL_FRAME.size.height - SECTION_HEIGHT)];
    mainScroV.contentSize=CGSizeMake(ALL_FRAME_WIDTH*4, 0);
    mainScroV.delegate=self;
    mainScroV.pagingEnabled=YES;
    [self.view addSubview:mainScroV];
    
    currentpage=1;
    allArr=[NSMutableArray array];
    commentArr=[NSMutableArray array];
    
    [self setSectionView];
    
    [self setFuwujieshaoTabVCC];
    
    [self setShangjiajieshaoView];
    
    [self setShangjiaFuwuView];
    
    [self setUseCommentView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark 移动 指示器

- (void)moveIndicatorIndex:(int)index
{
    CGFloat aWidth = (ALL_FRAME_WIDTH - 20.f)/4;
    indicator_view.center = CGPointMake(10 + aWidth * index + aWidth / 2.f, indicator_view.center.y);
}

#pragma mark 创建视图

-(void)setSectionView{
    
    NSLog(@"xxx==%f",ALL_FRAME_WIDTH);
    
    section_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, SECTION_HEIGHT)];
    [self.view addSubview:section_view];
    
    UIView *firstLine=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 0.5, SECTION_HEIGHT)];
    firstLine.backgroundColor=RGBCOLOR(180, 180, 180);
    [section_view addSubview:firstLine];
    
    arrtitle=@[@"服务介绍",@"商家介绍",@"商家服务",@"用户评价"];
    for (int i=0; i<4; i++) {
        UIButton *testButton=[LTools createButtonWithType:UIButtonTypeCustom frame:CGRectMake(10 + i*(ALL_FRAME_WIDTH - 20.f) / 4, 0,(ALL_FRAME_WIDTH - 20.f)/4 - 0.5, SECTION_HEIGHT) normalTitle:arrtitle[i] image:nil backgroudImage:nil superView:self.view target:self action:@selector(dobutton:)];
        [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        testButton.tag = 800 + i;
        [testButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [section_view addSubview:testButton];
        
        UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(testButton.right, 0, 0.5, SECTION_HEIGHT)];
        viewLine.backgroundColor=RGBCOLOR(180, 180, 180);
        [section_view addSubview:viewLine];
    }
    
    UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(0, SECTION_HEIGHT - 0.5f, ALL_FRAME_WIDTH, 0.5)];
    viewLine.backgroundColor=RGBCOLOR(140, 150, 160);
    [section_view addSubview:viewLine];
    
    [self createIndicator];
    
}


//创建指示器

- (void)createIndicator
{
    indicator_view = [[UIView alloc]initWithFrame:CGRectMake(10, 0, (ALL_FRAME_WIDTH - 20.f)/4, SECTION_HEIGHT)];
    indicator_view.backgroundColor = [UIColor clearColor];
    [section_view addSubview:indicator_view];
    
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, indicator_view.width, 3)];
    greenView.backgroundColor = RGBCOLOR(119, 217, 53);
    [indicator_view addSubview:greenView];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0.5, indicator_view.bottom - 2, indicator_view.width - 1, 3)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [indicator_view addSubview:whiteView];
    
}

//服务介绍的View

-(void)setFuwujieshaoTabVCC{
    
    FuwujieshaoView *   test=[[FuwujieshaoView alloc]initWiththeFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME.size.height - SECTION_HEIGHT)];
    test.tag=300;
    [mainScroV addSubview:test];
    
    
    [self loadFuwujieshaoData];
    
}

//商家介绍的view

-(void)setShangjiajieshaoView{
    
    ShangjiajieshaoView *   test=[[ShangjiajieshaoView alloc]initWiththeFrame:CGRectMake(ALL_FRAME_WIDTH, 0, ALL_FRAME_WIDTH, ALL_FRAME.size.height - SECTION_HEIGHT)];
    test.tag=400;
    [mainScroV addSubview:test];
    [self loadShangjiajieshaoData];
    
    
}

//商家服务的View

-(void)setShangjiaFuwuView{
    
    mainTabV=[[UITableView alloc]initWithFrame:CGRectMake(2*ALL_FRAME_WIDTH, 0, ALL_FRAME_WIDTH, ALL_FRAME.size.height- SECTION_HEIGHT - 49)];
    [mainScroV addSubview:mainTabV];
    mainTabV.delegate=self;
    mainTabV.dataSource=self;
    mainTabV.separatorColor=[UIColor clearColor];
    [self loadChangshiData];
}

//用户评价的view

-(void)setUseCommentView{
    secondTab=[[UITableView alloc]initWithFrame:CGRectMake(3 * ALL_FRAME_WIDTH, 0, ALL_FRAME_WIDTH, ALL_FRAME.size.height- SECTION_HEIGHT - 49)];
    [mainScroV addSubview:secondTab];
    secondTab.delegate=self;
    secondTab.dataSource=self;
    secondTab.separatorColor=[UIColor clearColor];
    
    [self setSecondTabHeaderV];
    [self loadUsrCommentData];
}

-(void)setSecondTabHeaderV{

    NSArray *tempArr=[NSArray arrayWithObjects:@"评分：",@"用户名：",@"内容：", nil];
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, 140)];
    
    headerView.backgroundColor=[UIColor clearColor];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *theTempLabel=[LTools createLabelFrame:CGRectMake(12, 12 + i * (16 + 5), 60, 16) title:tempArr[i] font:14 align:NSTextAlignmentRight textColor:[UIColor grayColor]];
        theTempLabel.textAlignment=NSTextAlignmentRight;
        [headerView addSubview:theTempLabel];
        
        if (i < 2) {
            UITextView *textV=[[UITextView alloc]initWithFrame:CGRectMake(70, 35 + i * (21 + 5), 80+100*i, 18+30*i)];
            CALayer *layer=textV.layer;
            layer.masksToBounds=YES;
            layer.cornerRadius = 5.f;
            layer.borderColor=[UIColor greenColor].CGColor;
            layer.borderWidth = 0.5;
            layer.shadowColor=[[UIColor greenColor]CGColor];
            textV.tag=10000+i;
            [headerView addSubview:textV];
        }
        
    }
    UIButton *button=[LTools createButtonWithType:UIButtonTypeRoundedRect frame:CGRectMake(70, 115, 55, 16) normalTitle:@"提交" image:nil backgroudImage:nil superView:headerView target:self action:@selector(dotheCommitButton:)];
    
    button.layer.cornerRadius = 5.f;
    [button setBackgroundColor:RGBCOLOR(252, 100, 0)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(27 + 10, 5 + 5, 180, 20) theBloc:^(NSInteger theRateNumber) {
        
        NSLog(@"xx==%ld",(long)theRateNumber);
        
        button.tag=20+theRateNumber;
        
    }];
    bar.starNumber = 5;
    bar.backgroundColor=[UIColor clearColor];
    [headerView addSubview:bar];
    
    UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(0, 140 - 0.5, ALL_FRAME_WIDTH, 0.5)];
    viewline.backgroundColor=RGBCOLOR(230, 230, 230);
    [headerView addSubview:viewline];
    
    
    secondTab.tableHeaderView=headerView;

}

#pragma mark-提交评论

-(void)dotheCommitButton:(UIButton *)sender{
    
    UITextView *tt1=(UITextView *)[self.view viewWithTag:10000];
    
    UITextView *tt2=(UITextView *)[self.view viewWithTag:10001];
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    if (tt2.text.length!=0) {
        
        NSString *theStrUrl=[NSString stringWithFormat:@"http://www.car361.cn/api.php?c=service&a=commentadd&shopid=1&infoid=2&nickname=%@&content=%@&rating=%d&type=json" ,tt1.text,tt2.text,(int)sender.tag-20];
        
        NSLog(@"提交评论的地址===%@",theStrUrl);
        
        
        [loaddata SeturlStr:theStrUrl mytest:^(NSDictionary *dicinfo, int errcode) {
            
            if (errcode==0) {
                
                NSLog(@"thedic===%@",dicinfo);
                [LTools showMBProgressWithText:@"提交成功" addToView:self.view];
                
            }
            
        }];

        
    }else{
    
        [LTools showMBProgressWithText:@"请输入评论内容" addToView:self.view];
    }

}

#pragma mark--上面四个切换

-(void)dobutton:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        mainScroV.contentOffset=CGPointMake(ALL_FRAME_WIDTH*(sender.tag-800), 0);
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self moveIndicatorIndex:(int)sender.tag - 800];
    
    switch (sender.tag) {
        case 800:
        {
            
            NSLog(@"点击服务介绍");
            
            
            FuwujieshaoView *theTempView=( FuwujieshaoView *)[self.view viewWithTag:300];
            
            if (theTempView.scoreLabel.text.length==0) {
                [self loadFuwujieshaoData];
                
            }else{
                
                NSLog(@"已经有服务介绍的数据");
                
            }
            
            
        }
            break;
        case 801:
        {
            NSLog(@"点击商家介绍");
            
            
            ShangjiajieshaoView *theTempView=( ShangjiajieshaoView *)[self.view viewWithTag:400];
            
            if (theTempView.nameLabel.text.length==0) {
                [self loadShangjiajieshaoData];
                
            }else{
                
                NSLog(@"已经有服务介绍的数据");
                
            }
        }
            break;
            
        case 802:
        {
            
            NSLog(@"商家服务列表");
        }
            break;
        case 803:
        {
            
            NSLog(@"用户评价");
        }
            break;
            
            
            
        default:
            break;
    }
    
    
    
}

#pragma mark--取服务介绍数据

-(void)loadFuwujieshaoData{
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *url = [NSString stringWithFormat:CAR_SERVICE_INTRODUCE,self.infoId];
    
    [loaddata SeturlStr:url mytest:^(NSDictionary *dicinfo, int errcode) {
        
        if (errcode==0) {
            
            
            
            
            NSLog(@"thedic===%@",dicinfo);
            
            FuwujieshaoModel *model=[[FuwujieshaoModel alloc]initWithDictionary:dicinfo];
            
            [( FuwujieshaoView *)[self.view viewWithTag:300] settheMyModel:model];
        }
        
    }];
    
    
}

#pragma mark--获取商家介绍的数据

-(void)loadShangjiajieshaoData{
    
    //http://www.car361.cn/api.php?c=serviceshop&a=showinfo&shopid=2&type=json
    
    
    SzkLoadData *loaddata=[[SzkLoadData alloc]init];
    
    NSString *url = [NSString stringWithFormat:CAR_SHOP_INTRODUCE,self.shopId];
    
    [loaddata SeturlStr:url mytest:^(NSDictionary *dicinfo, int errcode) {
        
        if (errcode==0) {
            
            
            
            NSLog(@"thedic===%@",dicinfo);
            
            
            //
            ShangjiaJieShaoModel *hmodel=[[ShangjiaJieShaoModel alloc]initWithDictionary:dicinfo];
            [( ShangjiajieshaoView *)[self.view viewWithTag:400] settheMyModel:hmodel];
        }
        
    }];
    
    
    
}
#pragma mark-获取商家服务的数据

-(void)loadChangshiData{
    
    
    if (currentpage==1) {
        [allArr removeAllObjects];
        
        
    }
    
    hudView=[LTools MBProgressWithText:LOADING_TITLE addToView:self.view];
    
    
    [hudView show:YES];
    
    __weak typeof(hudView)weakview=hudView;
    
    
    SzkLoadData *loadda=[[SzkLoadData alloc]init];
    
    __weak typeof(mainTabV)weakmainTabV=mainTabV;
    
    NSString *url = [NSString stringWithFormat:CAR_SHOP_SERVICE,self.shopId];
    
    [loadda SeturlStr:url mytest:^(NSDictionary *dicinfo, int errcode) {
        
        [weakview hide:YES afterDelay:0.4];
        
        NSArray *array=(NSArray *)dicinfo;
        
        for (NSDictionary *dic in array) {
            NSLog(@"dic===%@==end=\n",dic);
            
            ShangjiafuwuModel *model=[[ShangjiafuwuModel alloc]initWithDictionary:dic];
            [allArr addObject:model];
        }
        
        [weakmainTabV reloadData];
        
        
    }];
    
    
    
}
#pragma mark--取用户评论的数据

-(void)loadUsrCommentData{
    
    hudView=[LTools MBProgressWithText:LOADING_TITLE addToView:self.view];
    
    [hudView show:YES];
    
    __weak typeof(hudView)weakview=hudView;
    
    
    SzkLoadData *loadda=[[SzkLoadData alloc]init];
    
    __weak typeof(secondTab)weakmainTabV=secondTab;
    
    [loadda SeturlStr:[NSString stringWithFormat:CAR_SHOP_COMMENT,self.infoId,currentpage] mytest:^(NSDictionary *dicinfo, int errcode) {
        
        [weakview hide:YES afterDelay:0.4];
        
        NSArray *array=(NSArray *)dicinfo;
        
        for (NSDictionary *dic in array) {
            NSLog(@"dic===%@==end=\n",dic);
            
            UserCommentModel *model=[[UserCommentModel alloc]initWithDictionary:dic];
            [commentArr addObject:model];
        }
        
        [weakmainTabV reloadData];
        
    }];
    
    
}




#pragma mark--tableviewMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView==mainTabV) {
        return allArr.count;
        
    }else{
        return commentArr.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==mainTabV) {
        return 44;
        
    }else{
        return 48;
        
    }
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==mainTabV) {
        static NSString *identifier=@"cell";
        
        shangjiafuwuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (!cell) {
            cell=[[shangjiafuwuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        
        if (allArr.count>0) {
            ShangjiafuwuModel *model=[allArr objectAtIndex:indexPath.row];
            
            
            
            [cell setSubviewWithModel:model];
            
        }
        
        return cell;
    }else{
        
        static NSString *identifier=@"cell";
        
        UserCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (!cell) {
            cell=[[UserCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        
        if (allArr.count>0) {
            UserCommentModel *model=[commentArr objectAtIndex:indexPath.row];
            [cell setSubviewWithModel:model];
            
        }
        
        return cell;
        
        
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShangjiafuwuModel *model=[allArr objectAtIndex:indexPath.row];
    
    
    //
    //    ChangshiDetailViewController *detailVC=[[ChangshiDetailViewController alloc]init];
    //    detailVC.theid=model.thedetailid;
    //    [self setHidesBottomBarWhenPushed:YES];
    //    [self.navigationController pushViewController:detailVC animated:YES];
    //
    
    
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
