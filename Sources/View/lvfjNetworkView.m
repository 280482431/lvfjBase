//
//  HQNetworkView.m
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/8/30.
//

#import "lvfjNetworkView.h"
#import "UILabel+Architecture.h"

@implementation lvfjNetworkView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        _lb = UILabel.new;
        [self addSubview:_lb];
        [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.right.mas_equalTo(self);
            make.height.mas_equalTo(23);
        }];
        _lb.textAlignment = NSTextAlignmentCenter;
        [_lb hq_arsetText:@"" textColor:UIColor.ArColor_999999 font:HQ_Font_Regular(16)];
        
        _imgV =UIImageView.new;
        [self addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(_lb.mas_top).offset(15);
        }];
        _imgV.image = [UIImage hq_getImageWithBundleName:@"DesignSDK" ImageName:@"unusual-badmood"];
    }
    return self;
}

@end
