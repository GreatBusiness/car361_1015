//
//  RegionClass.h
//  car361
//
//  Created by lichaowei on 14/11/4.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"

@interface RegionClass : BaseModel

//一级区
@property(nonatomic,assign)int regionid;
@property(nonatomic,retain)NSString *regionname;
@property(nonatomic,retain)NSArray *content;//存着下一级数据


//二级街道
@property(nonatomic,assign)int id;
@property(nonatomic,retain)NSString *name;

@property(nonatomic,assign)int parentId;//上一级id

@end
