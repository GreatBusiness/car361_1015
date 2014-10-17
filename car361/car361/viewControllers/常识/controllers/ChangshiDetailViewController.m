//
//  ChangshiDetailViewController.m
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ChangshiDetailViewController.h"

@interface ChangshiDetailViewController ()

@end

@implementation ChangshiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    theWebV=[[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:theWebV];
    
    theWebV.delegate=self;
//    
//    [theWebV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.car361.cn/api.php?c=listnews&a=shownews&id=%@&type=json",self.theid]]]];
    
    
    [self loadChangshiData];
    
    
    
    
    
}

#pragma mark--获取网络数据

-(void)loadChangshiData{

    
    
    
    SzkLoadData *loadda=[[SzkLoadData alloc]init];
    
    __weak typeof(theWebV) weakweb=theWebV;
    
    
    [loadda SeturlStr:[NSString stringWithFormat:@"http://www.car361.cn/api.php?c=listnews&a=shownews&id=%@&type=json",self.theid] mytest:^(NSDictionary *dicinfo, int errcode) {
        
 
        NSLog(@"theinfo===%@",dicinfo);
        
        NSString *strhtml=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"allcontent"]];
        
        [weakweb loadHTMLString:strhtml baseURL:nil];
        
    }];
    
    
    
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
