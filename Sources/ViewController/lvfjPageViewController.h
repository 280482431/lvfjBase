//
//  HQBaseCommonTableViewController.h
//  tiku
//
//  Created by lvfeijun on 2021/7/22.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import "HQBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface lvfjPageViewController : HQBaseTableViewController

#pragma mark request
- (void)loadMoreData;
- (void)setLoadMoreData;

#pragma mark page
@property (nonatomic, assign) NSInteger beginPage;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageMaxSize;
- (void)setCommonPage;
///数据处理+页码处理
- (void)requestChangeCommonData:(NSArray *)array type:(EnumRequestDataType)type;
- (void)changeCommonPage:(NSInteger)count;
- (void)changeCommonData:(NSArray *)array type:(EnumRequestDataType)type ;
///没有更多数据时，表尾通用处理,endLoadData必须放在它之前
- (void)setCommonFooert:(NSArray *)array type:(EnumRequestDataType)type;

/// 通用：一次性设置所有，分页加载数据后的设置
- (void)setCommonAllPageEndLodData:(NSArray *)data type:(EnumRequestDataType)refresh error:(NSError *)error;
/// 通用：一次性设置所有，创建PageView
- (void)createCommonAllPageView:(CGFloat)verticalOffset;


@end

NS_ASSUME_NONNULL_END
