//
//  AllMethod.m
//  图片处理
//
//  Created by yangjian on 2017/2/23.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#import "AllMethod.h"

@implementation AllMethod



+ (UIBarButtonItem *)getLeftBarButtonItemWithSelect:(SEL)select andTarget:(id )obj WithStyle:(navigationBarStyle)style{
    //返回
    UIButton* backButton= [[UIButton alloc] initWithFrame:CGRectMake(0,0,26,50)];
    backButton.contentMode=UIViewContentModeCenter;
    if (style == navigationBarStyle_gray) {
        [backButton setImage:[UIImage imageNamed:@"leftImage_Gray"] forState:UIControlStateNormal];
    }else{
        [backButton setImage:[UIImage imageNamed:@"leftImage_White"] forState:UIControlStateNormal];
    }
    
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [backButton addTarget:obj action:select forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return item;
}




@end
