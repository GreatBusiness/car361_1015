//
//  ShangjiafuwuModel.m
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShangjiafuwuModel.h"

@implementation ShangjiafuwuModel

-(ShangjiafuwuModel *)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        _thedetailid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        
        _name=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        _cid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"cid"]];
        _shopid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"shopid"]];
        _otherid=[NSString stringWithFormat:@"%@",[dic objectForKey:@"otherid"]];
        _price=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
        _score=[NSString stringWithFormat:@"%@",[dic objectForKey:@"score"]];
        _trade=[NSString stringWithFormat:@"%@",[dic objectForKey:@"trade"]];
        
        _content=[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
        
        
    }
    
    return self;
}




@end
