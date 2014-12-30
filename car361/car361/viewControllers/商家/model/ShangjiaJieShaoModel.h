//
//  ShangjiaJieShaoModel.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangjiaJieShaoModel : NSObject
/*address = "\U5317\U4eac\U5e02\U671d\U9633\U533a\U91d1\U8749\U897f\U8def\U7532\U4e00\U53f7\U9177\U8f66\U5c0f\U9547B1-1\U53f7";
 area = 16;
 city = 1;
 commend = 0;
 content = "<p><p>&nbsp;&nbsp;&nbsp;&nbsp;\U5317\U4eac\U901f\U8f66\U5546\U8d38\U6709\U9650\U516c\U53f8\U662f\U4e00\U5bb6\U9ad8\U6807\U51c6\U3001\U4e13\U4e1a\U5316\U7684\U6c7d\U8f66\U670d\U52a1\U673a\U6784\Uff0c\U7531\U6c7d\U8f66\U6539\U88c5\U5148\U9a71\U5e97\U548c\U53e3\U7891\U5353\U8d8a\U3001\U5b9e\U529b\U8d85\U7fa4\U7684\U6c7d\U8f66\U88c5\U9970\U7f8e\U5bb9\U5e97\U91cd\U7ec4\U800c\U6210\Uff0c\U603b\U90e8\U4f4d\U4e8e\U5317\U4eac\U5e02\U671d\U9633\U533a\U91d1\U8749\U897f\U8def\U7532\U4e00\U53f7\U9177\U8f66\U5c0f\U9547\U3002\U516c\U53f8\U8425\U4e1a\U9762\U79ef800\U5e73\U65b9\U7c73\Uff0c\U62e5\U6709\U4e09\U4e2a\U5168\U5c01\U95ed\U7684\U667a\U80fd\U65e0\U5c18\U8d34\U819c\U8f66\U95f4\Uff0c\U4e24\U4e2a\U5c01\U95ed\U7684\U6c7d\U8f66\U7f8e\U5bb9\U8f66\U95f4\Uff0c\U4e00\U4e2a\U5c01\U95ed\U7684\U5e95\U76d8\U88c5\U7532\U8f66\U95f4\U548c\U4e24\U4e2a\U4e13\U4e1a\U6539\U88c5\U8f66\U95f4\Uff0c\U5e76\U7cbe\U5fc3\U51c6\U5907\U4e86\U5bbd\U655e\U8212\U9002\U7684\U5ba2\U6237\U4f11\U606f\U3001\U5a31\U4e50\U3001\U4f53\U9a8c\U533a\Uff0c\U529b\U6c42\U7ed9\U5ba2\U6237\U521b\U9020\U5bb6\U7684\U6c1b\U56f4\Uff0c\U516c\U53f8\U8d34\U819c\U3001\U9540\U819c\U3001\U6539\U88c5\U7b49\U5c97\U4f4d\U6280\U5e08\U5747\U6709\U5341\U5e74\U4ee5\U4e0a\U4ece\U4e1a\U7ecf\U9a8c\Uff0c\U5e76\U66fe\U5728\U4e13\U4e1a\U9886\U57df\U6280\U672f\U7ade\U8d5b\U4e2d\U9886\U5148\Uff0c\U5728\U5de5\U4f5c\U4e2d\U66f4\U662f\U521b\U4e0b\U8d6b\U8d6b\U4f73\U7ee9\U3002<br />&nbsp;&nbsp;&nbsp;&nbsp;\U672c\U7740\U201c\U7cbe\U65e0\U6b62\U5883\U201d\U7684\U670d\U52a1\U5b97\U65e8\Uff0c\U5317\U4eac\U901f\U8f66\U5546\U8d38\U6709\U9650\U516c\U53f8\U81f4\U529b\U4e8e\U521b\U7acb\U89c4\U8303\U5316\U3001\U4e13\U4e1a\U5316\U3001\U54c1\U724c\U5316\U7684\U7ecf\U8425\U7406\U5ff5\Uff0c\U9707\U64bc\U63a8\U51fa\U201c\U9177\U8f66\U68a6\U5de5\U573a\U201d\U5f3a\U52bf\U54c1\U724c\Uff0c\U73b0\U5df2\U7ecf\U5f62\U6210\U7acb\U8db3\U6c7d\U8f66\U88c5\U9970\U3001\U6df1\U5316\U6c7d\U8f66\U7f8e\U5bb9\U3001\U62d3\U5c55\U6c7d\U8f66\U6539\U88c5\U7684\U6218\U7565\U683c\U5c40\U3002\U516c\U53f8\U4ee5\U96c4\U539a\U7684\U8d44\U91d1\U5b9e\U529b\U3001\U9ad8\U7d20\U8d28\U7684\U4e13\U4e1a\U4eba\U624d\U548c\U4f18\U8d28\U9ad8\U6548\U7684\U670d\U52a1\U5728\U884c\U4e1a\U5185\U6811\U7acb\U8d77\U4e86\U826f\U597d\U7684\U4f01\U4e1a\U5f62\U8c61\Uff0c\U53d7\U5230\U4e86\U793e\U4f1a\U5404\U754c\U4e0e\U5e7f\U5927\U4eac\U57ce\U8f66\U4e3b\U7684\U666e\U904d\U9752\U7750\U4e0e\U8d5e\U626c\Uff0c\U6210\U4e3a\U8f66\U4e3b\U4eec\U5728\U6c7d\U8f66\U8d34\U819c\U3001\U6c7d\U8f66\U9540\U819c\U3001\U5e95\U76d8\U88c5\U7532\U548c\U6c7d\U8f66\U6539\U88c5\U7b49\U65b9\U9762\U662f\U4e0d\U4e8c\U7684\U9996\U9009\U3002<br />&nbsp;&nbsp;&nbsp;&nbsp;\U516c\U53f8\U672a\U6765\U53d1\U5c55\U4e2d\U575a\U6301\U5949\U884c\U201c\U8bda\U4fe1\U7b2c\U4e00\Uff0c\U670d\U52a1\U81f3\U4e0a\Uff0c\U4e13\U4e1a\U9ad8\U6548\Uff0c\U5171\U8d62\U63d0\U5347\U201d\U7684\U6838\U5fc3\U4ef7\U503c\U89c2\Uff0c\U7ee7\U7eed\U53d1\U626c\U201c\U7cbe\U76ca\U6c42\U7cbe\Uff0c\U521b\U5148\U5360\U4f18\U201d\U7684\U4f01\U4e1a\U7cbe\U795e\Uff0c\U4e0d\U65ad\U521b\U65b0\Uff0c\U4ee5\U5353\U8d8a\U7684\U4ea7\U54c1\U3001\U7cbe\U6e5b\U7684\U6280\U672f\U548c\U6ee1\U610f\U7684\U670d\U52a1\U56de\U62a5\U60a8\U5bf9\U6211\U4eec\U7684\U4fe1\U4efb\U4e0e\U652f\U6301\U3002<br />&nbsp;&nbsp;&nbsp;&nbsp;\U8ba9\U5e7f\U5927\U4eac\U57ce\U8f66\U4e3b\U7231\U8f66\U88c5\U9970\U3001\U7f8e\U5bb9\U3001\U6539\U88c5\U66f4\U52a0\U7b80\U5355\U3001\U8fc5\U6377\U3001\U8d34\U5fc3\U3001\U6ee1\U610f\U662f\U6211\U4eec\U4e0d\U61c8\U52aa\U529b\U7684\U76ee\U6807\Uff01</p></p>";
 id = 2;
 lat = "39.873741149902";
 level = 0;
 lng = "116.490737915039";
 name = "\U9177\U8f66\U68a6\U5de5\U573a";
 otherid = 118505;
 photo = "http://www.car361.cn/static/service/118505.jpg";
 region = 15;
 score = 5;
 score1 = 8;
 score2 = 8;
 score3 = 8;
 telphone = "010-67377997";
 time = "9:00-18:00";*/


@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *area;//名字
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *commend;


@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSString *htmlsrngcontent;

@property(nonatomic,strong)NSString *thedetaid;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *level;

@property(nonatomic,strong)NSString *lng;
@property(nonatomic,strong)NSString *name;//名字
@property(nonatomic,strong)NSString *otherid;
@property(nonatomic,strong)NSString *photo;


@property(nonatomic,strong)NSString *region;
@property(nonatomic,strong)NSString *score;//价格
@property(nonatomic,strong)NSString *score1;//评分
@property(nonatomic,strong)NSString *score2;

@property(nonatomic,strong)NSString *score3;//具体介绍
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *time;//名字


-(ShangjiaJieShaoModel *)initWithDictionary:(NSDictionary *)dic;


@end
