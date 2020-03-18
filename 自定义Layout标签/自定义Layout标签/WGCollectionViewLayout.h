//
//  WGCollectionViewLayout.h
//  自定义Layout标签
//
//  Created by 崔志伟 on 2017/12/4.
//  Copyright © 2017年 崔志伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGCollectionViewLayout;

@protocol WGCollectionViewLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout*)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WGCollectionViewLayout : UICollectionViewLayout
//item 的高度
@property (nonatomic,assign) CGFloat  itemHeight ;
//item左右的间距
@property (nonatomic,assign) CGFloat  itemLRSpace;

//item上下的间距
@property (nonatomic,assign) CGFloat  itemHVSpace;

//最大行数
@property (nonatomic,assign) NSInteger  maxColumnNum ;


@property(nonatomic,weak) id<WGCollectionViewLayoutDelegate> delegate;

@end



