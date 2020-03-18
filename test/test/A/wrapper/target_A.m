//
//  target_A.m
//  test
//
//  Created by Mia on 2018/2/9.
//  Copyright © 2018年 Mia. All rights reserved.
//

#import "target_A.h"
#import "A_VC.h"


@implementation target_A
-(void)A_Action:(NSDictionary*)para{
    NSString *para1 = para[@"para1"];
   
    A_VC *VC = [A_VC new];
    [VC action_A:para1];
}
@end
