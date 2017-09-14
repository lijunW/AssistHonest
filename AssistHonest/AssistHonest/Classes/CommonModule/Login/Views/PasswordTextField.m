//
//  PasswordTextField.m
//  SCHOOL_STUDENT
//
//  Created by WLJ on 31/10/2016.
//  Copyright © 2016 WLJ. All rights reserved.
//

#import "PasswordTextField.h"
@interface PasswordTextField ()
@property(nonatomic,strong)UIButton * hideBtn;
@end
@implementation PasswordTextField
-(instancetype)init{
    self = [super init];
    if (self) {
        self.hidePassword = YES;
        self.rightIconHidden = YES;
        [self setSubviews];
        [self setContrains];
    }
    return self;
}
-(void)setSubviews{
    
    @weakify(self)
    [[self.hideBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.hidePassword = !self.hidePassword;
    }];
    [self.hideBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [RACObserve(self, hidePassword) subscribeNext:^(id x) {
       @strongify(self)
        [self.hideBtn setImage:self.hidePassword?[UIImage imageNamed:@"密码显示"]:[UIImage imageNamed:@"密码隐藏"] forState:UIControlStateNormal];
        [self setSecureTextEntry:self.hidePassword];
    }];
    //[self.rightView addSubview:self.hideBtn];
    [self setRightView:self.hideBtn];
    [self setRightViewMode:UITextFieldViewModeAlways];
    
    [RACObserve(self, rightIconHidden) subscribeNext:^(id x) {
        @strongify(self)
        [self.hideBtn setHidden:self.rightIconHidden];
    }];
}
-(void)setContrains{
//    [self.hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.width.mas_equalTo(self.mas_height);
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(self).offset(-5);
//    }];
}
-(UIButton *)hideBtn{
    if (!_hideBtn) {
        _hideBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    }
    return _hideBtn;
}
@end
