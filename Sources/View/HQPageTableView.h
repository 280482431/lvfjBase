//
//  HQPageTableView.h
//  HQPersinalInfo
//
//  Created by lvfeijun on 2021/9/18.
//

#import "HQBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HQPageTableView : HQBaseTableView

#pragma mark request
- (void)loadMoreData;
- (void)setLoadMoreData;

#pragma mark page
@property (nonatomic, assign) NSInteger beginPage;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageMaxSize;
- (void)setCommonPage;

- (void)requestChangeCommonData:(NSArray *)array type:(EnumRequestDataType)type;
- (void)setCommonFooter:(NSArray *)array type:(EnumRequestDataType)type;

@end

NS_ASSUME_NONNULL_END
