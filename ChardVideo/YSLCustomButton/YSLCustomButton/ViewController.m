//
//  ViewController.m
//  YSLCustomButton
//
//  Created by beyond on 2017/12/29.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "YSLCustom/YSLCustomButton.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YSLCustomButton * top = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    top.backgroundColor = [UIColor greenColor];
    top.ysl_buttonType = YSLCustomButtonImageTop;
    top.ysl_spacing = 20;
    [top setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [top setTitle:@"图片在上" forState:UIControlStateNormal];
    [self.view addSubview:top];
    top.frame = CGRectMake(50, 100, 100, 100);
    
    
    YSLCustomButton * left = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    left.backgroundColor = [UIColor greenColor];
    left.ysl_buttonType = YSLCustomButtonImageLeft;
    left.ysl_spacing = 20;
    [left setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [left setTitle:@"图片在左" forState:UIControlStateNormal];
    [self.view addSubview:left];
    left.frame = CGRectMake(170, 100, 160, 100);
    
    
    YSLCustomButton * bottom = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    bottom.backgroundColor = [UIColor greenColor];
    bottom.ysl_buttonType = YSLCustomButtonImageBottom;
    bottom.ysl_spacing = 20;
    [bottom setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [bottom setTitle:@"图片在下" forState:UIControlStateNormal];
    [self.view addSubview:bottom];
    bottom.frame = CGRectMake(50, 220, 100, 100);
    
    
    YSLCustomButton * right = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor greenColor];
    right.ysl_buttonType = YSLCustomButtonImageRight;
    right.ysl_spacing = 20;
    [right setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    [right setTitle:@"图片在右" forState:UIControlStateNormal];
    [self.view addSubview:right];
    right.frame = CGRectMake(170, 220, 160, 100);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
