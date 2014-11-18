//
//  ServiceListController.h
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FBBaseViewController.h"

typedef enum {
    
    list_business = 1,
    list_other
    
}List_Type;

@interface ServiceListController : FBBaseViewController

@property(nonatomic,assign)int cid;//服务id
@property(nonatomic,retain)NSString *service_sub_name;//二级服务name

@property(nonatomic,assign)List_Type aType;

@end
