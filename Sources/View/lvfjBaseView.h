//
//  HQARBaseView.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/10/23.
//

#import <UIKit/UIKit.h>
#import "lvfjBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface lvfjBaseView : UIView

@property (nonatomic, strong) HQArBaseModel *model;

+ (CGFloat)getArHeight:(lvfjBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
