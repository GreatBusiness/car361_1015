//
//  MenuSortView.h
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SortBlock)(int tag,NSString *sortName,int sortId);//tag控制开关,0开关,1排序

@interface MenuSortView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    NSArray *titles_arr;
    SortBlock sortBlock;
    CGFloat sumHeight;//总高度
    UIView *left_view;//左侧选择标识
}

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    sortBlock:(SortBlock)aBlock;

- (void)show:(BOOL)show;

@end
