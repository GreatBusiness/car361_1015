//
//  ServiceDescriptionController.m
//  car361
//
//  Created by lichaowei on 14/11/10.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "ServiceDescriptionController.h"
#import "ServiceIntroduceController.h"
#import "ShopIntroduceController.h"
#import "ShopServiceController.h"
#import "UserCommentController.h"

@interface ServiceDescriptionController ()
{
    ServiceIntroduceController *introduce;//服务介绍
    ShopIntroduceController *shopInfo;//商家介绍
    ShopServiceController *service;//商家服务
    UserCommentController *comment;//用户评价
}

@end

@implementation ServiceDescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"服务介绍";
    
    [self createMenuView];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:101];
    
    [self clickToAction:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createMenuView
{
    NSArray *items = @[@"服务介绍",@"商家介绍",@"商家服务",@"用户评价"];
    CGFloat aWidth = ALL_FRAME.size.width / items.count;
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        btn.backgroundColor = [UIColor orangeColor];
        btn.tag = 100 + i + 1;
        btn.frame = CGRectMake(aWidth * i, 0, aWidth, 35.f);
        [btn addTarget:self action:@selector(clickToAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickToAction:(UIButton *)sender
{
    NSInteger viewFlag = sender.tag;
    CGFloat aFrameY = 35.f;
    
    switch (viewFlag) {
        case 101:
        {
            if (introduce)
            {
                introduce.view.hidden = NO;
            }
            else
            {
                introduce = [[ServiceIntroduceController alloc]init];
                introduce.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height - 35);
                [self.view addSubview:introduce.view];
            }
            
            introduce.infoClass = self.infoClass;
            
            [self controlViewController:introduce];
            
        }
            break;
        case 102:
        {
            if (shopInfo)
            {
                shopInfo.view.hidden = NO;
            }
            else
            {
                shopInfo = [[ShopIntroduceController alloc]init];
                shopInfo.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height-35);
                [self.view addSubview:shopInfo.view];
            }
            
            shopInfo.infoClass = self.infoClass;
            
            [self controlViewController:shopInfo];

            
        }
            break;
        case 103:
        {
            if (service)
            {
                service.view.hidden = NO;
            }
            else
            {
                service = [[ShopServiceController alloc]init];
                service.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height  -35);
                [self.view addSubview:service.view];
            }
            [self controlViewController:service];

        }
            break;
        case 104:
        {
            if (comment)
            {
                comment.view.hidden = NO;
            }
            else
            {
                comment = [[UserCommentController alloc]init];
                comment.view.frame = CGRectMake(0, aFrameY, self.view.frame.size.width, self.view.frame.size.height  -35);
                [self.view addSubview:comment.view];
            }
            [self controlViewController:comment];

        }
            break;
        default:
            NSLog(@"Controller-Error");
            break;
    }

}

- (void)controlViewController:(UIViewController *)vc
{
    introduce.view.hidden = [vc isKindOfClass:[ServiceIntroduceController class]] ? NO : YES;//服务介绍
    shopInfo.view.hidden = [vc isKindOfClass:[ShopIntroduceController class]] ? NO : YES;//商家介绍
    service.view.hidden = [vc isKindOfClass:[ShopServiceController class]] ? NO : YES;//商家服务
    comment.view.hidden = [vc isKindOfClass:[UserCommentController class]] ? NO : YES;//用户评价
}

@end
