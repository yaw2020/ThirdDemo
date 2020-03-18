//
//  LevelView.m
//  LevelLabel
//
//  Created by admin on 2017/6/21.
//  Copyright © 2017年 com.gz.demo. All rights reserved.
//

#import "LevelView.h"

@implementation LevelView

- (void)drawRect:(CGRect)rect {
    
    CGFloat origin_x = rect.origin.x;
    CGFloat origin_y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    
    NSString *testStr = self.titleStr;
    CGFloat fontSize = 14;
    CGFloat str_width = testStr.length*14;
    CGFloat str_height = fontSize;
    
    
    NSString *testStr2 = self.detailStr;
    CGFloat str2_width = testStr2.length*14;
    CGFloat str2_height = fontSize;
    
    
    UIColor *color = self.bgColor?self.bgColor:[UIColor redColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(width,origin_y)];
    [path addLineToPoint:CGPointMake(width, width)];
    [path addLineToPoint:CGPointMake(origin_x, height)];
    [path closePath];
    path.lineWidth = 2;
    [color setStroke];
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    
    [testStr drawInRect:CGRectMake((width-str_width)/2, (height/2-fontSize)/2, width, str_height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:color}];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(origin_x, height/2)];
    [path2 addLineToPoint:CGPointMake(width, height/2)];
    [path2 addLineToPoint:CGPointMake(width, height)];
    [path2 addLineToPoint:CGPointMake(origin_x, height)];
    [path2 closePath];
    path2.lineWidth = 1;
    [color setStroke];
    [color setFill];
    path2.lineJoinStyle = kCGLineJoinRound;
    [path2 fill];
    
    [testStr2 drawInRect:CGRectMake((width-str2_width)/2,height/2 + (height/2-fontSize)/2, width, str2_height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}


-(void)setBgColor:(UIColor *)bgColor{
    
    _bgColor = bgColor;
}

@end
