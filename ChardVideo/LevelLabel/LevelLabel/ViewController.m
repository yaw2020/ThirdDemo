//
//  ViewController.m
//  LevelLabel
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 com.gz.demo. All rights reserved.
//

#import "ViewController.h"
#import "LevelView.h"
#import "DWSegmentedControl.h"

@interface ViewController ()<DWSegmentedControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    //另一个控件（有兴趣的同学可以看看）
//    LevelView *testView = [[LevelView alloc] initWithFrame:CGRectMake(20, 250, 200, 200)];
//    testView.titleStr = @"程序员";
//    testView.detailStr = @"iOS程序员";
//    testView.bgColor = [UIColor grayColor];
//    testView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:testView];
    
    
    
    DWSegmentedControl *test = [[DWSegmentedControl alloc] initWithFrame:CGRectMake(5, 80, self.view.frame.size.width-5, 30)];
    test.backgroundColor = [UIColor whiteColor];
    test.selectedViewColor = [UIColor colorWithRed:255/255.0 green:225/255.0 blue:68/255.0 alpha:1];//[UIColor grayColor];
    test.normalLabelColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];//[UIColor blackColor];
    test.delegate = self;
    test.titles = @[@"私信",@"评论",@"@我",@"通知"];
     [self.view addSubview:test];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)dw_segmentedControl:(DWSegmentedControl *)control didSeletRow:(NSInteger)row{
    
    NSLog(@"你选择了第%ld个",row);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
