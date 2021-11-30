//
//  HQBaseCommonTableViewController.m
//  tiku
//
//  Created by lvfeijun on 2021/7/22.
//  Copyright © 2021 edu24ol. All rights reserved.
//

#import "lvfjPageViewController.h"
#import "HQBackGifFooter.h"

@interface lvfjPageViewController ()

@end

@implementation lvfjPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark request
- (void)setLoadMoreData
{
    @weakify(self)
    
    self.tableView.mj_footer = [HQBackGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadMoreData];
    }];
}

- (void)refreshData
{
    self.page = self.beginPage;
    [self reachableRequest:EnumRequestDataTypeRefresh];
}
- (void)loadMoreData
{
    [self reachableRequest:EnumRequestDataTypeMore];
}
- (void)requestData:(EnumRequestDataType)refresh
{
    
}
- (void)endLoadData
{
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)setCommonPage
{
    self.pageSize = 20;
    self.pageMaxSize = self.page = self.beginPage = 0;
}
#pragma mark -- request to change
- (void)changeCommonPage:(NSInteger)count
{
    if (count>=self.pageSize) {
        self.page++;
    }
}
- (void)changeCommonData:(NSArray *)array type:(EnumRequestDataType)type
{
    if (type==EnumRequestDataTypeMore) {
        if (array.count) {
            NSMutableArray *marray = [NSMutableArray arrayWithArray:self.datas];
            [marray addObjectsFromArray:array];
            self.datas = marray.copy;
        }
    } else {
        self.datas = array;
    }

}
- (void)requestChangeCommonData:(NSArray *)array type:(EnumRequestDataType)type
{
    [self changeCommonPage:array.count];
    [self changeCommonData:array type:type];
}
- (void)setCommonFooert:(NSArray *)array type:(EnumRequestDataType)type
{
    [self endLoadData];
    if (array.count<self.pageSize||
        (self.pageMaxSize>0&&self.datas.count>=self.pageMaxSize)) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];

    } else if (type!=EnumRequestDataTypeMore) {
        [self setLoadMoreData];
    }
}
- (void)setCommonAllPageEndLodData:(NSArray *)data type:(EnumRequestDataType)refresh error:(NSError *)error
{
    [self requestChangeCommonData:data type:refresh];
    [self setCommonAllTableViewEndLodData:data type:refresh error:error];
    [self setCommonFooert:data type:refresh];
}
- (void)createCommonAllPageView:(CGFloat)verticalOffset
{
    [self createCommonAllTableView:verticalOffset];
    [self setCommonPage];
    [self setLoadMoreData];
    [self setRefreshData];
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
