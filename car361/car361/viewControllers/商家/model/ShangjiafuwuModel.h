//
//  ShangjiafuwuModel.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangjiafuwuModel : NSObject

/*id":"8","name":"\u73bb\u7483\u8d34\u819c","cid":"10","shopid":"2","otherid":"4464","price":"1280","score":"5","trade":"193","content":"*/


@property(nonatomic,strong)NSString *thedetailid;

@property(nonatomic,strong)NSString *name;//名字
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *shopid;


@property(nonatomic,strong)NSString *otherid;
@property(nonatomic,strong)NSString *price;//价格

@property(nonatomic,strong)NSString *score;//评分
@property(nonatomic,strong)NSString *trade;
@property(nonatomic,strong)NSString *content;//具体介绍


-(ShangjiafuwuModel *)initWithDictionary:(NSDictionary *)dic;



@end
