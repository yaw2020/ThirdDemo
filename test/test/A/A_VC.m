//
//  A_VC.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "A_VC.h"
#import "CTMediator+B_VC_Action.h"


@implementation A_VC

-(void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton new];
    [btn setTitle:@"调用组件B" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn addTarget:self action:@selector(btn_click) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    
}


-(void)btn_click{
    [[CTMediator sharedInstance]B_VC_Action:@"para 1"  para2:222 para3:3333 para4:444];
}


-(void)action_A:(NSString*)para1 {
    NSLog(@"call action_A: %@",para1);
}

@end
