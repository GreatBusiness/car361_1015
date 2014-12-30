//
//  DetailViewController.h
//  car361
//
//  Created by szk on 14/12/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FBBaseViewController.h"

@interface DetailViewController : FBBaseViewController<UIWebViewDelegate>{
    
    UIWebView *theWebV;
    
    MBProgressHUD *hudView;
}

@property(nonatomic,strong)NSString *str_urllink;



@end
