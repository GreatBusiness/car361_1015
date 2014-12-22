//
//  MenuSortView.m
//  car361
//
//  Created by lichaowei on 14-10-17.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "MenuSortView.h"

@implementation MenuSortView

+ (id)shareInstance
{
    static dispatch_once_t once_t;
    static MenuSortView *dataBlock;
    
    dispatch_once(&once_t, ^{
        dataBlock = [[MenuSortView alloc]init];
    });
    
    return dataBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    sortBlock:(SortBlock)aBlock
{
    self = [super initWithFrame:CGRectMake(frame.origin.x,frame.origin.y, frame.size.width,0)];
    if (self) {
        
        titles_arr = titles;
        sortBlock = aBlock;
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_table];
        
        UIView *footer_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 20 + 5 + 5)];
//        footer_view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fuwu_bot"]];
        _table.tableFooterView = footer_view;
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setBackgroundImage:[UIImage imageNamed:@"fuwu_sort_bottom"] forState:UIControlStateNormal];
        close.frame = CGRectMake(0, 0, footer_view.width, footer_view.height);
        [footer_view addSubview:close];
        [close addTarget:self action:@selector(clickToClose:) forControlEvents:UIControlEventTouchUpInside];
        
        self.clipsToBounds = YES;
        
//        [_table reloadData];
    }
    return self;
}
- (void)clickToClose:(UIButton *)sender
{
    [self show:NO];
    
    sortBlock(0,nil,0);
}

- (void)back
{
    if (sortBlock) {
        
        sortBlock(0,nil,0);
    }
}

- (void)show:(BOOL)show
{
   [UIView animateWithDuration:0.2f animations:^{
      
       if (show) {
           self.height = titles_arr.count * 44 + 20 +5+5;
           _table.height = self.height;
       }else
       {
           self.height = 0.f;
       }
   }];
}

#pragma mark - UITableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return titles_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"MenuSortView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, 0.5f)];
        line.backgroundColor = COLOR_TABLE_LINE;
        [cell.contentView addSubview:line];
        line.tag = 99;
        
        
        UIView *leftGreenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 44)];
        leftGreenView.backgroundColor = [UIColor colorWithHexString:@"67d31b"];
        
        UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, ALL_FRAME_WIDTH, 44 - 0.5)];
        [selectView addSubview:leftGreenView];
        selectView.backgroundColor = RGBCOLOR(238, 238, 238);
        
        cell.selectedBackgroundView = selectView;

    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [titles_arr objectAtIndex:indexPath.row];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:left_view];
    
    NSString *title = [titles_arr objectAtIndex:indexPath.row];
    if (sortBlock) {
        sortBlock(1,title,(int)indexPath.row);
    }
    
    [self show:NO];
    [self back];
}

@end
