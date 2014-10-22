//
//  shangjiafuwuTableViewCell.h
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShangjiafuwuModel.h"

@interface shangjiafuwuTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *tradeLabel;

@property(nonatomic,strong)UILabel *scoreLabel;

@property(nonatomic,strong)UIImageView *stareImageView;

-(void)setSubviewWithModel:(ShangjiafuwuModel *)theChangshimodel;


@end
