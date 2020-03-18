//
//  B_VC.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "B_VC.h"
#import "CTMediator+A_VC_Action.h"



@implementation B_VC

-(void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"调用组件A" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn_click) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    
}


-(void)btn_click{
    [[CTMediator sharedInstance]A_VC_Action:@"param 1"];
}


-(void)action_B:(NSString*)para1 para2:(NSInteger)para2 para3:(NSInteger)para3 para4:(NSInteger)para4{
    NSLog(@"call action_B: %@---%zd---%zd---%zd",para1,para2,para3,para4);
}

@end
