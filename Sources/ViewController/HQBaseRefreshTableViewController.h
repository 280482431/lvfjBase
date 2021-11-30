//
//  HQBaseRefreshTableViewController.h
//  ArchitectureBase
//
//  Created by huanqiu on 2021/7/16.
//

#import "HQBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(NSArray * array);
typedef void(^FailureBlock)(NSError * error);

@interface HQBaseRefreshTableViewController : HQBaseTableViewController

@property (nonatomic, assign) BOOL enableHeaderRefresh;//默认YES
@property (nonatomic, assign) BOOL enableFooterRefresh;

@property (nonatomic, copy)  SuccessBlock  successBlock;
@property (nonatomic, copy)  FailureBlock  failureBlock;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger rows;//默认12
@property (nonatomic, assign) NSInteger pageFirst;//默认0

@property (nonatomic, assign) BOOL enabelRotateEvent;//默认no

@property (nonatomic, assign) UITableViewStyle style;

//配置自定义的设置，在viewDidLoad中已调用，子类可重写
- (void)configCustomState;

- (void)basicRequestData;
- (void)loadTopData;
- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END
