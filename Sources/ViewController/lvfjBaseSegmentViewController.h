//
//  HQBaseSegmentViewController.h
//  TiKu
//
//  Created by lvfeijun on 2021/5/28.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import "lvfjBaseViewController.h"
#import "JXCategoryView.h"
//#import "HQCourseInitialModel.h"

/**
 控制器必须实现如下协议
 #pragma mark - JXCategoryViewDelegate
 - (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index
 {
     HQClockInCalendarViewController *vc = [[HQClockInCalendarViewController alloc] init];
     vc.initialModel = self.subjectArray[index];
     return vc;
 }
 
 
 子view的控制器实现如下协议
 #import "JXCategoryListContainerView.h"
 <JXCategoryListContentViewDelegate>
 
 #pragma mark - JXCategoryListContentViewDelegate

 - (UIView *)listView
 {
     return self.view;
 }
 */

NS_ASSUME_NONNULL_BEGIN

@interface lvfjBaseSegmentViewController : lvfjBaseViewController<JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>

/// 所有数据
@property (nonatomic, copy) NSArray *datas;
/// 当前选择的数据
@property (nonatomic, strong) id selectData;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) CGFloat categoryViewTop;

/// 尽量在[super viewDidLoad];之前设置

/// segment 数据
- (void)setSegmentTitles:(NSArray<NSString *> *)segmentTitles;
/// segment样式
- (void)setCategoryViewBackgroundColor:(nullable UIColor *)backgroundColor titleColor:(nullable UIColor *)titleColor titleSelectedColor:(nullable UIColor *)titleSelectedColor titleFont:(nullable UIFont *)titleFont titleSelectedFont:(UIFont *)titleSelectedFont;
- (void)setCurrentCourseInitialWithIndex:(NSInteger)index;

- (void)initDatas;
///reloadDatas 后要调用的方法
- (void)doReloadView:(NSArray <NSString *> *)titles;
#pragma mark 需要重新实现
- (void)reloadDatas;
- (void)moreTagClick;

@end

NS_ASSUME_NONNULL_END

