//
//  ChangshiTableViewCell.m
//  car361
//
//  Created by szk on 14-10-16.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ChangshiTableViewCell.h"


@implementation ChangshiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    ///自动生成注释？
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imagev=[[UIImageView alloc]initWithFrame:CGRectMake( 12, 13, 80, 60)];
        [self addSubview:_imagev];
        
        //200
        _title_label=[[UILabel alloc]initWithFrame:CGRectMake(120, 13, ALL_FRAME_WIDTH - 120 - 12, 20)];
        [self addSubview:_title_label];
        _date_label=[[UILabel alloc]initWithFrame:CGRectMake(120,33,_title_label.width, 50)];
        _date_label.textAlignment=NSTextAlignmentRight;
        [self addSubview:_date_label];
        
        self.title_label.font=[UIFont systemFontOfSize:16.0];
        self.title_label.textColor=RGBCOLOR(49, 49, 49);
        self.title_label.backgroundColor=[UIColor clearColor];
        
        self.date_label.font=[UIFont systemFontOfSize:12];
        
        self.date_label.textColor=RGBCOLOR(100, 100, 100);
        self.date_label.textAlignment=NSTextAlignmentLeft;
        
        self.date_label.numberOfLines=0;
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 76+10.5, ALL_FRAME_WIDTH-24, 0.5)];
        viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:viewline];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSubviewWithModel:(ChangshiModel *)theChangshimodel{
    

    NSLog(@"theml.title==%@",theChangshimodel.title);
    
    [_imagev sd_setImageWithURL:[NSURL URLWithString:theChangshimodel.photo] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _title_label.text=theChangshimodel.title;
    
    if (theChangshimodel.summaryb.length>40) {
        
        
        _date_label.text=[theChangshimodel.summaryb substringToIndex:40];
    }else{
        _date_label.text=theChangshimodel.summaryb;
    }
  
}

@end
