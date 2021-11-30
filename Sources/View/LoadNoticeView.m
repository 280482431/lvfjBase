//
//  LoadNoticeView.m
//  ieltsgroup
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 yy. All rights reserved.
//

#import "LoadNoticeView.h"
#import "UIColor+ArExtension.h"

@implementation LoadNoticeView
@synthesize noticeImageView,btnRelaod;

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
 
        
        [self setBackgroundColor:[UIColor whiteColor]];
        noticeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120,120)];
       
        [noticeImageView setCenter:CGPointMake(frame.size.width/2, frame.size.width/2)];
        [noticeImageView setImage:[UIImage imageNamed:@"unusual-badmood"]];
        [self addSubview:noticeImageView];
        
        CGRect rect = noticeImageView.frame;
        rect.origin.y += rect.size.height;
        rect.size.width = frame.size.width - 40;
        rect.origin.x = 20;
        UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
        [lbl setText:@"网络出错\n 请轻触屏幕重新加载"];
        [lbl setNumberOfLines:0];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        lbl.textColor = [UIColor hq_arcolorWithHexString:@"0x5a5a5a"];
        [self addSubview:lbl];
        
        btnRelaod=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnRelaod setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [btnRelaod setCenter:CGPointMake(noticeImageView.center.x, btnRelaod.center.y)];
        [btnRelaod setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        [btnRelaod setBackgroundImage:[UIImage imageNamed:@"button_press"] forState:UIControlStateSelected];
//        [btnRelaod setTitleColor:[UIColor colorWithHexString:@"0x5a5a5a"] forState:UIControlStateNormal];
//        [btnRelaod setTitle:@"重新加载" forState:UIControlStateNormal];
        //        [btnRelaod addTarget:self action:@selector(clickReload:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRelaod];
        
    }
    return  self;
}


@end

