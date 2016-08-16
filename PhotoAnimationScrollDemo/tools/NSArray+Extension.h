//
//  NSArray+Extension.h
//  JKPlus
//
//  Created by WJM on 15/12/7.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 *  可防止数组越界
 */
- (nullable id)safetyObjectAtIndex:(NSUInteger)index;


@end
