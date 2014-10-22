//
//  FuwujieshaoView.h
//  car361
//
//  Created by szk on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FuwujieshaoModel.h"


#import "RTLabel.h"

@interface FuwujieshaoView : UIScrollView{


}



@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *scoreLabel;

@property(nonatomic,strong)UILabel *tradeLabel;

@property(nonatomic,strong)NSArray *titleArr;

//@property(nonatomic,strong)UITableView *mainTabVC;

@property(nonatomic,strong)RTLabel *contentWebview;

@property(nonatomic,strong)FuwujieshaoModel *myModel;


-(FuwujieshaoView *)initWiththeFrame:(CGRect)frame;

-(void)settheMyModel:(FuwujieshaoModel *)the_myModel;

@end
