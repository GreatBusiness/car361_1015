//
//  MoreViewController.m
//  car361
//sssss
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MoreViewController.h"

#import "UMFeedbackViewController.h"

#import "AboutUsViewController.h"


@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = @"更多";
    self.button_back.hidden = YES;
    
    NSArray *titleArr=@[@"清空缓存",@"意见反馈",@"版本更新",@"关于我们"];
    
    for (int i=0; i<4; i++) {
        UIButton *testButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 20+60*i, SELFVIEWWIDTH, 50)];
        testButton.tag=i+9000;
        
        UIView *theLineView=[[UIView alloc] initWithFrame:CGRectMake(0, 75+60*i, SELFVIEWWIDTH, 0.5)];
        theLineView.backgroundColor=RGBCOLOR(200, 200, 200);
        [self.view addSubview:theLineView];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, SELFVIEWWIDTH, 50)];
        [testButton addSubview:titleLabel];
        titleLabel.text=titleArr[i];
        
        UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gengduo_shouye_jiantou.png"]];
        imgV.center=CGPointMake(295, 25);
        [testButton addSubview:imgV];
        
        [testButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testButton];
        
        
        
    }
    
    
    
}

-(void)touchButton:(UIButton *)sender{
    

    switch (sender.tag) {
        case 9000:
        {
            NSLog(@"清空缓存");
            

            
          CGFloat mm=  [[SDImageCache sharedImageCache] getSize];
            
            
            [[SDImageCache sharedImageCache] clearDisk];
            

            
            UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"清理缓存%.2fk",mm/1000] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertV show];
            
        }
            break;
        case 9001:
        {
            NSLog(@"意见反馈");
            
            
            [self showNativeFeedbackWithAppkey:@"5440c181fd98c5a723000ea0"];
            

        }
            break;
        case 9002:
        {
            NSLog(@"版本更新");
            
            [LTools versionForAppid:@"605673005" Block:^(BOOL isNewVersion, NSString *updateUrl, NSString *updateContent) {
                
             NSLog(@"====isnew=%d======updataurl==%@==content=%@",isNewVersion,updateUrl,updateContent);
                
                UIAlertView *alertV=[[UIAlertView alloc]initWithTitle:@"版本有更新" message:updateContent delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"更新版本", nil];
                [alertV show];
                
                
            }];

        }
            break;
        case 9003:
        {
            NSLog(@"关于我们");
            
            AboutUsViewController *_aboutVC=[[AboutUsViewController alloc]init];
            
            [self setHidesBottomBarWhenPushed:YES];
            
            [self.navigationController pushViewController:_aboutVC animated:YES];
            

        }
            break;
            
        default:
            break;
    }



}


- (void)showNativeFeedbackWithAppkey:(NSString *)appkey {
    UMFeedbackViewController *feedbackViewController = [[UMFeedbackViewController alloc] initWithNibName:@"UMFeedbackViewController" bundle:nil];
    feedbackViewController.appkey = appkey;
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    //    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //    navigationController.navigationBar.translucent = NO;
    
    [self setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:feedbackViewController animated:YES];}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:NO];
    [self setHidesBottomBarWhenPushed:NO];
    
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}


#pragma mark--uialertviewMethod


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


    if (buttonIndex==0) {
        NSLog(@"取消");
    }else{
        NSLog(@"走你");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];

        

    }

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
