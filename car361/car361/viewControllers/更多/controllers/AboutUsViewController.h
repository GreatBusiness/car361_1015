//
//  AboutUsViewController.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FBBaseViewController.h"

@interface AboutUsViewController : FBBaseViewController<UIWebViewDelegate>{
    
    UIWebView *theWebV;
    
    MBProgressHUD *hudView;
}


@end
