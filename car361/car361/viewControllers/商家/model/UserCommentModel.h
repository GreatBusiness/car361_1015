//
//  UserCommentModel.h
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCommentModel : NSObject

/*{
 id: "9579",
 shopid: "1",
 infoid: "2",
 nickname: "r",
 content: "q",
 rating: "5",
 dateline: "2014-10-12",
 shopotherid: "0",
 infootherid: "0",
 rmemberid: "0",
 rmembername: "",
 stateNum: "0",
 rstar: "0.0",
 taidufen: "0",
 xiaoguofen: "0",
 xingjiabifen: "0",
 isName: "0",
 nameType: "",
 nameInfo: "",
 isCarSeries: "0",
 carSeriesName: "",
 RReplyDate: "0",
 rcontent: ""
 }/*/

@property(nonatomic,strong)NSString *thedetailid;
@property(nonatomic,strong)NSString *shopid;//名字
@property(nonatomic,strong)NSString *infoid;
@property(nonatomic,strong)NSString *nickname;//评论者的名字


@property(nonatomic,strong)NSString *content;//评论内容
@property(nonatomic,strong)NSString *rating;//评分
@property(nonatomic,strong)NSString *dateline;//评分

-(UserCommentModel *)initWithDictionary:(NSDictionary *)dic;


 


@end
