//
//  LoginInputView.h
//  AssistHonest
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView
@property(nonatomic,assign)BOOL rightIconHidden;//default is YES
@property(nonatomic,assign)BOOL hidePassword;//default is YES
@property(nonatomic,copy)NSString * placeHodel;
@property(nonatomic,copy)NSString * title;
@end
