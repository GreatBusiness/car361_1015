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
        
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(25, 12, 25, 25)];
        _imageV.layer.cornerRadius = 5;
        self.imageV.backgroundColor=[UIColor clearColor];
        [self addSubview:self.imageV];
        
        self.nickNameLabel=[LTools createLabelFrame:CGRectMake(_imageV.right + 10, 12, 60, 16) title:@"" font:8 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nickNameLabel];
        
        //评价星星
        self.startView = [[UIView alloc]initWithFrame:CGRectMake(_nickNameLabel.right + 10, 12, 40, 16)];
        _startView.backgroundColor = [UIColor clearColor];
        [self addSubview:_startView];
        
        //服务类型
        self.serviceTypeLabel = [LTools createLabelFrame:CGRectMake(_startView.right + 10, 12, 50, 16) title:nil font:8 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:_serviceTypeLabel];
        
        //服务花费
        self.priceLabel = [LTools createLabelFrame:CGRectMake(_serviceTypeLabel.right + 10, 12, 100, 16) title:nil font:8 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:_priceLabel];
        
        //评论正文
        self.contentLabel=[LTools createLabelFrame:CGRectMake(_nickNameLabel.left, 28, ALL_FRAME_WIDTH - 60 - 30, 20) title:@"" font:8 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:self.contentLabel];
        
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        
        self.viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 47.5, ALL_FRAME_WIDTH - 24, 0.5)];
        self.viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:self.viewline];
        
    }
    return self;
}

-(void)setSubviewWithModel:(UserCommentModel *)theChangshimodel{
    

    self.nickNameLabel.text=theChangshimodel.nickname;
    self.rateLabel.text=theChangshimodel.rating;
    
    //服务类型
    self.serviceTypeLabel.text = [NSString stringWithFormat:@"服务类型:%@",@""];
    //服务花费
    
    NSString *price = [NSString stringWithFormat:@"￥100"];
    
    NSString *price_2 = [NSString stringWithFormat:@"服务花费:%@",price];
    
    self.priceLabel.attributedText = [LTools attributedString:price_2 keyword:price color:RGBCOLOR(138, 223, 63)];
    
    self.contentLabel.text=theChangshimodel.content;
    
    CGFloat aHeight = [LTools heightForText:theChangshimodel.content width:ALL_FRAME_WIDTH - 24 font:8];
    
    self.contentLabel.height = aHeight;
    
}


@end
