//
//  HomeLineChartView.h
//  CCLineChart
//
//  Created by CC on 2018/5/6.
//  Copyright © 2018年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLineChartView : UIView

//Y轴标题
@property (nonatomic, strong) UILabel *titleLabel;
//X轴标题
@property (nonatomic, strong) UILabel *bottomLabel;
/** 点数据 */
@property (nonatomic,strong) NSArray *dataArrOfPoint;
/** Y轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfY;
/** X轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfX;

@end
