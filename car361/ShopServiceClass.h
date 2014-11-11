//
//  ShopServiceClass.h
//  car361
//
//  Created by lichaowei on 14/11/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"

//商家服务
@interface ShopServiceClass : BaseModel

@property(nonatomic,retain)NSString *id;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *cid;
@property(nonatomic,retain)NSString *shopid;
@property(nonatomic,retain)NSString *otherid;
@property(nonatomic,retain)NSString *price;
@property(nonatomic,retain)NSString *score;
@property(nonatomic,retain)NSString *trade;
@property(nonatomic,retain)NSString *content;


@end
