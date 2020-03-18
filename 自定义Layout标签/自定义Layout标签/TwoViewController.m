//
//  TwoViewController.m
//  自定义Layout标签
//
//  Created by 崔志伟 on 2017/12/4.
//  Copyright © 2017年 崔志伟. All rights reserved.
//

#import "TwoViewController.h"

#import "MYCollectionViewCell.h"
#import "WGCollectionViewLayout.h"

@interface TwoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * shops ;


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建布局
    [self.collectionView registerNib:[UINib nibWithNibName:@"MYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MYCollectionViewCell"];
    
    WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
    layout.maxColumnNum = 15;
    self.collectionView.collectionViewLayout =  layout;
    self.shops = [NSMutableArray array];
}


#pragma mark - delegate
-  (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"MYCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];

    
    return cell;
    
}
@end
