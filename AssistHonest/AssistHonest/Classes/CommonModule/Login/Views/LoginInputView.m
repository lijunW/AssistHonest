//
//  LoginInputView.m
//  AssistHonest
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "LoginInputView.h"
#import "PasswordTextField.h"
@interface LoginInputView ()
@property(nonatomic,strong)UILabel * titlelabel;
@property(nonatomic,strong)PasswordTextField * textField;
@end
@implementation LoginInputView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.rightIconHidden = YES;
        self.hidePassword = YES;
        [self setSubviews];
        [self setSubviewContains];
    }
    return self;
}

-(void)setSubviews{
    self.titlelabel.text = self.title?self.title:@"";
    self.titlelabel.font = [UIFont systemFontOfSize:16.5];
    

    
//    {
//        self.titlelabel.backgroundColor = [UIColor siennaColor];
//        self.textField.backgroundColor = [UIColor siennaColor];
//    }
    
    [self addSubview:self.titlelabel];
    [self addSubview:self.textField];
    
}
-(void)setSubviewContains{
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.height.mas_equalTo(self).multipliedBy(0.85);
        make.width.mas_equalTo(self).multipliedBy(0.25);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.centerY.mas_offset(0);
        make.height.mas_equalTo(self).multipliedBy(0.85);
        make.width.mas_equalTo(self).multipliedBy(0.75);
    }];
}

-(void)setRightIconHidden:(BOOL)rightIconHidden{
    self.textField.rightIconHidden  = rightIconHidden;
}
-(void)setTitle:(NSString *)title{
    self.titlelabel.text = title;
}
-(void)setHidePassword:(BOOL)hidePassword{
    self.textField.hidePassword =hidePassword;
}
-(void)setPlaceHodel:(NSString *)placeHodel{
    self.textField.placeholder = placeHodel?placeHodel:@"";
}

-(UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel new];
    }
    return _titlelabel;
}
-(PasswordTextField *)textField{
    if (!_textField) {
        _textField = [[PasswordTextField alloc]init];
    }
    return _textField;
}
@end
