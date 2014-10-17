//
//  AboutUsViewController.m
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    theWebV=[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:theWebV];
    
    theWebV.delegate=self;
    
    [theWebV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.car361.cn/wap/about/index.php"]]];
    
    
    
    
    
    
    
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
