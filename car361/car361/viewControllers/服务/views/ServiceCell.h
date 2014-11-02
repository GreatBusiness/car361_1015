//
//  ServiceCell.h
//  car361
//
//  Created by lichaowei on 14/11/2.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImageV;
@property (strong, nonatomic) IBOutlet UIImageView *renzhengImageV;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *personLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneBtn;

@property (strong, nonatomic) IBOutlet UIButton *shopDetailBtn;

@end
