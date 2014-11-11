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

@interface ServiceViewController ()
{
    UIImageView *cover_imageView;
    
    UIImageView *backImageView;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"服务";
    
    [self createCoverView];
    [self createBackView];
    
    [self  createMainMenu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - 创建视图

- (void)createMainMenu
{
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    [self.view addSubview:mainView];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.center = CGPointMake(160, ((iPhone5 ? 568 : 480) - 44 -49) / 2.f);
    
    NSArray *titles = @[@"洗车",@"贴膜",@"打蜡",@"更多"];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [mainView addSubview:btn];
        btn.frame = CGRectMake(i % 2 * (75 + 10), (i / 2) * (75 + 10), 75, 75);
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.alpha = 0.5f;
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(clickToDo:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createCoverView
{
    UIViewController *root = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    
    cover_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5 ? 568 : 480)];
    cover_imageView.backgroundColor = [UIColor whiteColor];
    [root.view addSubview:cover_imageView];
    [self getAppCover];
}

- (void)createBackView
{
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -64, 320, iPhone5 ? 568 : 480)];
    [self.view addSubview:backImageView];
    
    UIImageView *maskView = [[UIImageView alloc]initWithFrame:backImageView.frame];
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
//    NSString *image_url = [LTools cacheForKey:KEY_COVER_IMAGE_URL];
//    
//    UIImage *backImage = [LTools sd_imageForUrl:image_url];
//    
//    [backImageView setImageToBlur:backImage blurRadius:0.5 completionBlock:^(NSError *error) {
//        
//        NSLog(@"error %@",error);
//    }];
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
            //@"贴膜"
            cid = 10;
            service_subName = @"贴膜";
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
        
        [LTools cache:coverurl ForKey:KEY_COVER_IMAGE_URL];
        
        [cover_imageView sd_setImageWithURL:[NSURL URLWithString:coverurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [backImageView setImageToBlur:image blurRadius:0.5f completionBlock:^{
                
            }];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideCover) userInfo:nil repeats:NO];
            
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
