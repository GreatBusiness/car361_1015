//
//  ShangjiaJieShaoModel.m
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShangjiaJieShaoModel.h"

@implementation ShangjiaJieShaoModel

-(ShangjiaJieShaoModel *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        self.address=[NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
        self.area=[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
        self.city=[NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]];
        self.commend=[NSString stringWithFormat:@"%@",[dic objectForKey:@"commend"]];

        self.content=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        self.thedetaid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        self.lat=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lat"]];
        self.level=[NSString stringWithFormat:@"%@",[dic objectForKey:@"level"]];

        self.lng=[NSString stringWithFormat:@"%@",[dic objectForKey:@"lng"]];
        self.name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        self.otherid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"otherid"]];
        self.photo=[NSString stringWithFormat:@"%@",[dic objectForKey:@"photo"]];

        self.region=[NSString stringWithFormat:@"%@",[dic objectForKey:@"region"]];
        self.score=[NSString stringWithFormat:@"%@",[dic objectForKey:@"score"]];
        self.score1=[NSString stringWithFormat:@"%@",[dic objectForKey:@"score1"]];
        self.score2=[NSString stringWithFormat:@"%@",[dic objectForKey:@"score2"]];

        self.score3=[NSString stringWithFormat:@"%@",[dic objectForKey:@"score3"]];
        self.telphone=[NSString stringWithFormat:@"%@",[dic objectForKey:@"telphone"]];
        self.time=[NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];

        
        
    }
    
    return self;
}



@end
