//
//  MKJCircleLayout.m
//  PhotoAnimationScrollDemo
//
//  Created by 宓珂璟 on 2017/1/26.
//  Copyright © 2017年 MKJING. All rights reserved.
//

#import "MKJCircleLayout.h"

@interface MKJCircleLayout ()

@property (nonatomic,strong) NSMutableArray *layoutAttributesArr;

@end


@implementation MKJCircleLayout

- (NSMutableArray *)layoutAttributesArr
{
    if (_layoutAttributesArr == nil) {
        _layoutAttributesArr = [[NSMutableArray alloc] init];
    }
    return _layoutAttributesArr;
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self.layoutAttributesArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.layoutAttributesArr addObject:atts];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.layoutAttributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    // 半径
    CGFloat radius = 120;
    // 圆心
    CGFloat circleX = self.collectionView.frame.size.width * 0.5;
    CGFloat circleY = self.collectionView.frame.size.height * 0.5;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(80, 80);
    // 当外面删除的时候只有一个的时候，直接居中显示
    if (count == 1) {
        attrs.center = CGPointMake(circleX, circleY);
    } else {
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        CGFloat centerX = circleX + radius * sin(angle);
        CGFloat centerY = circleY + radius * cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    }
    return attrs;
}

@end
