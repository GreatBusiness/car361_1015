//
//  JiaYouZhanTableViewCell.m
//  car361
//
//  Created by szk on 14/12/22.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "JiaYouZhanTableViewCell.h"

@implementation JiaYouZhanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    ///自动生成注释？
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel=[LTools createLabelFrame:CGRectMake(12, 6, 150, 20) title:@"" font:14 align:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        [self addSubview:self.nameLabel];
        
        
        self.distanceLabel=[LTools createLabelFrame:CGRectMake(160, 6, ALL_FRAME_WIDTH-170, 20) title:@"" font:12 align:NSTextAlignmentRight textColor:[UIColor blueColor]];
        [self addSubview:self.distanceLabel];
        
        self.addressLabel=[LTools createLabelFrame:CGRectMake(12, 30, 160, 20) title:@"" font:12 align:NSTextAlignmentLeft textColor:[UIColor grayColor]];
        [self addSubview:self.addressLabel];
        
        self.telephoneLabel=[LTools createLabelFrame:CGRectMake(160, 30, ALL_FRAME_WIDTH-170 , 20) title:@"" font:12 align:NSTextAlignmentRight textColor:[UIColor grayColor]];
        [self addSubview:self.telephoneLabel];
        
        
        self.mapButton=[LTools createButtonWithType:UIButtonTypeCustom frame:CGRectMake(12, 54, 60, 20) normalTitle:@"地图" image:nil backgroudImage:nil superView:self target:self action:@selector(mapButton:)];
        
        self.mapButton.backgroundColor=[UIColor redColor];
        
        
        self.daohangButton=[LTools createButtonWithType:UIButtonTypeCustom frame:CGRectMake(ALL_FRAME_WIDTH-70, 54, 60, 20) normalTitle:@"导航" image:nil backgroudImage:nil superView:self target:self action:@selector(doDaohangButton:)];

        self.daohangButton.backgroundColor=[UIColor orangeColor];
        
        UIView *viewline=[[UIView alloc]initWithFrame:CGRectMake(12, 85.5, ALL_FRAME_WIDTH-24, 0.5)];
        viewline.backgroundColor=RGBCOLOR(223, 223, 223);
        [self addSubview:viewline];
        
    }
    return self;
}




-(void)setAllWithDic:(NSDictionary *)myDic therow:(NSInteger)themyrow thebloc:(JiaYouZhanTableViewCellBloc)themyBloc
{

    //            NSDictionary *dic = @{@"name":poi.name,@"distance":distanceStr,@"telephone":poi.phone,@"address":poi.address};

    
    self.myrow=themyrow;
    
    self.myBloc=themyBloc;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",[myDic objectForKey:@"name"]];
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%@",[myDic objectForKey:@"distance"]];

    self.addressLabel.text=[NSString stringWithFormat:@"%@",[myDic objectForKey:@"address"]];

    self.telephoneLabel.text=[NSString stringWithFormat:@"%@",[myDic objectForKey:@"telephone"]];

    
    
}



- (void)mapButton:(UIButton *)sender {
    
    //2代表点击地图
    
    self.myBloc(self.myrow,2);
    
    
    
}

- (void)doDaohangButton:(UIButton *)sender {
    //3代表直接导航
    
    self.myBloc(self.myrow,3);
    
    
}
@end
