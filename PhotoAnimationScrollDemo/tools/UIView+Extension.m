//
//  UIView+Extension.m
//  LetMeSpend
//
//  Created by 翁志方 on 16/4/26.
//  Copyright © 2016年 __defaultyuan. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (CGFloat)originX
{
    return self.frame.origin.x;
}
- (CGFloat)originY
{
    return self.frame.origin.y;
}
- (CGFloat)endX
{
    return self.originX + self.width;
}
- (CGFloat)endY
{
    return self.originY + self.height;
}
- (CGFloat)width
{
    return self.bounds.size.width;
}
- (CGFloat)height
{
    return self.bounds.size.height;
}
- (CGPoint)centerOfCurrentView
{
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}
- (CGFloat)centerXOfCurrentView
{
    return self.bounds.size.width/2;
}
- (CGFloat)centerYOfCurrentView
{
    return self.bounds.size.height/2;
}

- (CGFloat)centerX
{
    return (self.frame.origin.x+self.bounds.size.width/2);
}
- (CGFloat)centerY
{
    return (self.frame.origin.y+self.bounds.size.height/2);
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}
- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setCenterOfCurrentView:(CGPoint)centerOfCurrentView
{
    // readonly
}
- (void)setCenterX:(CGFloat)centerX
{
    CGRect frame = self.frame;
    frame.origin.x = centerX - self.width/2;
    self.frame = frame;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGRect frame = self.frame;
    frame.origin.y = centerY - self.height/2;
    self.frame = frame;
}
- (void)setEndX:(CGFloat)endX
{
    CGRect frame = self.frame;
    frame.origin.x = endX - self.width;
    self.frame = frame;
}
- (void)setEndY:(CGFloat)endY
{
    CGRect frame = self.frame;
    frame.origin.y = endY - self.height;
    self.frame = frame;
}
- (void)cornerRadius:(CGFloat)cornerRadius
         borderColor:(CGColorRef)borderColor
         borderWidth:(CGFloat)borderWidth
{
    self.clipsToBounds      = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor  = borderColor;
    self.layer.borderWidth  = borderWidth;
    
}

@end
