//
//  MKJCollectionViewFlowLayout.h
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MKJCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end

@interface MKJCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<MKJCollectionViewFlowLayoutDelegate>delegate;

@property (nonatomic,assign) BOOL needAlpha;

@end
