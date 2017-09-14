//
//  CategoryCell.m
//  BeeQuick_One
//
//  Created by MinJing_Lin on 16/10/22.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell()
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *yellowView;
@property (nonatomic,strong) UIView *lineView;
@end
@implementation CategoryCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    static NSString *cellId = @"CategoryCellID";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageWithColor:[UIColor grayColor]];
        _backImageView.highlightedImage = [UIImage imageWithColor:[UIColor whiteColor]];
        [self.contentView addSubview:_backImageView];
        
        _yellowView = [[UIView alloc]init];
        _yellowView.backgroundColor = [UIColor orangeRed];
        [self.contentView addSubview:_yellowView];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ThemeTool mainThemeColor];
        [self.contentView addSubview:_lineView];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:Fitsize(13, 568)];
        _nameLabel.textColor = [UIColor whiteSmoke];
        _nameLabel.highlightedTextColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
        
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.width.mas_equalTo(5);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.nameLabel.highlighted = selected;
    self.yellowView.hidden = !selected;
    self.backImageView.highlighted = selected;
}

-(void)setTitle:(NSString *)title{
    _nameLabel.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
