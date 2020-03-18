//
//  WGCollectionViewLayout.m
//  自定义Layout标签
//
//  Created by 崔志伟 on 2017/12/4.
//  Copyright © 2017年 崔志伟. All rights reserved.
//

#import "WGCollectionViewLayout.h"

@interface WGCollectionViewLayout ()

@property (nonatomic,strong) NSMutableArray * attributesArr;

//item 宽度数组
@property (nonatomic,strong) NSMutableArray * itemWideArr;
//列数
@property (nonatomic,assign) NSInteger  columnNum ;

//页码
@property (nonatomic,assign) NSInteger  page ;

@property (nonatomic,assign) CGFloat  itemX ;
@property (nonatomic,assign) CGFloat  itemY ;


@property (nonatomic,assign) CGFloat  itemW ;


@end

@implementation WGCollectionViewLayout
@synthesize itemHeight = _itemHeight;

@synthesize itemHVSpace = _itemHVSpace;

@synthesize itemLRSpace = _itemLRSpace;

@synthesize maxColumnNum = _maxColumnNum;

#pragma mark == Getter
- (NSMutableArray *)attributesArr{
    
    if (_attributesArr == nil) {
        _attributesArr = [NSMutableArray array];
        
    }
    return _attributesArr;
}
- (NSMutableArray *)itemWideArr{
    
    if (_itemWideArr == nil) {
        _itemWideArr = [NSMutableArray array];
        
    }
    return _itemWideArr;
}
- (CGFloat)itemHeight{
    
    if (_itemHeight == 0) {
        return 25.0f;
    }
    return _itemHeight;
}
- (CGFloat)itemHVSpace{
    
    if (_itemLRSpace == 0) {
        return 10.0f;
    }
    return _itemLRSpace;
}
- (CGFloat)itemLRSpace{
    
    if (_itemHVSpace == 0) {
        return 10.0f;
    }
    return _itemHVSpace;
}

- (NSInteger)maxColumnNum{
    
    if (_maxColumnNum == 0) {
        return 10000000;
    }
    return _maxColumnNum;
}
#pragma mark == Setter

- (void)setItemHeight:(CGFloat)itemHeight{
    _itemHeight = itemHeight;
    
}
-(void)setItemHVSpace:(CGFloat)itemHVSpace{
    
    _itemHVSpace = itemHVSpace;
}
- (void)setItemLRSpace:(CGFloat)itemLRSpace{
    
    _itemLRSpace = itemLRSpace;
}
- (void)setMaxColumnNum:(NSInteger)maxColumnNum{
    
    _maxColumnNum = maxColumnNum;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    [self.attributesArr removeAllObjects];
    self.columnNum = 0;
    self.page = 0;
    self.itemX = 0;
    NSInteger cou = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0 ; i< cou; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArr addObject:attr];
    }
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArr;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [ UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat W = 30+ arc4random_uniform(50);
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:wideForItemAtIndexPath:)]) {
        W = [self.delegate collectionView:self.collectionView layout:self wideForItemAtIndexPath:indexPath];
    }
    if ((self.itemX +W)> self.collectionView.frame.size.width-10 +self.page*(self.collectionView.frame.size.width)) {
        self.columnNum++;
        if (self.maxColumnNum < self.columnNum) {
            self.page++;
            self.columnNum = 0;
        }
        self.itemX  =  self.page*(self.collectionView.frame.size.width);
    }
    CGFloat x =self.itemX+self.itemLRSpace;
    self.itemY =  self.columnNum * (self.itemHeight +self.itemHVSpace);
    attributes.frame =CGRectMake(x, self.itemY, W, self.itemHeight);
    self.itemX = CGRectGetMaxX(attributes.frame);
    return attributes;
}
- (CGSize)collectionViewContentSize{
    return CGSizeMake((self.page+1)*self.collectionView.frame.size.width,  self.itemY+ self.itemHeight);
}

@end

