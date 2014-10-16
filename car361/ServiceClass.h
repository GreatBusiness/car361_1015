//
//  ServiceClass.h
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceClass : BaseModel

@property(nonatomic,retain)NSString *pid;
@property(nonatomic,retain)NSString *pname;
@property(nonatomic,retain)NSArray *content;

@end
