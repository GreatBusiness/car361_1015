//
//  ServiceCell.m
//  car361
//
//  Created by lichaowei on 14/11/2.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ServiceCell.h"
#import "ServiceInfoClass.h"

@implementation ServiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellWithModel:(ServiceInfoClass *)infoModel
{
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:infoModel.photo] placeholderImage:nil];
    self.nameLabel.text = infoModel.name;
    self.phoneLabel.text = [NSString stringWithFormat:@"电话:%@",infoModel.telphone];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",infoModel.address];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",infoModel.price];
    self.personLabel.text = [NSString stringWithFormat:@"%@人已选择",infoModel.trade];
    
    if ([infoModel.commend intValue] == 1) {
        
        self.recommendTint.hidden = NO;
        self.recommendTint.layer.cornerRadius = 3.f;
    }else
    {
        self.recommendTint.hidden = YES;
    }
}

@end
