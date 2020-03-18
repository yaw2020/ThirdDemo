//
//  ViewController.m
//  takeVideoDemo
//
//  Created by 信达 on 2018/6/22.
//  Copyright © 2018年 信达. All rights reserved.
//

#import "ViewController.h"
#import "TakeVideoVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 50, 30);
    [button setTitle:@"录制" forState:0];
    [button setTitleColor:[UIColor redColor] forState:0];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)btnAction:(UIButton *)btn{
    TakeVideoVC *vc = [[TakeVideoVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
