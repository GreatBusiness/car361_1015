//
//  LCWTools.h
//  FBAuto
//
//  Created by lichaowei on 14-7-9.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RefreshTableView.h"
#import "MBProgressHUD.h"
#import "UIColor+ConvertColor.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "LButtonView.h"
#import "LNineImagesView.h"
#import "LActionSheet.h"
#import "LSearchView.h"
#import "LMoveView.h"

#import "DataManager.h"


#define COLOR_VIEW_BACKGROUND [UIColor colorWithRed:246/255.F green:247/255.F blue:249/255.F alpha:1.0]//视图背景颜色

#define COLOR_TABLE_LINE [UIColor colorWithRed:229/255.F green:231/255.F blue:230/255.F alpha:1.0]//teleview分割线颜色

#define COLOR_SEARCHBAR [UIColor colorWithRed:229/255.F green:231/255.F blue:230/255.F alpha:1.0]//teleview分割线颜色

#define L_PAGE_SIZE 10 //每页条数
#define ERROR_INFO @"ERRO_INFO" //错误信息

#define LOADING_TITLE @"努力加载中..." //加载提示文字

#define FONT_SIZE_BIG 16
#define FONT_SIZE_MID 14
#define FONT_SIZE_13 13
#define FONT_SIZE_SMALL 12

#define SCREEN_SIZE [[UIScreen mainScreen]bounds].size //屏幕大小

//通知

#define NOTIFICATION_UPDATE_TOPICLIST @"TOPIC_LIST" //帖子列表更新通知
#define NOTIFICATION_UPDATE_BBS_JOINSTATE @"BBS_JOINSTATE" //论坛加入状态通知
#define NOTIFICATION_UPDATE_BBS_MEMBER @"BBS_MEMBER_NUMBER" //论坛成员个数

//是否需要更新
#define UPDATE_BBSSUB_LIST @"UPDATE_BBSSUB_LIST" //是否论坛加入状态列表


#define CAR_AREA_UPDATED @"carAreaUpdated"//区域更新标识
#define CAR_SERVICE_UPDATED @"serviceUpdated" //服务更新标识

typedef void(^ urlRequestBlock)(NSDictionary *result,NSError *erro);

typedef void(^versionBlock)(BOOL isNewVersion,NSString *updateUrl,NSString *updateContent);//版本更新

@interface LTools : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    urlRequestBlock successBlock;
    urlRequestBlock failBlock;
    versionBlock aVersionBlock;
    
    NSString *requestUrl;
    NSData *requestData;
    BOOL isPostRequest;//是否是post请求
    
    NSURLConnection *connection;
    
    NSString *_appid;
}

+ (id)shareInstance;

/**
 *  网络请求
 */
- (id)initWithUrl:(NSString *)url isPost:(BOOL)isPost postData:(NSData *)postData;//初始化请求

- (void)requestCompletion:(void(^)(NSDictionary *result,NSError *erro))completionBlock failBlock:(void(^)(NSDictionary *failDic,NSError *erro))failedBlock;//处理请求结果

- (void)requestSpecialCompletion:(void(^)(NSDictionary *result,NSError *erro))completionBlock failBlock:(void(^)(NSDictionary *failDic,NSError *erro))failedBlock;//特殊请求 不进行 UTF8编码

- (void)cancelRequest;

/**
 *  版本更新
 */
+ (void)versionForAppid:(NSString *)appid Block:(void(^)(BOOL isNewVersion,NSString *updateUrl,NSString *updateContent))version;//是否有新版本、新版本更新下地址


/**
 *  NSUserDefault 缓存
 */
//存
+ (void)cache:(id)dataInfo ForKey:(NSString *)key;
//取
+ (id)cacheForKey:(NSString *)key;


+ (void)cacheBool:(BOOL)boo ForKey:(NSString *)key;

+ (BOOL)cacheBoolForKey:(NSString *)key;


#pragma mark - 文件本地存储

//根据url获取SDWebImage 缓存的图片

+ (UIImage *)sd_imageForUrl:(NSString *)url;

#pragma mark - 常用视图快速创建

+ (UITableViewCell *)cellForIdentify:(NSString *)identify
                            cellName:(NSString *)cellName
                            forTable:(UITableView *)tableView;

+ (UIButton *)createButtonWithType:(UIButtonType)buttonType
                             frame:(CGRect)aFrame
                       normalTitle:(NSString *)normalTitle
                             image:(UIImage *)normalImage
                    backgroudImage:(UIImage *)bgImage
                         superView:(UIView *)superView
                            target:(id)target
                            action:(SEL)action;

+ (UILabel *)createLabelFrame:(CGRect)aFrame
                        title:(NSString *)title
                         font:(CGFloat)size
                        align:(NSTextAlignment)align
                    textColor:(UIColor *)textColor;

+ (UITableViewCell *)cellFor;

#pragma mark - 计算宽度、高度

+ (CGFloat)widthForText:(NSString *)text font:(CGFloat)size;
+ (CGFloat)widthForText:(NSString *)text boldFont:(CGFloat)size;
+ (CGFloat)heightForText:(NSString *)text width:(CGFloat)width font:(CGFloat)size;

#pragma mark - 小工具

+ (NSString *) md5:(NSString *) text;
+ (void)alertText:(NSString *)text;
+(NSString *)timechange:(NSString *)placetime;
+(NSString *)timechange2:(NSString *)placetime;
+(NSString *)timechange3:(NSString *)placetime;

+(NSString *)timechangeToDateline;//转换为时间戳

+(NSString*)timestamp:(NSString*)myTime;//模糊时间,如几天前

+ (NSString *)currentTime;//当前时间 yyyy-mm-dd

+ (BOOL)needUpdateForHours:(CGFloat)hours recordDate:(NSDate *)recordDate;//计算既定时间段是否需要更新

#pragma mark - 加载提示

+ (void)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView;

+ (MBProgressHUD *)MBProgressWithText:(NSString *)text addToView:(UIView *)aView;

#pragma mark - 字符串的处理

+ (NSString *)NSStringNotNull:(NSString *)text;

+ (NSString *)NSStringAddComma:(NSString *)string; //添加逗号

+ (NSAttributedString *)attributedString:(NSString *)content keyword:(NSString *)aKeyword color:(UIColor *)textColor;//关键词高亮

+ (NSAttributedString *)attributedString:(NSMutableAttributedString *)attibutedString originalString:(NSString *)string AddKeyword:(NSString *)keyword color:(UIColor *)color;//每次一个关键词高亮,多次调用

+ (BOOL)NSStringIsNull:(NSString *)string;//判断字符串是否全为空格

#pragma mark - 验证有效性

/**
 *  验证 邮箱、电话等
 */

+ (BOOL)isValidateInt:(NSString *)digit;
+ (BOOL)isValidateFloat:(NSString *)digit;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isValidateName:(NSString *)userName;
+ (BOOL)isValidatePwd:(NSString *)pwdString;
+ (BOOL)isValidateMobile:(NSString *)mobileNum;

/**
 *  切图
 */
+(UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size;


#pragma mark - CoreData管理

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)insertDataClassType:(NSString *)classType dataArray:(NSMutableArray*)dataArray unique:(NSString *)unique;
//查询
- (NSArray*)queryDataClassType:(NSString *)classType pageSize:(int)pageSize andOffset:(int)currentPage unique:(NSString *)unique;

#pragma mark - 分类论坛图片获取

+ (UIImage *)imageForBBSId:(NSString *)bbsId;

@end
