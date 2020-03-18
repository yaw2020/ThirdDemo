//
//  threeViewController.m
//  learnDemo
//
//  Created by yangjian on 2017/12/19.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#import "threeViewController.h"

@interface threeViewController ()

@end

@implementation threeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"三";
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.navigationItem.leftBarButtonItem = [AllMethod getLeftBarButtonItemWithSelect:@selector(popview) andTarget:self WithStyle:navigationBarStyle_gray];
    
}

-(void)popview{
    [self.navigationController popViewControllerAnimated:YES];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}


@end
