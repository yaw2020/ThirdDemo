//
//  ViewController.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "A_VC.h"
#import "B_VC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    A_VC *A = [A_VC new];
    B_VC *B = [B_VC new];
    [self addChildViewController:A];
    [self addChildViewController:B];
    
    A.view.frame = CGRectMake(0, 0, 300, 200);
    B.view.frame = CGRectMake(0, 200, 300, 200);
    [self.view addSubview:A.view];
    [self.view addSubview:B.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
