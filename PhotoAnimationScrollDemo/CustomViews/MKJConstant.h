//
//  MKJConstant.h
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/10.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(r,g,b,a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define SCREEN_WIDTH [UIScreen  mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

UIKIT_EXTERN const CGFloat MKJLineSpacing; // item间距
UIKIT_EXTERN const CGFloat MKJZoomScale; // 缩放比例
UIKIT_EXTERN const CGFloat MKJMinZoomScale; // 最小缩放比例

