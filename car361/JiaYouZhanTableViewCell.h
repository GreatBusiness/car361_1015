//
//  JiaYouZhanTableViewCell.h
//  car361
//
//  Created by szk on 14/12/22.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JiaYouZhanTableViewCellBloc)(NSIndexPath * indexofpathofRow,int typeofButton);


@interface JiaYouZhanTableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *distanceLabel;
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  UILabel *telephoneLabel;

@property (strong, nonatomic)  UIButton *mapButton;
@property (strong, nonatomic)  UIButton *daohangButton;

@property(nonatomic,strong)NSIndexPath* myrow;

@property(nonatomic,copy)JiaYouZhanTableViewCellBloc myBloc;

- (IBAction)mapButton:(UIButton *)sender;

- (IBAction)doDaohangButton:(UIButton *)sender;

-(void)setAllWithDic:(NSDictionary *)myDic therow:(NSIndexPath *)themyrow thebloc:(JiaYouZhanTableViewCellBloc)themyBloc;
@end
