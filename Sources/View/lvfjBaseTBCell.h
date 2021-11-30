//
//  HQArBaseCell.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/9/25.
//

#import <UIKit/UIKit.h>
#import "HQArBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface lvfjBaseTBCell : UITableViewCell

@property (nonatomic, strong) HQArBaseModel *model;

+ (CGFloat)getlvfjHeight:(HQArBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
