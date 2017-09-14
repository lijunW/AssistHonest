//
//  PersonalViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "SetupViewController.h"
@interface PersonalViewController ()
@property(nonatomic,strong)NSMutableArray * titleArray;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setupSubViews];
    [self setSubviewContains];
}

-(void)setData{
    NSArray * title1Array = @[@"我的积分",@"我的基金",@"我的记录",@"我的好友",@"关联名单",@"我的关注"];
    NSArray * titl2Array = @[@"写信",@"来信"];
    [self.titleArray addObject:title1Array];
    [self.titleArray addObject:titl2Array];
    [self.tableView reloadData];
}

-(void)setupSubViews{
    UIButton * setButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    [setButton addTarget:self action:@selector(goToSetupVC) forControlEvents:UIControlEventTouchUpInside];
    [setButton setTitle:@"设置" forState:0];
    [setButton.titleLabel setTextColor:[UIColor whiteColor]];
    [setButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [setButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    UIBarButtonItem * setting = [[UIBarButtonItem alloc]initWithCustomView:setButton];
    self.navigationItem.rightBarButtonItem = setting;
    
//    self.tableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:<#(nonnull NSString *)#>
//    self.tableView.layoutMargins = UIEdgeInsetsZero;
//    self.tableView.preservesSuperviewLayoutMargins = false;
    
    [self.view addSubview:self.tableView];
}

-(void)goToSetupVC{
    SetupViewController * setupVC = [[SetupViewController alloc]init];
    setupVC.navigationItem.title =@"设置";
    [self.navigationController pushViewController:setupVC animated:YES];
}

-(void)setSubviewContains{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.top.mas_offset(0);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0? 1:[self.titleArray[section-1] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0 ? 80 : 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.01: 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Personal"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Personal"];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        {
            [cell.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"header_placehodel"]];
            cell.textLabel.text = @"王老吉";
            cell.detailTextLabel.text = @"个人中心：银行卡、会员";
        }
        
        return cell;
    }else{
        PersonalTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
            //cell.imageView.backgroundColor = [UIColor blueColor];
        }
        
        {
            [cell.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"Personal_%ld",indexPath.section+ indexPath.row]]];
            NSArray * titleArray = [self.titleArray objectAtIndex:indexPath.section-1];
            cell.textLabel.text = titleArray[indexPath.row];
            
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NSArray * titleArray = [self.titleArray objectAtIndex:indexPath.section-1];
        if ([titleArray[indexPath.row] isEqualToString:@"我的积分"]) {
            MyScoreViewController * myScoreVC = [[MyScoreViewController alloc]init];
            myScoreVC.navigationItem.title = @"我的积分";
            [self.navigationController pushViewController:myScoreVC animated:YES];

        }
        if ([titleArray[indexPath.row] isEqualToString:@"我的基金"]) {
            AssisFoundationViewController * assFoundVC = [[AssisFoundationViewController alloc]init];
            assFoundVC.navigationItem.title = @"诚信基金";
            [self.navigationController pushViewController:assFoundVC animated:YES];
        }
    }

}


-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}

@end
