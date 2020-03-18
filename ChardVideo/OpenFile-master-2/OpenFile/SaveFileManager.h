//
//  SaveFileManager.h
//  OpenFile
//
//  Created by Cloud on 2018/11/25.
//  Copyright © 2018 Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveFileManager : NSObject
+(instancetype)sharedInstance;
+(id)allocWithZone:(struct _NSZone *)zone;
-(id)copyWithZone:(NSZone *)zone;
-(id)mutableCopyWithZone:(NSZone *)zone;
@property(nonatomic,copy)NSString *filePath;
@end
