//
//  RootViewController.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "RootViewController.h"
#import "ServiceViewController.h"
#import "BusinessViewController.h"
#import "CommonViewController.h"
#import "MiddleViewController.h"
#import "MoreViewController.h"
#import "CarHeader.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self preprareViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preprareViewControllers
{
    ServiceViewController * rootVC = [[ServiceViewController alloc] init];
    
    BusinessViewController * fabuCarVC = [[BusinessViewController alloc] init];
    
    MiddleViewController * searchCarVC = [[MiddleViewController alloc] init];
    
    CommonViewController * perSonalVC = [[CommonViewController alloc] init];
    
    MoreViewController *more = [[MoreViewController alloc]init];
    
    
    UINavigationController * navc1 = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    UINavigationController * navc2 = [[UINavigationController alloc] initWithRootViewController:fabuCarVC];
    
    UINavigationController * navc3 = [[UINavigationController alloc] initWithRootViewController:searchCarVC];
    
    UINavigationController * navc4 = [[UINavigationController alloc] initWithRootViewController:perSonalVC];
    
    UINavigationController * navc5 = [[UINavigationController alloc] initWithRootViewController:more];
    
    
    self.viewControllers = [NSArray arrayWithObjects:navc1,navc2,navc3,navc4,navc5,nil];
        
    
////    rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"服务" image:[UIImage imageNamed:@"fuwu"] tag:0];
//    
//    rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"服务" image:[UIImage imageNamed:@"fuwu"] selectedImage:[UIImage imageNamed:@"fuwu"]];
//
//    
//    fabuCarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商家" image:[UIImage imageNamed:@"shangjiahover"] tag:1];
//    
//    searchCarVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"优惠" image:[UIImage imageNamed:@"youhuihover"] tag:2];
//    
//    perSonalVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"常识" image:[UIImage imageNamed:@"changshihover"] tag:3];
//    
//    more.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"gengduohover"] tag:3];
//    
//    self.tabBar.backgroundImage=[UIImage imageNamed:@"bottom"];
//    
//    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
//    
//    [self.tabBar setTintColor:[UIColor greenColor]];
//    
//    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
//    
//    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
//    
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected"]];
//    
//    
//    self.tabBar.translucent = NO;
//    
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],                                                                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    
    UIView *tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tabBar.width, self.tabBar.height)];
    tabbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom"]];
    [self.tabBar addSubview:tabbar];
    
    
    CGFloat width = self.view.width / 5.f;
    
    NSArray *images_normal = @[@"fuwu",@"shangjia",@"youhui",@"changshi",@"gengduo"];
    NSArray *images_selected = @[@"fuwuhover",@"shangjiahover",@"youhuihover",@"changshihover",@"gengduohover"];
    
    NSArray *titles = @[@"服务",@"商家",@"优惠",@"商家",@"更多"];
    
    for (int i = 0; i < 5; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width * i, 0, width, self.tabBar.height);
        
        [button setImage:[UIImage imageNamed:[images_normal objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[images_selected objectAtIndex:i]] forState:UIControlStateSelected];
        
        
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_selected"] forState:UIControlStateSelected];
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -23, -30, 0) ;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 17, 15, 0);
        
        
        button.tag = 100 + i;
        
        
        if (i == 0) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 17 - 5, 15, 0);
            
            button.selected = YES;
        }
        
        if (i == 1) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 17 + 2, 15, 0);
        }
        
        if (i == 3) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 17 - 2, 15, 0);
        }
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(clickToDo:) forControlEvents:UIControlEventTouchUpInside];
        
        [tabbar addSubview:button];
        
    }
    
}


- (void)clickToDo:(UIButton*)sender
{
    
    for (int i =0; i < 5; i ++) {
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:100 + i];
        
        if (btn == sender) {
            btn.selected = YES;
        }else
        {
            btn.selected = NO;
        }
    }
    
    self.selectedIndex = sender.tag - 100;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
