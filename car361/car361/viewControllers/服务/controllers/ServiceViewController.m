//
//  ServiceViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ServiceViewController.h"
#import "ClassifyViewController.h"
#import "AppDelegate.h"
#import "ServiceListController.h"

#import "SecondViewController.h"

@interface ServiceViewController ()
{
    UIActivityIndicatorView *loadingView;//加载封面菊花
    UIImageView *cover_imageView;
    
    UIImageView *backImageView;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"汽车管家";
    
    self.button_back.hidden = YES;
    
    [self createCoverView];
    
//    [self createBackView];
    
    [self  createMainMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (CGFloat)numFor:(CGFloat)aNum
{
    return aNum * (ALL_FRAME_WIDTH / 320);
}

#pragma mark - 创建视图

- (void)createMainMenu
{
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_WIDTH)];
    [self.view addSubview:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.center = CGPointMake(ALL_FRAME_WIDTH / 2.f, (ALL_FRAME_HEIGHT - 44 -49) / 2.f);
    
//    NSArray *titles = @[@"洗车",@"贴膜",@"打蜡",@"更多"];
    NSArray *images = @[@"g_xiche",@"g_jiayou",@"g_weixiu",@"g_more"];
    
    CGFloat aWidth = (144 * ALL_FRAME_WIDTH / 320) ;
    CGFloat aHeight = 160 * aWidth / 144;
    CGFloat aDis = (ALL_FRAME_WIDTH - aWidth * 2) / 2.f;
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:UIControlStateNormal];
        [mainView addSubview:btn];
        btn.frame = CGRectMake((i % 2) * aWidth + aDis, (i / 2) * aHeight, aWidth, aHeight);
        [btn setBackgroundColor:[UIColor blackColor]];
//        btn.alpha = 0.5f;
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(clickToDo:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *middle = [UIButton buttonWithType:UIButtonTypeCustom];
    [middle setBackgroundImage:[UIImage imageNamed:@"g_middle"] forState:UIControlStateNormal];
    middle.frame = CGRectMake(0, 0, [self numFor:173/2.f], [self numFor:173/2.f]);
    [mainView addSubview:middle];
    middle.center = CGPointMake(mainView.width/2.f, mainView.height/2.f);
}

- (void)createCoverView
{
    UIViewController *root = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    
    cover_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT + 20)];
    cover_imageView.backgroundColor = [UIColor whiteColor];
    cover_imageView.userInteractionEnabled = YES;
    [root.view addSubview:cover_imageView];
    
    loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.center = CGPointMake(ALL_FRAME_WIDTH/ 2.f, ALL_FRAME_HEIGHT / 2.f);
    [cover_imageView addSubview:loadingView];
    [loadingView startAnimating];
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(ALL_FRAME_WIDTH - 50 - 20, 30, 50, 30);
    [closeButton setTitle:@"跳过" forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeButton.layer.borderWidth = 0.5f;
    closeButton.layer.cornerRadius = 3.f;
    closeButton.layer.borderColor = [UIColor grayColor].CGColor;
    [cover_imageView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(hideCover) forControlEvents:UIControlEventTouchUpInside];
    
    [self getAppCover];
}

//背景

- (void)createBackView
{
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -64, ALL_FRAME_WIDTH, ALL_FRAME_HEIGHT)];
    [self.view addSubview:backImageView];
    
    UIImageView *maskView = [[UIImageView alloc]initWithFrame:backImageView.frame];
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
}

#pragma mark - 事件处理

- (void)clickToDo:(UIButton *)sender
{
    if (sender.tag == 103) {
        ClassifyViewController *class = [[ClassifyViewController alloc]init];
        class.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:class animated:YES];
        
        return;
    }
    
    int cid;
    NSString *service_subName;
    
    
    switch (sender.tag) {
        case 100:
        {
            //@"洗车"
            cid = 1;
            service_subName = @"洗车";
        }
            break;
        case 101:
        {
            //@"加油"
            
            SecondViewController *ccc = [[SecondViewController alloc]init];
            ccc.wordStr = @"加油";
            ccc.distanceStr = @"2000";
            
            ccc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ccc animated:YES];
            
            return;
        }
            break;
        case 102:
        {
            //@"打蜡
            cid = 2;
            service_subName = @"打蜡";
        }
            break;
            
        default:
            break;
    }
    
    ServiceListController *detailViewController = [[ServiceListController alloc] initWithNibName:@"ServiceListController" bundle:nil];
    detailViewController.hidesBottomBarWhenPushed = YES;
    detailViewController.cid = cid;
    detailViewController.service_sub_name = service_subName;

    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark - 网络请求

//封面图片
- (void)getAppCover
{
    LTools *tool = [[LTools alloc]initWithUrl:CAR_APP_COVER isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        NSString *coverurl = [result objectForKey:@"coverurl"];
        
        [loadingView stopAnimating];
        
        [LTools cache:coverurl ForKey:KEY_COVER_IMAGE_URL];
        
        [cover_imageView sd_setImageWithURL:[NSURL URLWithString:coverurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [backImageView setImageToBlur:image blurRadius:0.5f completionBlock:^{
                
                
            }];
            
            [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(hideCover) userInfo:nil repeats:NO];
            
        }];
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
}
- (void)hideCover
{
    cover_imageView.hidden = YES;
    [cover_imageView removeFromSuperview];
    cover_imageView = nil;
}


@end
