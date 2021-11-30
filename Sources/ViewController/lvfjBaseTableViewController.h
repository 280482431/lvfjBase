//
//  HQBaseTableViewController.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/7/9.
//

#import "HQBaseViewController.h"
#import "UIViewController+DZNEmptyDataSet.h"
#import "HQBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

static  NSString * const DefaultNoNetworkHaveDatasText =@"网络不给力";

@interface lvfjBaseTableViewController : HQBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) UITableView *tableView;

#pragma mark --data
- (void)setRefreshData;
- (void)refreshData;

#pragma mark --inner reachable
- (void)firstRequest;
- (void)reachableRequest:(EnumRequestDataType)refresh;

///需要重写改方法，加载数据
- (void)requestData:(EnumRequestDataType)refresh;
- (void)endLoadData;
#pragma mark --set
- (void)registerClassCell:(Class)class;
- (void)registerNibCell:(NSString *)nibName;

- (void)createCommonTableView;
/// 不包含上拉刷新
- (void)setCommonTableView;

#pragma mark empty
///通用创建无数据页面
- (void)createEmpty:(CGFloat)verticalOffset;

- (void)setEmptyNoData:(NSString *)text image:(NSString *)image;
- (void)setEmptyError:(NSString *)text image:(NSString *)image;
///通用处理无数据页面
- (void)changeCommonEmptyData:(NSArray *)array error:(NSError *)error;

/// 通用：一次性设置所有，tableView加载数据后的设置
- (void)setCommonAllTableViewEndLodData:(NSArray *)data type:(EnumRequestDataType)refresh error:(NSError *)error;
/// 通用：一次性设置所有，创建tableView
- (void)createCommonAllTableView:(CGFloat)verticalOffset;

@end

NS_ASSUME_NONNULL_END
