//
//  QA_ImagePickerVC.m
//  hqedu24olapp
//
//  Created by huanqiu on 2018/12/13.
//  Copyright © 2018 edu24ol. All rights reserved.
//

#import "QA_ImagePickerVC.h"
#import "HQAppSetting.h"
#import "UIImage+Color.h"

@interface QA_ImagePickerVC ()

@end

@implementation QA_ImagePickerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //修改导航栏的背景颜色，TZImagePickerController的标题是白色的
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage hq_imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //还原对导航栏背景色的修改
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage hq_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

@end
