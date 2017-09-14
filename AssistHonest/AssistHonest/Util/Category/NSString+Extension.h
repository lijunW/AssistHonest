//
//  NSString+Extension.h
//  SCHOOL_STUDENT
//
//  Created by WLJ on 03/11/2016.
//  Copyright © 2016 WLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
+ (NSString*)stringFromDate:(NSDate*)date formatter:(NSString*)formatter;
-(BOOL)containtStringWithoutAa:(NSString *)string;
-(BOOL)isVideo;
-(BOOL)isImage;
-(BOOL)isWebSource;
-(BOOL)isIconGif;
@end
