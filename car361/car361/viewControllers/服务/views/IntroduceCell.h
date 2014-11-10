//
//  IntroduceCell.h
//  car361
//
//  Created by lichaowei on 14/11/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceInfoClass.h"

@interface IntroduceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderLabel;

- (void)setCellForModel:(ServiceInfoClass *)infoClass;

@end
