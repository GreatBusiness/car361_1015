
//
//  CustomButtom.m
//  car361
//
//  Created by lichaowei on 14/11/30.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "CustomButtom.h"

@implementation CustomButtom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString *)title
                      target:(id)target
                      action:(SEL)selector
                         tag:(int)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *menu_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [menu_btn setTitle:title forState:UIControlStateNormal];
        [menu_btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        menu_btn.frame = CGRectMake(0, 0, frame.size.width - 20, frame.size.height);
        
        [self addSubview:menu_btn];
//        [menu_btn setImage:[UIImage imageNamed:@"hornxia"] forState:UIControlStateNormal];
//        [menu_btn setImage:[UIImage imageNamed:@"hornxiahover"] forState:UIControlStateSelected];
        
        [menu_btn setTitleColor:[UIColor colorWithHexString:@"515151"] forState:UIControlStateNormal];
        [menu_btn setTitleColor:[UIColor colorWithHexString:@"54ad13"] forState:UIControlStateSelected];
        
        menu_btn.tag = tag;
        
        [menu_btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        
        self.rightIcon = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 20, 0, 20, frame.size.height)];
        _rightIcon.contentMode = UIViewContentModeCenter;
        [self.rightIcon setImage:[UIImage imageNamed:@"hornxia"]];
        [self addSubview:_rightIcon];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        [self.rightIcon setImage:[UIImage imageNamed:@"hornxiahover"]];
    }else
    {
        [self.rightIcon setImage:[UIImage imageNamed:@"hornxia"]];
    }
}



@end
