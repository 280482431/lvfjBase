//
//  HQBaseRefreshTableViewController.m
//  ArchitectureBase
//
//  Created by huanqiu on 2021/7/16.
//

#import "HQBaseRefreshTableViewController.h"
#import "UIViewController+DZNEmptyDataSet.h"
#import "HQGifHeader.h"
#import "HQAutoGifFooter.h"
#import "UIColor+HQExtensionColor.h"
#import "RACEXTScope.h"
#import "HQGlobalHeader.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"

static inline BOOL kIsIpad_CommonBasicVC() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

@interface HQBaseRefreshTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, assign) BOOL isHeaderRefreshing;
@property (nonatomic, assign) BOOL isAdjust;//默认NO
@property (nonatomic, strong) NSMutableArray *arrayDataAll;

@end

@implementation HQBaseRefreshTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    [self configBlock];
    
    self.arrayDataAll = [NSMutableArray new];
    if (kIsIpad_CommonBasicVC()) {
        _enabelRotateEvent = YES;
    }
}

- (void)initTableView
{
    if (!self.style) {
        self.style = UITableViewStylePlain;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
    self.tableView.backgroundColor = [UIColor HqColorDark_f4f6f9];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.enableHeaderRefresh = YES;
    self.rows = 12;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    [self configCustomState];
    [self setCommonTableView];
}

- (void)configCustomState
{
    
}

- (void)configBlock
{
    @weakify(self)
    self.successBlock = ^(NSArray *array) {
        @strongify(self)
        NSArray *tempArray = array ? array : @[];
        if (self.isHeaderRefreshing && self.datas.count > 0) {
            [self.arrayDataAll removeAllObjects];
        }
        if (self.page == self.pageFirst) {
            [self.arrayDataAll removeAllObjects];
        }
        if (tempArray.count > 0) {
            [self.arrayDataAll addObjectsFromArray:tempArray];
        }
        
        [self setApiStatus:NO];
        [self setEndRefresh:tempArray];
        [self.tableView reloadData];
    };
    
    self.failureBlock = ^(NSError *error) {
        @strongify(self)
        self.page --;//reset
        [self setEndRefresh:nil];
        if (self.datas.count == 0) {
            self.hq_dataStatusError_text = ErrorTips(error.code); //[NSString stringWithFormat:@"%@(%@)，点击屏幕刷新",error.domain? error.domain:@"获取数据异常", @(error.code)];
            self.hq_dataStatusType = @(DataAPIStatusError);
            [self.tableView reloadData];
        }
        else {
            self.hq_dataStatusType = @(DataAPIStatusOk);
        }
    };
    
    
    [RACObserve(self.tableView.mj_header,state) subscribeNext:^(NSNumber * status) {
        @strongify(self)
        if (!status) {
            return ;
        }
        switch ([status integerValue]) {
            case MJRefreshStateIdle: {
                [self setApiStatus:YES];
                break;
            }
            case MJRefreshStatePulling: {//start
                break;
            }
            case MJRefreshStateRefreshing: {//start
                self.hq_dataStatusType = @(DataAPIStatusNoKnown);
                break;
            }
            case MJRefreshStateWillRefresh:
            case MJRefreshStateNoMoreData: {//over
                self.hq_dataStatusType = @(DataAPIStatusNoKnown);
                break;
            }
            default:
                break;
        }
    }];
    
    //监听屏幕旋转通知，重新布局tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLayoutCollectionView:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)reLayoutCollectionView:(NSNotification *)notification
{
    if (_enabelRotateEvent) {
        [self.tableView reloadData];
    }
}

#pragma mark - refresh

- (void)setEnableHeaderRefresh:(BOOL)enableHeaderRefresh
{
    _enableHeaderRefresh = enableHeaderRefresh;
    if (_enableHeaderRefresh) {
        self.tableView.mj_header = [HQGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTopData)];
        self.tableView.mj_header.backgroundColor = [UIColor HqColorDark_f4f6f9];
    }
    else {
        self.tableView.mj_header = nil;
    }
}

- (void)setEnableFooterRefresh:(BOOL)enableFooterRefresh
{
    //上拉加载更多
    _enableFooterRefresh = enableFooterRefresh;
    if (_enableFooterRefresh) {
        self.tableView.mj_footer = [HQAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer.backgroundColor = [UIColor HqColorDark_f4f6f9];
    }
    else {
        self.tableView.mj_footer = nil;
    }
}

- (NSArray *)datas
{
    return _arrayDataAll.copy;
}

- (void)addObjsFromArray:(NSArray *)array
{
    if (array && [array isKindOfClass:[NSArray class]]) {
         [_arrayDataAll addObjectsFromArray:array];
    }
    else if (array && [array isKindOfClass:[NSMutableArray class]]) {
        [_arrayDataAll addObjectsFromArray:array];
    }
}

- (void)removeArrayData
{
    [_arrayDataAll removeAllObjects];
}

- (void)removeOBjAtIndex:(NSInteger)index
{
    [_arrayDataAll removeObjectAtIndex:index];
}

- (void)removeOBjFromArrayData:(id)obj
{
    [_arrayDataAll removeObject:obj];
}

- (void)insertObj:(id)obj atIndex:(NSInteger)index
{
    if (!obj) {
        return;
    }
    [_arrayDataAll insertObject:obj atIndex:index];
}

- (void)setPageFirst:(NSInteger)pageFirst
{
    _pageFirst = pageFirst;
    _page = _pageFirst;
}

#pragma mark - 接口请求

- (void)setEndRefresh:(NSArray *)array
{
    if (_isHeaderRefreshing) {
        [self.tableView.mj_header endRefreshing];
        if (!array || array.count == 0) {
            self.tableView.mj_footer.alpha = 0;
        } else {
            self.tableView.mj_footer.alpha = 1;
        }
    }
    
    if (!array || array.count < self.rows) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)setApiStatus:(BOOL)isObserver
{
    if (isObserver &&
        [self.hq_dataStatusType integerValue] == DataAPIStatusNoKnown) {
        return;
    }
    
    if ((self.datas == nil || self.datas.count==0)) {
        self.hq_dataStatusType = @(DataAPIStatusNoData);
    }
    else {
        self.hq_dataStatusType = @(DataAPIStatusOk);
    }
}

- (void)basicRequestData
{

}

//TODO: 请求数据
- (void)loadTopData
{
    _isHeaderRefreshing = YES;
    self.page = self.pageFirst;
    [self basicRequestData];
}

- (void)loadMoreData
{
    _isHeaderRefreshing = NO;
    self.page++;
    [self basicRequestData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}


#pragma mark - DZNEmptyDataSetSource

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if ([self.hq_dataStatusType integerValue] == DataAPIStatusError) {
        //重新显示loading, 所以需置为noKnow，还需reloadData
        self.hq_dataStatusType = @(DataAPIStatusNoKnown);
        [self.tableView reloadData];
        [self loadTopData];
    }
}

@end
