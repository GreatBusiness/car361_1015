//
//  ShangjiajieshaoView.h
//  car361
//
//  Created by szk on 14-10-18.
//  Copyright (c) 2014年 lcw. All rights reserved.
//160 106

#import <UIKit/UIKit.h>

#import "ShangjiaJieShaoModel.h"

@interface ShangjiajieshaoView : UIView

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *telePhoneLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iiconImageView;

@property(nonatomic,strong)UIWebView *contnetWebView;


-(ShangjiajieshaoView *)initWiththeFrame:(CGRect)frame;

-(void)settheMyModel:(ShangjiaJieShaoModel *)the_myModel;


@end
