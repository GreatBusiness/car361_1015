//
//  FuwujieshaoView.m
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "FuwujieshaoView.h"

@implementation FuwujieshaoView

-(FuwujieshaoView *)initWiththeFrame:(CGRect)frame;
{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        self.titleArr=@[@"名字",@"价格",@"分值",@"已选人数",];
        
        for (int i=0; i<4; i++) {
            UILabel *testlabel=[LTools createLabelFrame:CGRectMake(0, i*20, 100, 20) title:self.titleArr[i] font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
            [self addSubview:testlabel];
            
        }
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(0, 80, ALL_FRAME_WIDTH, 0.5)];
        viewline.backgroundColor=RGBCOLOR(230, 230, 230);
        [self addSubview:viewline];
        
        
        
    }
    return self;
    
}
-(void)settheMyModel:(FuwujieshaoModel *)the_myModel{
    
    self.myModel=the_myModel;
    
    NSLog(@"thempde=name==%@",the_myModel.price);
    
    if (!self.nameLabel) {
        self.nameLabel=[LTools createLabelFrame:CGRectMake(140, 0, 100, 20) title:the_myModel.name font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.nameLabel];
    }else{
        self.nameLabel.text=the_myModel.name;
    
    }
    if (!self.priceLabel) {
        self.priceLabel=[LTools createLabelFrame:CGRectMake(140, 20, 100, 20) title:the_myModel.price font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.priceLabel];
    }else{
        self.priceLabel.text=the_myModel.price;
        
    }
    if (!self.scoreLabel) {
        self.scoreLabel=[LTools createLabelFrame:CGRectMake(140, 40, 100, 20) title:the_myModel.score font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.scoreLabel];
    }else{
        self.scoreLabel.text=the_myModel.score;
        
    }
    if (!self.tradeLabel) {
        self.tradeLabel=[LTools createLabelFrame:CGRectMake(140, 60, 100, 20) title:the_myModel.trade font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.tradeLabel];
    }else{
        self.tradeLabel.text=the_myModel.trade;
        
    }

    if (self.contentWebview) {
        self.contentWebview=[[RTLabel alloc]initWithFrame:CGRectMake(0, 80, ALL_FRAME_WIDTH , ALL_FRAME.size.height)];
        [self addSubview:self.contentWebview];
        [self.contentWebview setText:the_myModel.content];
    }else{
        [self.contentWebview setText:the_myModel.content];

    
    }
    
    self.contentSize=CGSizeMake(ALL_FRAME_WIDTH, self.contentWebview.optimumSize.height+80);
    
    
    
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
