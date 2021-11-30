//
//  HQBaseViewController.m
//  tiku
//
//  Created by lvfeijun on 2021/5/26.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import "lvfjBaseViewController.h"
#import "UIImage+bundle.h"
#import "GVUserDefaults+UserInfo.h"
#import "HQCodeLoginController.h"
#import "NSString+Architecture.h"
#import "HqUINavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface lvfjBaseViewController ()

@end

@implementation lvfjBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBackNavigation];
}
- (BOOL)isReachable
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}
#pragma mark --Navigation
- (void)setBackNavigation
{
    if (self.navigationController.viewControllers.count >1) {
        UIImage *img =  [UIImage hq_getImageWithBundleName:@"ArchitectureBase" ImageName:@"nav_back_black"];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)]];
    }
}

- (void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setHiddenNavigation
{
    [HqNavigationDelegateHelper addNeedHiddenNavBarViewController:self];
    self.fd_prefersNavigationBarHidden = YES;
}

#pragma mark login
- (BOOL)isLoginAndJump
{
    if (self.isLogin) {
        return YES;
    }
    @weakify(self)
    [HQCodeLoginController autoPushForIndexPage:self withAnimation:YES eventBlock:^(BOOL isBackEvent, BOOL isClickLoginSuccess, BOOL canNotShow) {
        @strongify(self)
        if (canNotShow) {
            [HQCodeLoginController pushWithCurrentViewController:self withAnimation:YES];
        }
    } succShowAuthVC:^(BOOL succShowAu) {
        if (!succShowAu) {
            [HQCodeLoginController pushWithCurrentViewController:self withAnimation:YES];
        }
    }];
    return NO;
}
- (BOOL)isLogin
{
    return ![NSString hq_isEmptyString:[GVUserDefaults standardUserDefaults].hq_token];
}
- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
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
