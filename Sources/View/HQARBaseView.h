//
//  HQARBaseView.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/10/23.
//

#import <UIKit/UIKit.h>
#import "HQArBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HQARBaseView : UIView

@property (nonatomic, strong) HQArBaseModel *model;

+ (CGFloat)getArHeight:(HQArBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
