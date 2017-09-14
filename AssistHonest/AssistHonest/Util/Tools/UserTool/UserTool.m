//
//  UserTool.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UserTool.h"

@implementation UserTool

static id _instace;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{   //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

+ (instancetype)shareInstancetype{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}


+(NSURL *)getUserHeaderImageUrl{
    return nil;
}
@end
