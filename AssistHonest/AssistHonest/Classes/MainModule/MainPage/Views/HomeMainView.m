//
//  HomeMainView.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "HomeMainView.h"
#import "CustomButtom.h"
@interface HomeMainView()
@property(nonatomic,strong)CustomButtom * scan;
@property(nonatomic,strong)CustomButtom * pay;
@property(nonatomic,strong)CustomButtom * interment;
@property(nonatomic,strong)CustomButtom * money;
@end
@implementation HomeMainView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setSubviews];
        [self setContains];
    }
    return  self;
}

-(void)setSubviews{
    [self addSubview:self.scan];
    [self addSubview:self.pay];
    [self addSubview:self.interment];
    [self addSubview:self.money];
    //        scan.backgroundColor = [UIColor greenColor];
    //        pay.backgroundColor = [UIColor greenColor];
    //        interment.backgroundColor = [UIColor greenColor];
    //        money.backgroundColor = [UIColor greenColor];
    
    self.scan.image = [UIImage imageNamed:@"home_scan"];
    self.pay.image = [UIImage imageNamed:@"home_pay"];
    self.interment.image = [UIImage imageNamed:@"home_code"];
    self.money.image = [UIImage imageNamed:@"home_money"];
    
    self.scan.title = @"扫一扫";
    self.pay.title = @"付款";
    self.interment.title = @"邀请码";
    self.money.title = @"诚信基金";
    
    
    //        [scan setImage:[UIImage imageNamed:@"home_scan"] forState:0];
    //        [pay setImage:[UIImage imageNamed:@"home_pay"] forState:0];
    //        [interment setImage:[UIImage imageNamed:@"home_scan"] forState:0];
    //        [money setImage:[UIImage imageNamed:@"home_pay"] forState:0];
    //
    //        [scan setTitle:@"扫一扫" forState:0];
    //        [pay setTitle:@"付款" forState:0];
    //        [interment setTitle:@"邀请码" forState:0];
    //        [money setTitle:@"诚信基金" forState:0];
}
-(void)setContains{
    NSInteger padding =Fitsize(20, 568);
    [self.scan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(padding);
        make.centerY.mas_offset(0);
        make.height.mas_equalTo(self.mas_height).offset(-30);
        make.width.mas_equalTo(self.pay);
    }];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scan.mas_right).offset(padding);
        make.width.height.mas_equalTo(self.scan);
        make.centerY.mas_equalTo(self.scan);
    }];
    [self.interment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pay.mas_right).offset(padding);
        make.width.height.mas_equalTo(self.scan);
        make.centerY.mas_equalTo(self.scan);
    }];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.interment.mas_right).offset(padding);
        make.right.mas_offset(-padding);
        make.width.height.mas_equalTo(self.scan);
        make.centerY.mas_equalTo(self.scan);
    }];
}

-(CustomButtom *)scan{
    if (!_scan) {
        _scan = [[CustomButtom alloc]init];
        self.scanButtonSignal = [_scan rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _scan;
}-(CustomButtom *)pay{
    if (!_pay) {
        _pay = [[CustomButtom alloc]init];
        self.payButtonSignal = [_pay rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _pay;
}
-(CustomButtom *)interment{
    if (!_interment) {
        _interment = [[CustomButtom alloc]init];
        self.intermentButtonSignal = [_interment rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _interment;
}
-(CustomButtom *)money{
    if (!_money) {
        _money = [[CustomButtom alloc]init];
        self.moneyButtonSignal = [_money rac_signalForControlEvents:UIControlEventTouchUpInside];
    }
    return _money;
}

@end
