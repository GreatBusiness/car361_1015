//
//  UserCommentTableViewCell.m
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "UserCommentTableViewCell.h"

@implementation UserCommentTableViewCell

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
        
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(6, 14, 20, 20)];
        self.imageV.backgroundColor=[UIColor redColor];
        [self addSubview:self.imageV];
        
        self.nickNameLabel=[LTools createLabelFrame:CGRectMake(50, 6, 60, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.nickNameLabel];
        
        
        self.rateLabel=[LTools createLabelFrame:CGRectMake(100, 6, 60, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor orangeColor]];
        [self addSubview:self.rateLabel];
        
        self.contentLabel=[LTools createLabelFrame:CGRectMake(50, 25, 300, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:self.contentLabel];
        
        
        
     self.viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 47.5, 320-24, 0.5)];
        self.viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:self.viewline];
        
    }
    return self;
}




-(void)setSubviewWithModel:(UserCommentModel *)theChangshimodel{
    

    self.nickNameLabel.text=theChangshimodel.nickname;
    self.rateLabel.text=theChangshimodel.rating;
    self.contentLabel.text=theChangshimodel.content;
    
    
    
}





@end
