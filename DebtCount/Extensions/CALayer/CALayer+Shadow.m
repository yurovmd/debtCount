//
//  CALayer+Shadow.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "CALayer+Shadow.h"

@implementation CALayer (Shadow)

- (void)applyShadowWithColor:(UIColor *)color
                       alpha:(float)alpha
                       xAxis:(CGFloat)xAxis
                       yAxis:(CGFloat)yAxis
                        blur:(CGFloat)blur
                      spread:(CGFloat)spread {
    self.shadowColor = color.CGColor;
    [self setShadowOpacity:alpha];
    self.shadowOffset = CGSizeMake(xAxis, yAxis);
    self.shadowRadius = blur / 2.0;
    if (spread == 0.0) {
        self.shadowPath = nil;
    } else {
        CGFloat dx = -spread;
        CGRect rect = self.bounds;
        rect = CGRectInset(rect, dx, dx);
        self.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    }
}

@end
