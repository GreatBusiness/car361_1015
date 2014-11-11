//
//  ShopIntroduceCell.m
//  car361
//
//  Created by lichaowei on 14/11/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShopIntroduceCell.h"

@implementation ShopIntroduceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellForModel:(ServiceInfoClass *)infoModel
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.photo] placeholderImage:nil];
    self.shopNameLabel.text = infoModel.name;
    self.phoneLabel.text = [NSString stringWithFormat:@"电话:%@",infoModel.telphone];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",infoModel.address];
    self.timeLabel.text = infoModel.time;
}

@end
