//
//  HQBaseTableView.m
//  HQPersinalInfo
//
//  Created by lvfeijun on 2021/9/18.
//

#import "lvfjBaseTableView.h"
#import "HQBackGifFooter.h"
#import "MJRefresh.h"
#import "HQGifHeader.h"
#import "DesignHeader.h"
#import "UIScrollView+EmptyDataSet.h"

static  NSString * const DefaultErrorText =@"网络不给力，点击屏幕刷新";
static  NSString * const DefaultNodataText =@"暂无数据";
static  NSString * const DefaultUnKnowndataText =@"努力加载中...";

@interface HQBaseTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSNumber *hq_verticalOffset;

@end

@implementation lvfjBaseTableView

#pragma mark register

- (void)registerClassCell:(Class)class
{
    [self registerClass:class forCellReuseIdentifier:NSStringFromClass(class)];
}

- (void)registerNibCell:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

#pragma mark data
- (void)refreshData
{
    [self requestData:EnumRequestDataTypeRefresh];
}
- (void)requestData:(EnumRequestDataType)refresh
{}

- (void)endLoadData
{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}
- (void)setRefreshData
{
    @weakify(self)
    self.mj_header = [HQGifHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self refreshData];
    }];
}

- (void)firstRequest
{
    [self requestData:EnumRequestDataTypeFirst];
}
#pragma mark empty
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imgUrl = @"";
    if ([self.hq_dataStatusType integerValue] == DataAPIStatusNoData) {
        imgUrl = @"unusual-empty";
        if (self.hq_dataStatusNoData_img && self.hq_dataStatusNoData_img.length > 0) {
            imgUrl = self.hq_dataStatusNoData_img;
        }
        return [UIImage hq_getImageWithBundleName:@"DesignSDK" ImageName:imgUrl];
        
    } else if ([self.hq_dataStatusType integerValue] == DataAPIStatusError) {
        imgUrl = @"unusual-badmood";
        if (self.hq_dataStatusError_img && self.hq_dataStatusError_img.length > 0) {
            imgUrl = self.hq_dataStatusError_img;
        }
        return [UIImage hq_getImageWithBundleName:@"DesignSDK" ImageName:imgUrl];
    } else if ([self.hq_dataStatusType integerValue] ==  DataAPIStatusNoKnown) {
        imgUrl = self.hq_dataStatusUnknown_img ? self.hq_dataStatusUnknown_img : imgUrl;
        return [UIImage hq_getImageWithBundleName:@"DesignSDK" ImageName:imgUrl];
    }
    else
        return nil;
}

- (void)createEmpty:(CGFloat)verticalOffset
{
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
    self.hq_verticalOffset = @(verticalOffset);
    
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
    [self reloadEmptyDataSet];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    if ([self.hq_dataStatusType integerValue] == DataAPIStatusNoData) {
        text = self.hq_dataStatusNoData_text;
        if (!text || text.length == 0) {
            text = DefaultNodataText;
        }
    }
    else if ([self.hq_dataStatusType integerValue] == DataAPIStatusError) {
        text = self.hq_dataStatusError_text;
        if (!text || text.length == 0) {
            text = DefaultErrorText;
        }
    }
    else if ([self.hq_dataStatusType integerValue] ==  DataAPIStatusNoKnown) {
        text = self.hq_dataStatusUnknown_text;
        if (!text || text.length == 0) {
            text = DefaultUnKnowndataText;
        }
    } else if ([self.hq_dataStatusType integerValue] == DataAPIStatusOk) {
        text = @"";
    }
    text = text ? text : @"";
    UIFont *font = [UIFont systemFontOfSize:16.f];
    if (self.hq_dataStatusNoData_text_fontSize && [self.hq_dataStatusNoData_text_fontSize integerValue]>0) {
        font = [UIFont systemFontOfSize:[self.hq_dataStatusNoData_text_fontSize integerValue]];
    }
    UIColor *textColor = nil;
    if (self.hq_dataStatusTextColor && self.hq_dataStatusTextColor.length > 0) {
        textColor = [UIColor hq_arcolorWithHexString:self.hq_dataStatusTextColor];
    } else{
        textColor = [UIColor hq_arcolorWithHexString:@"0x969696"];
    }
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.hq_verticalOffset) {
        return [self.hq_verticalOffset integerValue];
    }
    return -50;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
