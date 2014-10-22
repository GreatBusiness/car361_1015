//
//  UserCommentModel.m
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "UserCommentModel.h"

@implementation UserCommentModel

-(UserCommentModel *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        _thedetailid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        self.shopid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"shopid"]];
        self.infoid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"infoid"]];
        self.nickname=[NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
        
        self.content=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        self.rating=[NSString stringWithFormat:@"%@",[dic objectForKey:@"rating"]];
        self.dateline=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dateline"]];

    }
    
    return self;
}






@end
