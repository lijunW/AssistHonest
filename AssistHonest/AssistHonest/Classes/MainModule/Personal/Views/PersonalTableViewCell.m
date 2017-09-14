//
//  PersonalTableViewCell.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "PersonalTableViewCell.h"
@interface PersonalTableViewCell ()
//@property(nonatomic,strong)UILabel * textMyLabel;
//@property(nonatomic,strong)UILabel * detailMyTextLabel;
//@property(nonatomic,strong)UIImageView * imageMyView;
@end
@implementation PersonalTableViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        //[self setSubviews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        [RACObserve(self.imageView, image) subscribeNext:^(id x) {
            [self setContains];
        }];
    }
    return  self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        [RACObserve(self.imageView, image) subscribeNext:^(id x) {
            [self setContains];
        }];
    }
    return self;
}
//-(void)setSubviews{
//    [self.contentView addSubview:self.imageMyView];
//    [self.contentView addSubview:self.textMyLabel];
//    [self.contentView addSubview:self.detailMyTextLabel];
//}
-(void)setContains{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.bottom.mas_offset(-10);
        make.width.mas_equalTo(self.imageView.mas_height);
        make.left.mas_offset(20);
    }];
}


//-(UILabel *)textMyLabel{
//    if (!_textMyLabel) {
//        _textMyLabel = [UILabel new];
//    }
//    return _textMyLabel;
//}
//-(UILabel *)detailMyTextLabel{
//    if (!_detailMyTextLabel) {
//        _detailMyTextLabel = [UILabel new];
//    }
//    return _detailMyTextLabel;
//}
//-(UIImageView *)imageMyView{
//    if (!_imageMyView) {
//        _imageMyView = [UIImageView new];
//    }
//    return _imageMyView;
//}
@end
