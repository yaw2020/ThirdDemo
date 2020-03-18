//
//  SaveFileManager.m
//  OpenFile
//
//  Created by Cloud on 2018/11/25.
//  Copyright © 2018 Cloud. All rights reserved.
//

#import "SaveFileManager.h"

@implementation SaveFileManager
static SaveFileManager *_instance = nil;
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}
+(id)allocWithZone:(struct _NSZone *)zone
{
    return [SaveFileManager sharedInstance];
}
-(id)copyWithZone:(NSZone *)zone
{
    return [SaveFileManager sharedInstance];
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return [SaveFileManager sharedInstance];
}
@end
