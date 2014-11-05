//
//  ListTable.h
//  TestList
//
//  Created by lichaowei on 14/10/23.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    Action_Back = 0,//收回
    Action_Service, //选择
    Action_Distance, //距离
    Action_Area, //地区
    Action_WholeCity //全城
    
}ActionType;

typedef enum {
    List_Area = 0,//地区
    List_Service //服务类别
}ListType;

typedef void(^ListActionBlock)(ActionType type,NSString *selectName,NSString *selectId);

@interface ListTable : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UITableView *leftTable;
@property(nonatomic,retain)UITableView *rightTable;

-(instancetype)initWithFrame:(CGRect)frame listType:(ListType)listType;

- (void)showOrHidden:(BOOL)show;

- (void)actionBlock:(ListActionBlock)aBlock;

- (void)reloadDataLeft;

@end
