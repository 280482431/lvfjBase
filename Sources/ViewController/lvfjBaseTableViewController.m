//
//  HQBaseTableViewController.m
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/7/9.
//

#import "lvfjBaseTableViewController.h"
#import "NSArray+Architecture.h"
#import "HQGifHeader.h"

@interface lvfjBaseTableViewController ()

@end

@implementation lvfjBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark -- data
- (void)setRefreshData
{
    @weakify(self)
    self.tableView.mj_header = [HQGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
}
- (void)firstRequest
{
    [self reachableRequest:EnumRequestDataTypeFirst];
}
- (void)reachableRequest:(EnumRequestDataType)refresh
{
    if ([self isReachable]) {
        [self requestData:refresh];
    } else {
        [self doNotReachable];
    }
}
- (void)doNotReachable
{
    [self endLoadData];
    if ([NSArray hq_isEmptyArray:self.datas]) {
        self.hq_dataStatusError_text = DefaultNoNetworkText;
        self.hq_dataStatusType = @(DataAPIStatusError);
        [self.tableView reloadData];
    } else {
        [SVProgressHUD showErrorWithStatus:DefaultNoNetworkHaveDatasText];
    }
}
- (void)refreshData
{
    [self reachableRequest:EnumRequestDataTypeRefresh];
}
- (void)requestData:(EnumRequestDataType)refresh
{};
- (void)endLoadData
{
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark -- set
- (void)registerClassCell:(Class)class
{
    [self.tableView registerClass:class forCellReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerNibCell:(NSString *)nibName
{
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (void)createCommonTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [self setCommonTableView];
}

- (void)setCommonTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCell.new;
}

#pragma mark empty
- (void)createEmpty:(CGFloat)verticalOffset
{
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.hq_verticalOffset = @(verticalOffset);
    
}
- (void)hq_refreshAfterClickErrorView
{
    [self requestData:EnumRequestDataTypeFirst];
}
- (void)setEmptyNoData:(NSString *)text image:(NSString *)image
{
    if ([text isKindOfClass:NSString.class]) {
        self.hq_dataStatusNoData_text = text;
    }
    if ([image isKindOfClass:NSString.class]) {
        self.hq_dataStatusNoData_img = image;
    }
}
- (void)setEmptyError:(NSString *)text image:(NSString *)image
{
    if ([text isKindOfClass:NSString.class]) {
        self.hq_dataStatusError_text = text;
    }
    if ([image isKindOfClass:NSString.class]) {
        self.hq_dataStatusError_img = image;
    }
}
- (void)changeCommonEmptyData:(NSArray *)array error:(NSError *)error
{
   
    if ([array isKindOfClass:NSArray.class]&&array.count) {
        self.hq_dataStatusType = @(DataAPIStatusOk);
    } else if (error) {
        self.hq_dataStatusError_text = ErrorTips(error.code);
        self.hq_dataStatusType = @(DataAPIStatusError);
    } else {
        self.hq_dataStatusType = @(DataAPIStatusNoData);
    }
}
- (void)setCommonAllTableViewEndLodData:(NSArray *)data type:(EnumRequestDataType)refresh error:(NSError *)error
{
    [self endLoadData];
    [self changeCommonEmptyData:data error:error];
}
- (void)createCommonAllTableView:(CGFloat)verticalOffset
{
    [self createCommonTableView];
    [self createEmpty:verticalOffset];
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
