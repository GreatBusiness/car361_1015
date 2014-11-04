//
//  ServiceClass.h
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceClass : BaseModel

//一级服务
@property(nonatomic,assign)int pid;
@property(nonatomic,retain)NSString *pname;
@property(nonatomic,retain)NSArray *content;

//二级服务

@property(nonatomic,assign)int id;
@property(nonatomic,retain)NSString *name;

@end
