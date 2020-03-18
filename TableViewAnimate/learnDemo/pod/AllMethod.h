//
//  AllMethod.h
//  图片处理
//
//  Created by yangjian on 2017/2/23.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger{//返回按钮的颜色，白色和灰色
    navigationBarStyle_White,
    navigationBarStyle_gray,
} navigationBarStyle;

@interface AllMethod : NSObject

NS_ASSUME_NONNULL_BEGIN

/****************************导航栏*************************************/
+ (UIBarButtonItem *)getLeftBarButtonItemWithSelect:(SEL)select andTarget:(id )obj WithStyle:(navigationBarStyle)style;



NS_ASSUME_NONNULL_END
@end
