//
//  HQBaseTableView.h
//  HQPersinalInfo
//
//  Created by lvfeijun on 2021/9/18.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DZNEmptyDataSet.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    EnumRequestDataTypeRefresh,
    EnumRequestDataTypeMore,
    EnumRequestDataTypeFirst,///首次加载数据，有些场景要加loading
} EnumRequestDataType;

@interface HQBaseTableView : UITableView

@property (nonatomic, strong) NSArray *datas;

- (void)registerClassCell:(Class)class;
- (void)registerNibCell:(NSString *)nibName;

#pragma mark data

- (void)refreshData;
- (void)requestData:(EnumRequestDataType)refresh;

- (void)setRefreshData;
- (void)endLoadData;


- (void)firstRequest;


#pragma mark empty
@property (nonatomic, strong) NSString *hq_dataStatusNoData_img;
@property (nonatomic, strong) NSString *hq_dataStatusError_img;
@property (nonatomic, strong) NSString *hq_dataStatusUnknown_img;
@property (nonatomic, strong) NSString *hq_dataStatusNoData_text;
@property (nonatomic, strong) NSString *hq_dataStatusError_text;
@property (nonatomic, strong) NSString *hq_dataStatusUnknown_text;
@property (nonatomic, strong) NSNumber *hq_dataStatusType;
@property (nonatomic, strong) NSNumber *hq_dataStatusNoData_text_fontSize;
@property (nonatomic, strong) NSString *hq_dataStatusTextColor;

- (void)createEmpty:(CGFloat)verticalOffset;
- (void)changeCommonEmptyData:(NSArray *)array error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
