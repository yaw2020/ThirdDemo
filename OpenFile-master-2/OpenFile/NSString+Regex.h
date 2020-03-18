//
//  NSString+Regex.h
//  Created by chenbo on 15/8/17.
//  Copyright (c) 2015年 陈波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Regex)

-(BOOL)validateEmail;
-(BOOL)validatePhoneNO;
-(BOOL)hasChinese;
-(NSString *)URLDecodedString:(NSString *)str;
-(NSString *)URLEncodedString:(NSString *)str;
@end
