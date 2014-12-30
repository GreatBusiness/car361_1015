//
//  DetailViewController.m
//  car361
//
//  Created by szk on 14/12/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.titleLabel.text = @"优惠详情";
//    self.button_back.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    theWebV=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT  - 44)];
    
    [self.view addSubview:theWebV];
    
    theWebV.scalesPageToFit = YES;
    
    theWebV.delegate=self;
    
    [theWebV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.str_urllink]]];
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


#pragma mark-webview的代理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
//    NSLog(@"request.URL.relativeString====%@",request.URL.relativeString);
//    NSLog(@"request.URL.absoluteString====%@",request.URL.absoluteString);
//    if (request.URL.absoluteString.length>10) {
//        NSString *str_test=[request.URL.absoluteString substringToIndex:9];
//        NSLog(@"str_test=%@",str_test);
//        
//        
//        
//        if ([str_test isEqualToString:@"newslink:"]) {
//            
//            
//            
//            str_test=[request.URL.absoluteString substringFromIndex:9];
//            
//            NSLog(@"str===%@",str_test);
//            return NO;
//        }
//        
//    }
//    
//    
    
    
    //
    //  request.URL.absoluteString====si:http://img1.fblife.com/attachments1/month_1307/20130712_52cb7fe23659d1665229x01x1BQkPEpd.png.thumb.jpg
    
    return YES;
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
