//
//  BaseModel.m
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setValuesForKeysWithDictionary:dic];
        }
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"forUndefinedKey %@",key);
}

@end
