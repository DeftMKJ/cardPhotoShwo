//
//  MKJMainPopoutView.h
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKJItemModel.h"
@protocol MKJMainPopoutViewDelegate <NSObject>

- (void)selectedHero:(MKJItemModel *)item;

- (void)closePopView;

@end

@interface MKJMainPopoutView : UIView
@property (nonatomic,weak) id<MKJMainPopoutViewDelegate>delegate;
@property (nonatomic,strong) NSArray *dataSource;
- (void)showInSuperView:(UIView *)superView;

@end
