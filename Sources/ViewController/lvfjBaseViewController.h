//
//  HQBaseViewController.h
//  tiku
//
//  Created by lvfeijun on 2021/5/26.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignHeader.h"
#import "SensorsAnalyticsSDK.h"

NS_ASSUME_NONNULL_BEGIN

static  NSString * const DefaultNoNetworkText =@"网络不给力，点击屏幕刷新";

@interface lvfjBaseViewController : UIViewController<SAAutoTracker>

- (BOOL)isReachable;

- (void)setHiddenNavigation;

/// 判断是否登录
@property (nonatomic, assign) BOOL isLogin;

/// 判断是否登录，没有则自动跳转到登录
- (BOOL)isLoginAndJump;
- (void)clickBack;

- (BOOL)isVisible;

@end

NS_ASSUME_NONNULL_END
