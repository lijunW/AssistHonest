//
//  CustomButtom.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CustomButtom.h"
@interface CustomButtom ()
@property(nonatomic,strong)UIImageView * imageViews;
@property(nonatomic,strong)UILabel * titleLabels;
@end
@implementation CustomButtom
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setSubviews];
        [self setContains];
    }
    return  self;
}

-(void)setSubviews{
    
    self.titleLabels.textColor =[UIColor whiteColor];
    self.titleLabels.textAlignment = NSTextAlignmentCenter;
    self.titleLabels.font = [UIFont systemFontOfSize:13];
    
//    self.imageViews.backgroundColor = [UIColor redColor];
//    self.titleLabels.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.imageViews];
    [self addSubview:self.titleLabels];
}
-(void)setContains{
    [self.imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_offset(0);
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.height.mas_equalTo(self.imageViews.mas_width);
    }];
    [self.titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViews.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.centerX.mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
}

-(void)setImage:(UIImage *)image{
    self.imageViews.image = image;
    [self setNeedsLayout];
}
-(void)setTitle:(NSString *)title{
    self.titleLabels.text = title;
    [self setNeedsLayout];
}

-(UIImageView *)imageViews{
    if (!_imageViews) {
        _imageViews = [UIImageView new];
    }
    return _imageViews;
}
-(UILabel *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [UILabel new];
    }
    return  _titleLabels;
}

@end
