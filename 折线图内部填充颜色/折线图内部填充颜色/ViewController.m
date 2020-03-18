//
//  ViewController.m
//  折线图内部填充颜色
//
//  Created by 王新宇 on 2017/6/6.
//  Copyright © 2017年 王新宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *shapelayer;
@property (nonatomic, strong) NSMutableArray *pointArrays;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIView *big = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 380, 230)];
    big.backgroundColor = [UIColor greenColor];
    big.center = self.view.center;
    [self.view addSubview:big];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 380, 230)];
    backView.center = self.view.center;
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [backView addSubview:la];
    la.text = @"qq";
    [self.view addSubview:backView];
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = backView.bounds;
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
    self.gradientLayer.colors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    [backView.layer addSublayer:self.gradientLayer];
    
    self.shapelayer.path = [self drawRectWithPoints:self.pointArrays].CGPath;
    [_gradientLayer setMask:self.shapelayer];
    
}

- (UIBezierPath *)drawRectWithPoints:(NSMutableArray *)points {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 230)];
    for (int i = 0; i < points.count; i++) {
        [path addLineToPoint:[points[i] CGPointValue]];
    }
    [path addLineToPoint:CGPointMake([points.lastObject CGPointValue].x,230)];
   // [path closePath];
    return path;
}

- (CAShapeLayer *)shapelayer {
    if (!_shapelayer) {
        _shapelayer = [CAShapeLayer layer];
        _shapelayer.strokeColor = [UIColor grayColor].CGColor;
        //_shapelayer.fillColor = [UIColor clearColor].CGColor;
        _shapelayer.lineWidth = 2.0;
    }
    return _shapelayer;
}

- (NSMutableArray *)pointArrays {
    if (_pointArrays == nil) {
        _pointArrays = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            NSValue *point = [NSValue valueWithCGPoint:CGPointMake(380/7.0 * i, [self getRandNumber:10 to:220])];
            [_pointArrays addObject:point];
        }
    }
    return _pointArrays;
}

-(int)getRandNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
