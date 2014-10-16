//
//  ChangshiModel.h
//  car361
//
//  Created by szk on 14-10-16.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangshiModel : NSObject

/*
 
 id: "6821",
 classid: "24",
 title: "揭开保养上的错误观点",
 stitle: "揭开保养上的错误观点",
 summarys: "提醒车主正确对待爱车",
 summary: "提醒车主正确对待爱车，不仅避开不经意间毁了爱车，更重要的是保证行车的安全。",
 summaryb: "很多车主在购买车前，通常会查阅很多资料，或者询问身边的亲朋好友，随着用车的时间越久，虽然心里还是非常在乎自己的爱车，但是平常除了清洗爱车，其他的事情也就能省则省了。提醒车主正确对待爱车，不仅避开不经意间毁了爱车，更重要的是保证行车的安全。",
 photo: "http://www.car361.cn/attachments/20140311/1394506138.jpg.160x120.jpg",
 classname: ""
 
 */

@property(nonatomic,strong)NSString *thedetailid;

@property(nonatomic,strong)NSString *classid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *stitle;
@property(nonatomic,strong)NSString *summarys;
@property(nonatomic,strong)NSString *summary;

@property(nonatomic,strong)NSString *summaryb;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *classname;


-(ChangshiModel *)initWithDictionary:(NSDictionary *)dic;


@end
