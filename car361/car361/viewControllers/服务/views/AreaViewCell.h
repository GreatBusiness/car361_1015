//
//  AreaViewCell.h
//  car361
//
//  Created by lichaowei on 14/11/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  地区cell
 */
@interface AreaViewCell : UITableViewCell

@property(nonatomic,assign)BOOL greenShow;//icon是否显示
@property(nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,retain)UIView *leftGreenView;//左侧竖 绿色view
@property(nonatomic,retain)UIImageView *icon;//图标
@property(nonatomic,retain)UILabel *nameLable;

- (void)setcellViewGreenShow:(BOOL)show;

@end
