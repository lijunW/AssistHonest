//
//  NSString+Extension.m
//  SCHOOL_STUDENT
//
//  Created by WLJ on 03/11/2016.
//  Copyright © 2016 WLJ. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (NSString*)stringFromDate:(NSDate*)date formatter:(NSString*)formatter
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:formatter];
    NSString* destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
-(BOOL)containtStringWithoutAa:(NSString *)string
{
    if (string == nil) return NO;
    NSRange range = [self rangeOfString:string options:NSCaseInsensitiveSearch];
    return range.location != NSNotFound;
}

-(BOOL)isVideo{
    NSString * pathExtension= [self pathExtension];
    return [@"*.avi *.rmvb *.rm *.asf *.divx *.mpg *.mpeg *.mpe *.wmv *.mp4 *.mkv *.vob *.mov" containtStringWithoutAa:pathExtension];
}
-(BOOL)isImage{
    NSString * pathExtension= [self pathExtension];
    return [@"BMP、JPG、JPEG、PNG、GIF" containtStringWithoutAa:pathExtension];
}
-(BOOL)isWebSource{
    return [self hasPrefix:@"http://"];
}
-(BOOL)isIconGif{
    NSString * lastPathComponent = [self lastPathComponent];
    NSString * pathExtension= [self pathExtension];
    return [lastPathComponent hasPrefix:@"icon_"]&&[pathExtension isEqualToString:@"gif"];
}
@end
