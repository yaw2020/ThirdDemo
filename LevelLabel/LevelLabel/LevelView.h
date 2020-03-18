//
//  LevelView.h
//  LevelLabel
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 com.gz.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

/**
 标题
 */
@property (nonatomic, strong) NSString *titleStr;

/**
 标题详情
 */
@property (nonatomic, strong) NSString *detailStr;

/**
 背景颜色(默认显示红色)
 */
@property (nonatomic, strong) UIColor *bgColor;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;

@end
