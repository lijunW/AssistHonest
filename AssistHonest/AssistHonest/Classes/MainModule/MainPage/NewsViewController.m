//
//  NewsViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "NewsViewController.h"



@interface NewsViewController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.dataArray.count;
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(cell.textLabel.mas_left).offset(-20);
        }];
    }

    //cell.textLabel.text = [self.dataArray[indexPath.section] products][indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://xiaofan921.w317-e1.ezwebtest.com/data/attachment/portal/201611/22/152857mvgvph9xp7rtvpu0.jpg.thumb.jpg"] placeholderImage:[UIImage imageNamed:@"message_placeholder_picture"]] ;
    cell.textLabel.text = @"测试新闻";
    cell.detailTextLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    return cell;
}



-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

@end
