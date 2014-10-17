//
//  MiddleViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MiddleViewController.h"

@interface MiddleViewController ()

@end

@implementation MiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    theWebV=[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:theWebV];
    
    theWebV.delegate=self;
    
    [theWebV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.car361.cn/wap/event/index.php"]]];
    
    
    
    
    
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    hudView=[LTools MBProgressWithText:LOADING_TITLE addToView:self.view];


    [hudView show:YES];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [hudView hide:YES afterDelay:0.4f];

    
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{


    
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
