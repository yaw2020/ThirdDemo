//
//  ViewController.m
//  learnDemo
//
//  Created by yangjian on 2017/12/11.
//  Copyright © 2017年 yangjian. All rights reserved.
//

#import "ViewController.h"
#import "showInfoViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    
}

@property (nonatomic, strong) UIView *bgView;// 阴影视图
@property (nonatomic, strong) UIView *tempView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UITableView * mainTableView;

@end

@implementation ViewController
-(UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
       
    }
    return _mainTableView;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    for (int i = 0; i<100; i++) {
        NSString *str = [NSString stringWithFormat:@"%d-%d-%d",i,i,i];
        [self.dataArray addObject:str];
    }
//    [self.mainTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一页";
    
    
     [self.view addSubview: self.mainTableView];
}


#pragma mark -UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,10, 80, 80)];
        iconImageView.image = [UIImage imageNamed:@"book"];
        [cell.contentView addSubview:iconImageView];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(iconImageView.max_X +10, 20, SCREEN_WIDTH - iconImageView.max_X - 10, 25)];
        titleLable.text = self.dataArray[indexPath.row];
        [cell.contentView addSubview:titleLable];
        
        UILabel *textLable = [[UILabel alloc]initWithFrame:CGRectMake(titleLable.x, titleLable.max_Y+15, titleLable.width, titleLable.height)];
        textLable.textColor = RGB(155, 155, 155);
        textLable.font = [UIFont systemFontOfSize:12];
        textLable.text = self.dataArray[indexPath.row];
        [cell.contentView addSubview:textLable];
        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

// 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 选中后取消选中的颜色
    
    showInfoViewController *VC = [[showInfoViewController alloc]init];
    
    //插入动画
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect sourceRect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    UITableViewCell * selectedCell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    selectedCell.frame = sourceRect;
    selectedCell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectedCell];
    [self bgView];
    [self.view addSubview:_bgView];
    [self.view bringSubviewToFront:selectedCell];
    self.tempView = [[UIView alloc] initWithFrame:selectedCell.frame];
    self.tempView.backgroundColor = [UIColor whiteColor];
    self.tempView.alpha = 0;
    [self.view addSubview:self.tempView];
    // 进行动画
    [UIView animateWithDuration:0.3 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(1.0, 1.1);
        self.tempView.alpha = 1;
    }];
    
    double delayInSeconds = 0.3;
    __block ViewController* bself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [selectedCell removeFromSuperview];
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            bself.tempView.transform = CGAffineTransformMakeScale(1.0, SCREEN_HEIGHT / bself.tempView.frame.size.height * 2);
        }];
    });
    
    double delayInSeconds2 = 0.6;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            [bself.navigationController pushViewController:VC animated:NO];
        } completion:^(BOOL finished) {
            [bself.tempView removeFromSuperview];
            [bself.bgView removeFromSuperview];
        }];
    });
    
}

// 阴影视图
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _bgView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
