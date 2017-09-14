//
//  HomeMainView.h
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMainView : UIView
@property(nonatomic,strong)RACSignal * scanButtonSignal;
@property(nonatomic,strong)RACSignal * payButtonSignal;
@property(nonatomic,strong)RACSignal * intermentButtonSignal;
@property(nonatomic,strong)RACSignal * moneyButtonSignal;
@end
