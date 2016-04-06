//
//  TESTCollectionViewLayout.m
//  TEST2048WithCollectionView
//
//  Created by renren on 16/3/8.
//  Copyright © 2016年 renren. All rights reserved.
//

#import "TESTCollectionViewLayout.h"

@implementation TESTCollectionViewLayout

- (CGSize)collectionViewContentSize {
    return CGSizeMake(230.f, 230.f);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(50.f, 50.f);
    return attrs;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * arr = [super layoutAttributesForElementsInRect:rect];
    if (arr.count > 0) {
        return arr;
    }
    NSMutableArray * attrArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attrArr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attrArr;
}

- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attrs.alpha = 0.0f;
    attrs.size = CGSizeMake(80.f, 80.f);
    return attrs;
}

@end
