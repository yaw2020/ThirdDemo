//
//  Header.h
//  JS_Say
//
//  Created by yangjian on 2017/8/1.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#ifndef Header_h
#define Header_h


// 屏幕宽度
#define SCREEN_Rect   [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 颜色的定义
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//  iOS8打印不全的问题
#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#endif
