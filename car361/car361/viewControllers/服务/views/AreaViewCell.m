//
//  AreaViewCell.m
//  car361
//
//  Created by lichaowei on 14/11/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "AreaViewCell.h"

@implementation AreaViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self setcellView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (selected) {
        
        self.icon.image = [UIImage imageNamed:@"dibiao_cur"];
        self.leftGreenView.backgroundColor = [UIColor colorWithHexString:@"67d31b"];
        
    }else
    {
        if (self.indexPath.row == 0) {
            
            self.icon.image = [UIImage imageNamed:@"dibiao_fujin"];
        }else
        {
           self.icon.image = [UIImage imageNamed:@"dibiao_putong"];
        }
        
        self.leftGreenView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setcellView
{
    self.leftGreenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 44)];
    _leftGreenView.backgroundColor = [UIColor colorWithHexString:@"67d31b"];
    [self.contentView addSubview:_leftGreenView];
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(13, (44 - 21/2.f)/2.f, 24/2.f, 24/2.f)];
    _icon.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_icon];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ALL_FRAME_WIDTH/2.f - 40, 44)];
    [self.contentView addSubview:_nameLable];
}

@end
