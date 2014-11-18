//
//  AppDelegate.m
//  car361
//
//  Created by lichaowei on 14-10-14.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

#import "Location.h"

#import "ServiceClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *root = [[RootViewController alloc]init];
    [self.window setRootViewController:root];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[Location shareInstance] startLocation];
    
    [self getClassData];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 网络请求

/**
 *  获取服务类别
 */
- (void)getClassData
{
    BOOL serviceUpdate = [LTools cacheBoolForKey:CAR_SERVICE_UPDATED];
    if (serviceUpdate) {
        
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    LTools *tool = [[LTools alloc]initWithUrl:CAR_SERVICE_CLSSES isPost:NO postData:nil];
    [tool requestCompletion:^(NSDictionary *result, NSError *erro) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *result_arr = (NSArray *)result;
            for (NSDictionary *aDic  in result_arr) {
                ServiceClass *class = [[ServiceClass alloc]initWithDictionary:aDic];
                
                [DataManager addService:class.pid serviceName:class.pname];
                
                for (NSDictionary *subDic in class.content) {
                    
                    ServiceClass *class_sub = [[ServiceClass alloc]initWithDictionary:subDic];
                    
                    [DataManager addServiceSubId:class_sub.id regionName:class_sub.name parentId:class.pid];
                    
                }
                
            }
            
            [LTools cacheBool:YES ForKey:CAR_SERVICE_UPDATED];
        }
        
        
    } failBlock:^(NSDictionary *failDic, NSError *erro) {
        
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
