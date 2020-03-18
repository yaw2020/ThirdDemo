//
//  showInfoViewController.m
//  learnDemo
//
//  Created by yangjian on 2017/12/19.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#import "showInfoViewController.h"
#import "threeViewController.h"

@interface showInfoViewController ()

@end

@implementation showInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [AllMethod getLeftBarButtonItemWithSelect:@selector(popView) andTarget:self WithStyle:navigationBarStyle_gray];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,150,100)];
    btn.center = self.view.center;
    [btn setTitle:@"点击跳转动画" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)popView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pushView{
    threeViewController *vc = [[threeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
