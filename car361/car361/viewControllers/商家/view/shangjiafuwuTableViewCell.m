//
//  shangjiafuwuTableViewCell.m
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "shangjiafuwuTableViewCell.h"

@implementation shangjiafuwuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    ///自动生成注释？
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        self.nameLabel=[LTools createLabelFrame:CGRectMake(6, 12, 90, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.nameLabel];
        
        
        self.priceLabel=[LTools createLabelFrame:CGRectMake(100, 12, 60, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor orangeColor]];
        [self addSubview:self.priceLabel];
        
        self.tradeLabel=[LTools createLabelFrame:CGRectMake(160, 12, 100, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:self.tradeLabel];
        
        self.scoreLabel=[LTools createLabelFrame:CGRectMake(ALL_FRAME_WIDTH-12-40, 12, 40 , 20) title:@"" font:14 align:NSTextAlignmentRight textColor:[UIColor blueColor]];
        [self addSubview:self.scoreLabel];
        
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 43.5, 320-24, 0.5)];
        viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:viewline];
        
    }
    return self;
}




-(void)setSubviewWithModel:(ShangjiafuwuModel *)theChangshimodel{
    
    self.nameLabel.text=theChangshimodel.name;
    self.priceLabel.text=[NSString stringWithFormat:@"￥%@",theChangshimodel.price];
    self.tradeLabel.text=[NSString stringWithFormat:@"%@人已选择",theChangshimodel.trade];
    self.scoreLabel.text=theChangshimodel.score;
    
    
}



@end
