//
//  BusinessViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BusinessViewController.h"

#import "BusinessDetailViewController.h"

@interface BusinessViewController ()

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor purpleColor];

    self.titleLabel.text=@"服务商家";
    
    
    [self setSectionView];
    
    
    
}

-(void)setSectionView{
    
    NSLog(@"xxx==%f",ALL_FRAME_WIDTH);
    
    self.view.backgroundColor=[UIColor redColor];

    arrtitle=@[@"东直门",@"汽车美容",@"默认排序"];
    for (int i=0; i<3; i++) {
        UIButton *testButton=[LTools createButtonWithType:UIButtonTypeCustom frame:CGRectMake(i*ALL_FRAME_WIDTH/3, 0, ALL_FRAME_WIDTH/3 , 30) normalTitle:arrtitle[i] image:nil backgroudImage:nil superView:self.view target:self action:@selector(dobutton:)];
        testButton.tag=800+i;
        
        [self.view addSubview:testButton];
    }
    
    UIView *viewLine=[[UIView alloc]initWithFrame:CGRectMake(0, 30, SELFVIEWWIDTH, 0.5)];
    viewLine.backgroundColor=RGBCOLOR(140, 150, 160);
    [self.view addSubview:viewLine];

}

-(void)dobutton:(UIButton *)sender{
    
    BusinessDetailViewController *detailVC=[[BusinessDetailViewController alloc]init];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:detailVC animated:YES];

    switch (sender.tag) {
        case 800:
        {
        
            NSLog(@"点击选择地区");
            
            
        }
            break;
        case 801:
        {
            
            NSLog(@"点击选择服务类别");
        }
            break;

        case 802:
        {
            
            NSLog(@"默认排序");
        }
            break;

            
        default:
            break;
    }

    

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
