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


@interface BusinessDetailViewController : FBBaseViewController{
    NSArray *arrtitle;//上面切换的四个title
    
}

@property(nonatomic,strong)NSString *stringId;

@property(nonatomic,strong)UITableView *fuwujieshaoTabVC;

@end
