//
//  FuwujieshaoModel.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuwujieshaoModel : NSObject

/*
 
 {
 id: "2",
 name: "镀膜",
 cid: "4",
 shopid: "1",
 otherid: "9",
 price: "699",
 score: "4.9",
 trade: "316",
 content: "这是测试内容"
 }
 */



@property(nonatomic,strong)NSString *thedetailid;

@property(nonatomic,strong)NSString *name;//名字
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *shopid;


@property(nonatomic,strong)NSString *otherid;
@property(nonatomic,strong)NSString *price;//价格

@property(nonatomic,strong)NSString *score;//评分
@property(nonatomic,strong)NSString *trade;
@property(nonatomic,strong)NSString *content;//具体介绍

@property(nonatomic,strong)NSString *htmlcontent;


-(FuwujieshaoModel *)initWithDictionary:(NSDictionary *)dic;


@end
