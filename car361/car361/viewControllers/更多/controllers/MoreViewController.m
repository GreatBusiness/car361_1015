//
//  MoreViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title=@"更多";
    
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
            
            
        }
            break;
        case 9001:
        {
            NSLog(@"意见反馈");

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

        }
            break;
            
        default:
            break;
    }



}

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
