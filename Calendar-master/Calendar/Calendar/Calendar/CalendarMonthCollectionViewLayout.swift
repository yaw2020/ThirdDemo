//
//  CalendarMonthCollectionViewLayout.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

class CalendarMonthCollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        initSize()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSize() {
        let width = UIScreen.mainScreen().bounds.width
        
        headerReferenceSize = CGSizeMake(width, 65.0) // 头部视图的框架大小
        
        itemSize = CGSizeMake(width/7, 55.0) // 每个cell的大小
        
        minimumLineSpacing = 0.0 // 每行的最小间距
        
        minimumInteritemSpacing = 0.0 // 每列的最小间距
        
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) // 网格视图的/上/左/下/右,的边距
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var answer = super.layoutAttributesForElementsInRect(rect)!
        
        let cv = collectionView!
        
        let contentOffset = cv.contentOffset
        
        let missingSections = NSMutableIndexSet()
        
        for layoutAttributes in answer {
            if layoutAttributes.representedElementCategory == UICollectionElementCategory.Cell {
                missingSections.addIndex(layoutAttributes.indexPath.section)
            }
        }
        
        for layoutAttributes in answer {
            
            if layoutAttributes.representedElementKind != nil && layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader {
                missingSections.removeIndex(layoutAttributes.indexPath.section)
            }
        }
        
        missingSections.enumerateIndexesUsingBlock() {section, flag in
            
            let indexPath = NSIndexPath(forItem: 0, inSection: section)
            
            let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
            
            answer.append(layoutAttributes!)
        }
        
        for layoutAttributes in answer {
            if layoutAttributes.representedElementKind != nil && layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader {
                let section = layoutAttributes.indexPath.section
                
                let numberOfItemsInSection = cv.numberOfItemsInSection(section)
                
                let firstObjectIndexPath = NSIndexPath(forItem: 0, inSection: section)
                let lastObjectIndexPath = NSIndexPath(forItem: max(0, (numberOfItemsInSection - 1)), inSection: section)
                
                var firstObjectAttrs: UICollectionViewLayoutAttributes
                var lastObjectAttrs: UICollectionViewLayoutAttributes
                
                if numberOfItemsInSection > 0 {
                    firstObjectAttrs = layoutAttributesForItemAtIndexPath(firstObjectIndexPath)!
                    lastObjectAttrs = layoutAttributesForItemAtIndexPath(lastObjectIndexPath)!
                } else {
                    firstObjectAttrs = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: firstObjectIndexPath)!
                    lastObjectAttrs = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionFooter, atIndexPath: lastObjectIndexPath)!
                }
                
                let headerHeight = CGRectGetHeight(layoutAttributes.frame)
                var origin = layoutAttributes.frame.origin
                
                origin.y = min(
                    max(contentOffset.y + cv.contentInset.top, (CGRectGetMinY(firstObjectAttrs.frame) - headerHeight)),
                    (CGRectGetMaxY(lastObjectAttrs.frame) - headerHeight)
                )
                
                layoutAttributes.zIndex = 1024
                layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
            }
        }
        
        return answer
    }
}
