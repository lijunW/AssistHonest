//
//  RouterTool.h
//  AssistHonest
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/RACCommand.h>

typedef NS_ENUM(NSInteger, TransType) {
    TransTypePush,
    TransTypePresent,
    TransTypeOther,
} NS_ENUM_AVAILABLE_IOS(8_0);

@interface RouterTool : NSObject
+(RACCommand *)gotoViewController:(id)viewController transType:(TransType)transType from:(UIViewController *)viewOrNav;

@end
