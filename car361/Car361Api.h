//
//  Car361Api.h
//  car361
//s
//  Created by lichaowei on 14-10-15.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#ifndef car361_Car361Api_h
#define car361_Car361Api_h
//---------------------------------------------------------------------------------------------------------
#pragma mark - KEY

#define KEY_COVER_IMAGE_URL @"cover_image_url"//封面图片地址

//---------------------------------------------------------------------------------------------------------
#pragma mark - 宏

//判断系统版本
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
//判断iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//---------------------------------------------------------------------------------------------------------
#pragma mark - 通知


//---------------------------------------------------------------------------------------------------------
#pragma mark - 接口api

//封面图片
#define CAR_APP_COVER @"http://www.car361.cn/api.php?c=misc&a=getcover&type=json"

//服务类别
#define CAR_SERVICE_CLSSES @"http://www.car361.cn/api.php?c=service&a=showindex&type=json"

#endif
