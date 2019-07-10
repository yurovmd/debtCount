//
//  DCFilesManager.h
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCFilesManager : NSObject

+ (NSString *)saveImage:(UIImage *)image;
+ (NSString *)getImagePathForImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
