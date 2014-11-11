//
//  ShopServiceCell.m
//  car361
//
//  Created by lichaowei on 14/11/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ShopServiceCell.h"

@implementation ShopServiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithModel:(ShopServiceClass *)aModel
{
    self.nameLabel.text = aModel.name;
    self.priceLabel.text = aModel.price;
    self.peopleLabel.text = [NSString stringWithFormat:@"%@人已选择",aModel.trade];
    self.scoreLabel.text = aModel.score;
}

@end
