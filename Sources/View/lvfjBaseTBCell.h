//
//  HQArBaseCell.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/9/25.
//

#import <UIKit/UIKit.h>
#import "lvfjBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface lvfjBaseTBCell : UITableViewCell

@property (nonatomic, strong) lvfjBaseModel *model;

+ (CGFloat)getlvfjHeight:(lvfjBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
