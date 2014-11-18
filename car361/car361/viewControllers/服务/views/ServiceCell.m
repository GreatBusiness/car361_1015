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
{
    NSString *phone;
}

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
    
    phone = infoModel.telphone;
    
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
    
    [self.phoneBtn addTarget:self action:@selector(dialToPhone:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dialToPhone:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否立即拨打电话？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",@"11111111"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }
}

@end
