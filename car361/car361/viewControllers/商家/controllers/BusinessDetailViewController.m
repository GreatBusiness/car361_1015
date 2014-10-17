//
//  BusinessDetailViewController.m
//  car361
//ss
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BusinessDetailViewController.h"

#import "FuwujieshaoModel.h"

#import "FuwujieshaoView.h"

@interface BusinessDetailViewController (){

    
    FuwujieshaoView *_fuwujieshaoV;
}

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    self.titleLabel.text=@"服务商家";
    
    
  [self setSectionView];
    
    [self setFuwujieshaoTabVCC];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

-(void)setSectionView{
    
    NSLog(@"xxx==%f",ALL_FRAME_WIDTH);
    
    
    
    arrtitle=@[@"服务介绍",@"商家介绍",@"商家服务",@"用户评价"];
    for (int i=0; i<4; i++) {
        UIButton *testButton=[LTools createButtonWithType:UIButtonTypeCustom frame:CGRectMake(i*ALL_FRAME_WIDTH/4, 0,-0.5+ ALL_FRAME_WIDTH/4 , 30) normalTitle:arrtitle[i] image:nil backgroudImage:nil superView:self.view target:self action:@selector(dobutton:)];
        testButton.tag=800+i;
        [self.view addSubview:testButton];
        
        UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake((i+1)*ALL_FRAME_WIDTH/4, 0, 0.5, 30)];
        viewLine.backgroundColor=RGBCOLOR(180, 180, 180);
        [self.view addSubview:viewLine];
        
    }
    
    UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(0, 30, SELFVIEWWIDTH, 0.5)];
    viewLine.backgroundColor=RGBCOLOR(140, 150, 160);
    [self.view addSubview:viewLine];
    
}

-(void)setFuwujieshaoTabVCC{

 FuwujieshaoView *   test=[[FuwujieshaoView alloc]initWiththeFrame:CGRectMake(0, 30, 320, ALL_FRAME.size.width)];
    test.tag=300;
    [self.view addSubview:test];
    

    [self loadFuwujieshaoData];

}

-(void)dobutton:(UIButton *)sender{
    
    switch (sender.tag) {
        case 800:
        {
            
            NSLog(@"点击服务介绍");
            
            [self loadFuwujieshaoData];
        }
            break;
        case 801:
        {
            
            NSLog(@"点击商家介绍");
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
    
    
    [loaddata SeturlStr:@"http://www.car361.cn/api.php?c=service&a=showinfo&id=2&type=json" mytest:^(NSDictionary *dicinfo, int errcode) {
        
        if (errcode==0) {
            
            NSLog(@"thedic===%@",dicinfo);
            
            FuwujieshaoModel *model=[[FuwujieshaoModel alloc]initWithDictionary:dicinfo];
            
            NSLog(@"thempde=name==%@",model.name);

//            model= [model initWithDictionary:dicinfo];
            

            [( FuwujieshaoView *)[self.view viewWithTag:300] settheMyModel:model];
        }

    }];
    

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
