//
//  IntroduceCell.m
//  car361
//
//  Created by lichaowei on 14/11/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "IntroduceCell.h"

@implementation IntroduceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellForModel:(ServiceInfoClass *)infoClass;
{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",infoClass.price];
    self.phoneLabel.text = infoClass.telphone;
    self.shopNameLabel.text = infoClass.name;
    self.addressLabel.text = infoClass.address;
    self.orderLabel.text = [NSString stringWithFormat:@"已有%@预约",infoClass.trade];
}

@end
