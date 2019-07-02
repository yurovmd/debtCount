//
//  CALayer+Corners.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "CALayer+Corners.h"

@implementation CALayer (Corners)

- (void)applyCornersValue:(CGFloat)value {
    [self setCornerRadius:value];
    [self setMasksToBounds:YES];
}

@end
