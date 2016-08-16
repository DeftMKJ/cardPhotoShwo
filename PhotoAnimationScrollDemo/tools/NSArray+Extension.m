//
//  NSArray+Extension.m
//  JKPlus
//
//  Created by WJM on 15/12/7.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (nullable id)safetyObjectAtIndex:(NSUInteger)index
{
    if (!self || self.count == 0 || self.count <= index) {
        return nil;
    }
    
    return self[index];
}


@end
