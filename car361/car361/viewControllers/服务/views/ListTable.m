//
//  ListTable.m
//  TestList
//
//  Created by lichaowei on 14/10/23.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ListTable.h"

#import "RegionClass.h"
#import "ServiceClass.h"

#define SUMHEIGHT 400
#define HEADER_HEIGHT 40

@implementation ListTable
{
    NSArray *left_arr;
    NSArray *right_arr;
    CGFloat sumHeight;//总高度
    CGFloat tempHeight;
    ListActionBlock _aBlock;
    UIButton *bottomBtn;//底部button
    ListType _listType;
    
    NSArray *distace_arr;//距离数组
}

-(instancetype)initWithFrame:(CGRect)frame listType:(ListType)listType
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)];
    if (self) {
        
        
        sumHeight = frame.size.height;
        tempHeight = sumHeight;
        
        self.clipsToBounds = YES;
        
        
        if (listType == List_Area) {
            
            distace_arr = [self distance];
            left_arr = [DataManager getRegion];
            
        }else if (listType == List_Service){
            
            left_arr = [DataManager getService];
        }
        
        _listType = listType;
        
        if (listType == List_Area) {
            self.headView =[self createHeaderView];
            [self addSubview:_headView];
        }
        
        CGPoint headOrigin = _headView.frame.origin;
        CGSize headSize = _headView.frame.size;
        self.leftTable = [self createTableWithFrame:CGRectMake(0, headOrigin.y + headSize.height, frame.size.width / 2.f, frame.size.height - headSize.height - 20)];
        _leftTable.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [self addSubview:_leftTable];
        
        UIView *bottom_line = [[UIView alloc]initWithFrame:CGRectMake(_leftTable.right, 0, 1.f, _leftTable.height)];
        bottom_line.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
        [self addSubview:bottom_line];
        
        
        self.rightTable = [self createTableWithFrame:CGRectMake(frame.size.width / 2.f + 1, headOrigin.y + headSize.height, frame.size.width / 2.f - 1, frame.size.height - headSize.height - 20)];
        [self addSubview:_rightTable];
        _rightTable.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        
        
        
        [self createBottomButton];
    }
    return self;
}

#pragma mark - 创建视图

- (UIView *)createHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, HEADER_HEIGHT)];
    
    NSArray *titles = @[@"商区",@"位置"];
    for (int i = 0; i < 2; i ++) {
        UIButton *sender = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sender.tag = 100 + i;
        [sender setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [sender addTarget:self action:@selector(clickToDo:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:sender];
        sender.titleLabel.font = [UIFont systemFontOfSize:12];
        [sender setTitleColor:[UIColor colorWithHexString:@"aaaaaa"] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor colorWithHexString:@"f7f7f7"]];
        
        sender.frame = CGRectMake((self.width/2.f * i), 0, self.width / 2.f, HEADER_HEIGHT);
    }
    
    UIView *bottom_line = [[UIView alloc]initWithFrame:CGRectMake(0, headView.bottom - 1, headView.width, 2.f)];
    bottom_line.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
    
    [headView addSubview:bottom_line];
    
    return headView;
}

- (void)createBottomButton
{
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:[UIImage imageNamed:@"fuwu_sort_bottom"] forState:UIControlStateNormal];
    close.frame = CGRectMake(0, sumHeight - 20, 320, 20);
    [self addSubview:close];
    [close addTarget:self action:@selector(clickToBack:) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn = close;
}

- (UITableView *)createTableWithFrame:(CGRect)aFrame
{
    UITableView *table = [[UITableView alloc]initWithFrame:aFrame style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.separatorInset = UIEdgeInsetsZero;
    table.separatorColor = [UIColor colorWithHexString:@"dfdfdf"];
    return table;
}

#pragma mark - 事件处理

//距离
- (NSArray *)distance
{
    NSArray *items = @[@"200",@"500",@"1000",@"1500",@"2000",@"3000",@"4000"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:items.count];
    for (int i = 0; i < items.count; i ++) {
        
        RegionClass *region = [[RegionClass alloc]init];
        region.id = [[items objectAtIndex:i]intValue];
        region.name = [NSString stringWithFormat:@"%@米",[items objectAtIndex:i]];
        [arr addObject:region];
    }
    return arr;
}

- (void)reloadRightTableRegionId:(int)regionId
{
    if (_listType == List_Area) {
        
        right_arr = [DataManager getRegionSubForRegionId:regionId];
        
    }else if (_listType == List_Service){
        
        right_arr = [DataManager getServiceSubForRegionId:regionId];
    }
    
    [self.rightTable reloadData];
    
}

- (void)reloadDataLeft
{
    [self.leftTable reloadData];
}

- (void)actionBlock:(ListActionBlock)aBlock
{
    _aBlock = aBlock;
}

- (void)clickToDo:(UIButton *)sender
{
    
}
- (void)clickToBack:(UIButton *)sender
{
    [self showOrHidden:NO];
    
    if (_aBlock) {
        
        _aBlock(Action_Back,@"back",0);
    }
}

- (void)showOrHidden:(BOOL)show
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect aFrame = weakSelf.frame;
        aFrame.size.height = show ? tempHeight : 0;
        weakSelf.frame = aFrame;
        
    }];
    
}

- (void)back
{
    if (_aBlock) {
        
        _aBlock(Action_Back,@"back",0);
    }
}

//显示或者隐藏head
- (void)showOrHiddenHeaderView:(BOOL)show
{
    __weak typeof(self)weakSelf = self;
    __weak typeof(_headView)weakHeader = _headView;
    __weak typeof(UITableView *)weakLeft = _leftTable;
    __weak typeof(UITableView *)weakRight = _rightTable;
    __weak typeof(bottomBtn)weakBtn = bottomBtn;
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect headFrame = weakHeader.frame;
        headFrame.size.height = show ? HEADER_HEIGHT : 0;
        weakHeader.frame = headFrame;
        
        CGRect leftFrame = weakLeft.frame;
        leftFrame.origin.y = show ? HEADER_HEIGHT : 0;
        weakLeft.frame = leftFrame;
        
        CGRect rightFrame = weakRight.frame;
        rightFrame.origin.y = show ? HEADER_HEIGHT : 0;
        weakRight.frame = rightFrame;
        
        tempHeight = show ? sumHeight : sumHeight - HEADER_HEIGHT;
        
        CGRect bottomFrame = weakBtn.frame;
        bottomFrame.origin.y = tempHeight - 20;
        weakBtn.frame = bottomFrame;
        
        CGRect aFrame = weakSelf.frame;
        aFrame.size.height = tempHeight;
        weakSelf.frame = aFrame;
        
    }];
}

#pragma mark - delegate

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTable) {
        
        if (_listType == List_Area && indexPath.row == 0) {
            
            //隐藏headView
            
            [self showOrHiddenHeaderView:YES];
            
        }else
        {
            [self showOrHiddenHeaderView:NO];
        }
        
        if (_listType == List_Area) {
            
            
            if (indexPath.row == 0) {
                
                //附近
                
                right_arr = distace_arr;
                
                [self.rightTable reloadData];
                
            }else if (indexPath.row == 1){
                
                //全城
                
                NSLog(@"选择全城");
                
                _aBlock(Action_WholeCity,@"全城",NSStringFromInt(999));
                
                [self showOrHidden:NO];
                
                [self back];
                
                
            }else
            {
                RegionClass *region = [left_arr objectAtIndex:indexPath.row - 2];
                
                [self reloadRightTableRegionId:region.regionid];
            }
            
        }
        else if (_listType == List_Service){
            
            
            ServiceClass *service = [left_arr objectAtIndex:indexPath.row];
            
            [self reloadRightTableRegionId:service.pid];
            
        }
        
        
        
    }else
    {
        NSString *selectName;
        NSString *selectId;//一级和二级 用,分割
        
        if (_listType == List_Area) {
            
            RegionClass *region = [right_arr objectAtIndex:indexPath.row];
            
            selectName = region.name;

            int parentId = region.parentId;
            
            ActionType aType;
            
            if ([selectName hasSuffix:@"米"]) {
                
                selectId = NSStringFromInt(region.id);
                aType = Action_Distance;
                
            }else
            {
                selectId = [NSString stringWithFormat:@"%d,%d",region.id,parentId];//后面是上一级id
                aType = Action_Area;
            }
            
            if (_aBlock) {
                
                _aBlock(aType,selectName,selectId);
                
//                _aBlock(Action_Area,selectName,selectId);
            }
            
            
        }else if (_listType == List_Service){
            
            ServiceClass *service = [right_arr objectAtIndex:indexPath.row];
            
            selectName = service.name;
            selectId = NSStringFromInt(service.id);
            
            
            if (_aBlock) {
                
                _aBlock(Action_Service,selectName,selectId);
            }
        }
        
        
        [self showOrHidden:NO];
        
        [self back];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTable) {
        
        return left_arr.count + (_listType == List_Area ? 2 : 0);
    }
    return right_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(13, (44 - 21/2.f)/2.f, 17/2.f, 21/2.f)];
        icon.tag = 100;
        [cell.contentView addSubview:icon];
        
        UIView *he = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
        he.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        cell.selectedBackgroundView = he;
        
        UIImageView *green_icon = [[UIImageView alloc]initWithFrame:CGRectMake(13, (44 - 21/2.f)/2.f, 17/2.f, 21/2.f)];
        green_icon.image = [UIImage imageNamed:@"dibiao_cur"];
        [he addSubview:green_icon];

        
        UIView *green = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 44)];
        green.backgroundColor = [UIColor colorWithHexString:@"67d31b"];
        [he addSubview:green];
        
        
        
        //17  21
    }
    
    if (tableView == self.leftTable) {
        
        UIImageView *icon = (UIImageView *)[cell.contentView viewWithTag:100];
        if (_listType == List_Area) {
            
            if (indexPath.row == 0) {
                
//                icon.image = [UIImage imageNamed:@"dibiao_fujin@2x"];
                
//                cell.imageView.image = [UIImage imageNamed:@"dibiao_fujin"];
                
            }else
            {
                UIView *he = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
                cell.backgroundView = he;
                
                UIImageView *green_icon = [[UIImageView alloc]initWithFrame:CGRectMake(13, (44 - 21/2.f)/2.f, 17/2.f, 21/2.f)];
                green_icon.image = [UIImage imageNamed:@"dibiao_putong"];
                [he addSubview:green_icon];
                
//                icon.image = [UIImage imageNamed:@"dibiao_putong"];
//                cell.imageView.image = [UIImage imageNamed:@"dibiao_putong"];
            }
            
        }
        
        if (_listType == List_Area) {
            
            if (indexPath.row == 0) {
                
                //附近
                
                cell.textLabel.text = [NSString stringWithFormat:@"    %@",@"附近"];
                
            }else if (indexPath.row == 1){
               
                //全城
                
                cell.textLabel.text = [NSString stringWithFormat:@"    %@",@"全城"];
                
            }else
            {
                RegionClass *region = [left_arr objectAtIndex:indexPath.row - 2];
                
                cell.textLabel.text = [NSString stringWithFormat:@"    %@",region.regionname];
            }
            
        }else if (_listType == List_Service) {
            
            
            ServiceClass *service = [left_arr objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"    %@",service.pname];
            
        }
        
        
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        
    }else if(tableView == _rightTable)
    {
        
        if (_listType == List_Area) {
            
            RegionClass *region = [right_arr objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"    %@",region.name];
            
        }else if (_listType == List_Service) {
            
            
            ServiceClass *service = [right_arr objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"    %@",service.name];
            cell.contentView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
            
        }
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


@end
