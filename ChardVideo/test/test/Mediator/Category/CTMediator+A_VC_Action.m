//
//  CTMediator+A_VC_Action.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "CTMediator+A_VC_Action.h"

@implementation CTMediator (A_VC_Action)
-(void)A_VC_Action:(NSString*)para1{
    [self performTarget:@"target_A" action:@"A_Action" params:@{@"para1":para1} shouldCacheTarget:YES];
}

@end
