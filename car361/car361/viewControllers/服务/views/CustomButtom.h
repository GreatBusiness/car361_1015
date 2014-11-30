//
//  CustomButtom.h
//  car361
//
//  Created by lichaowei on 14/11/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButtom : UIView

@property(nonatomic,retain)UIImageView *rightIcon;//右侧箭头


-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString *)title
                      target:(id)target
                      action:(SEL)selector
                         tag:(int)tag;

- (void)setSelected:(BOOL)selected;

@end
