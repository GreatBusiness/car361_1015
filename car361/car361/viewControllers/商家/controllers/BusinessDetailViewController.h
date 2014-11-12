//
//  BusinessDetailViewController.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FBBaseViewController.h"

#import "FuwujieshaoModel.h"

#import "ShangjiaJieShaoModel.h"

#import "ShangjiafuwuModel.h"


@interface BusinessDetailViewController : FBBaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray *arrtitle;//上面切换的四个title
    
    UIScrollView *mainScroV;
    
    //关于tableview的
    
    NSMutableArray *allArr;
    
    MBProgressHUD *hudView;
    
    
    UITableView *mainTabV;//商家服务的tableview
    
    //关于用户评论的
    
    NSMutableArray *commentArr;
    UITableView *secondTab;
    
    int currentpage;
    
}

//@property(nonatomic,strong)NSString *stringId;

@property(nonatomic,strong)NSString *infoId;//信息id
@property(nonatomic,strong)NSString *shopId;//商家id

@property(nonatomic,strong)UITableView *fuwujieshaoTabVC;

@end
