//
//  ShangjiajieshaoView.m
//  car361
//
//  Created by szk on 14-10-18.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShangjiajieshaoView.h"

@implementation ShangjiajieshaoView

-(ShangjiajieshaoView *)initWiththeFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        NSArray * titleArr=@[@"电话：",@"地址：",@"时间："];
        
        for (int i=0; i<3; i++) {
            UILabel *testlabel=[LTools createLabelFrame:CGRectMake(100,35+i*15, 100, 15) title:titleArr[i] font:12 align:NSTextAlignmentLeft textColor:[UIColor lightGrayColor]];
            [self addSubview:testlabel];
            
        }
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(0, 96, ALL_FRAME_WIDTH, 0.5)];
        viewline.backgroundColor=RGBCOLOR(230, 230, 230);
        [self addSubview:viewline];
        
        
        self.nameLabel=[LTools createLabelFrame:CGRectMake(100, 15, ALL_FRAME_WIDTH-100, 15) title:@"" font:15 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.nameLabel];
        
        self.telePhoneLabel=[LTools createLabelFrame:CGRectMake(130, 35, ALL_FRAME_WIDTH-100, 15) title:@"" font:12 align:NSTextAlignmentLeft textColor:[UIColor lightGrayColor]];
        [self addSubview:self.telePhoneLabel];
        
        self.addressLabel=[LTools createLabelFrame:CGRectMake(130, 35 + 15, ALL_FRAME_WIDTH-100, 15) title:@"" font:9 align:NSTextAlignmentLeft textColor:[UIColor lightGrayColor]];
        self.addressLabel.numberOfLines=0;
        [self addSubview:self.addressLabel];
        
        self.timeLabel=[LTools createLabelFrame:CGRectMake(130, 35 + 15 * 2, ALL_FRAME_WIDTH-100, 15) title:@"" font:12 align:NSTextAlignmentLeft textColor:[UIColor lightGrayColor]];
        [self addSubview:self.timeLabel];
        
        self.contnetWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 100, ALL_FRAME_WIDTH, ALL_FRAME.size.height-100-64)];
        [self addSubview:self.contnetWebView];
        
        
        //商家显示照片
        
        self.iiconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 80, 63)];
        
        [self addSubview:self.iiconImageView];
        
        
        
    }
    return self;
    
    


}

-(void)settheMyModel:(ShangjiaJieShaoModel *)the_myModel{
    
    self.nameLabel.text=the_myModel.name;
    
    self.telePhoneLabel.text=the_myModel.telphone;
    
    self.addressLabel.text=the_myModel.address;
    
    
    self.timeLabel.text=the_myModel.time;
    
    [self.contnetWebView loadHTMLString:the_myModel.content baseURL:nil];
    
    [self.iiconImageView sd_setImageWithURL:[NSURL URLWithString:the_myModel.photo] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    

    

}
@end
