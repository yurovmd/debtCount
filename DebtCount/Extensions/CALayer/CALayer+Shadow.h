//
//  CALayer+Shadow.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 28/06/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Shadow)

- (void)applyShadowWithColor:(UIColor *)color
                       alpha:(float)alpha
                       xAxis:(CGFloat)xAxis
                       yAxis:(CGFloat)yAxis
                        blur:(CGFloat)blur
                      spread:(CGFloat)spread;
@end

NS_ASSUME_NONNULL_END
