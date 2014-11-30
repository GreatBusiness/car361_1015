//
//  UserCommentTableViewCell.h
//  car361
//
//  Created by szk on 14-10-20.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserCommentModel.h"

@interface UserCommentTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)UILabel *nickNameLabel;

@property (nonatomic,retain)UIView *startView;//星星

@property (nonatomic,retain)UILabel *serviceTypeLabel;//服务类型

@property (nonatomic,retain)UILabel *priceLabel;//价钱

@property(nonatomic,strong)UILabel *rateLabel;

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIView *viewline;


-(void)setSubviewWithModel:(UserCommentModel *)theChangshimodel;


@end
