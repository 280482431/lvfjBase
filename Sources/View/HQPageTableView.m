//
//  HQPageTableView.m
//  HQPersinalInfo
//
//  Created by lvfeijun on 2021/9/18.
//

#import "HQPageTableView.h"
#import "HQBackGifFooter.h"
#import "MJRefresh.h"
#import "HQGifHeader.h"
#import "DesignHeader.h"

@implementation HQPageTableView

#pragma data

- (void)setLoadMoreData
{
    @weakify(self)
    
    self.mj_footer = [HQBackGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self loadMoreData];
    }];
}
- (void)refreshData
{
    self.page = self.beginPage;
    [self requestData:EnumRequestDataTypeRefresh];
}
- (void)loadMoreData
{
    [self requestData:EnumRequestDataTypeMore];
}
- (void)firstRequest
{
    self.page = self.beginPage;
    [super firstRequest];
}
#pragma mark page

- (void)setCommonPage
{
    self.pageSize = 20;
    self.pageMaxSize = self.page = self.beginPage = 0;
}

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

- (void)setCommonFooter:(NSArray *)array type:(EnumRequestDataType)type
{
    [self endLoadData];
    if (array.count<self.pageSize||
        (self.pageMaxSize>0&&self.datas.count>=self.pageMaxSize)) {
        [self.mj_footer endRefreshingWithNoMoreData];

    } else if (type!=EnumRequestDataTypeMore) {
        [self setLoadMoreData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
