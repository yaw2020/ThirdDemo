//
//  ViewController.m
//  CCLineChart
//
//  Created by CC on 2018/6/4.
//  Copyright © 2018年 Caroline. All rights reserved.
//

#import "ViewController.h"
#import "HomeLineChartView.h" //折线图

@interface ViewController ()
{
    HomeLineChartView  *_lineChatView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //折线图
    _lineChatView = [[HomeLineChartView alloc] initWithFrame:CGRectMake(15, 100, self.view.frame.size.width - 30, 230)];
    _lineChatView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0  blue:247/255.0  alpha:1];
    [self.view addSubview:_lineChatView];
    _lineChatView.dataArrOfY = @[@"2395",@"2385",@"2375",@"2365",@"2355",@"2345"];//Y轴坐标
    _lineChatView.dataArrOfX = @[@"3.11",@"3.12",@"3.13",@"3.14",@"3.15",@"3.16",@"3.17"];//X轴坐标
    _lineChatView.dataArrOfPoint = @[@"2360",@"2370",@"2365",@"2360",@"2375",@"2385",@"2390"];
    _lineChatView.titleLabel.text = @"标题1";
    _lineChatView.bottomLabel.text = @"标题2";
}



@end
