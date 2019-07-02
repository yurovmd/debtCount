//
//  DCFilesManager.m
//  DebtCount
//
//  Created by MAKSIM YUROV on 02/07/2019.
//  Copyright © 2019 MAKSIM YUROV. All rights reserved.
//

#import "DCFilesManager.h"

@implementation DCFilesManager

+ (NSString *)saveImage:(UIImage *)image {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSData *avatarData = UIImagePNGRepresentation(image);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy-HH-mm-ss";
    NSDate *currentDate = [NSDate date];
    NSString *imageName = [[formatter stringFromDate:currentDate] stringByAppendingString:@".png"];
    NSString *imagePath = [basePath stringByAppendingPathComponent:imageName];
    [avatarData writeToFile:imagePath atomically:YES];
    return imagePath;
}

@end
