//
//  UserTool.h
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTool : NSObject
@property(nonatomic,strong)NSURL  * userHeaderImageUrl;

+(instancetype)shareInstancetype;

+(NSURL *)getUserHeaderImageUrl;
@end
