//
//  CTMediator+B_VC_Action.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "CTMediator+B_VC_Action.h"

@implementation CTMediator (B_VC_Action)
-(void)B_VC_Action:(NSString*)para1 para2:(NSInteger)para2 para3:(NSInteger)para3 para4:(NSInteger)para4{
    [self performTarget:@"target_B" action:@"B_Action" params:@{@"para1":para1, @"para2":@(para2),@"para3":@(para3),@"para4":@(para4)} shouldCacheTarget:YES];
}
@end
