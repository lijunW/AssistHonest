//
//  SetupViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()
@property(nonatomic,strong)NSMutableArray * titleArray;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setupSubViews];
    [self setSubviewContains];
}

-(void)setData{
    NSArray * title1Array = @[@"账户安全",@"我手机号",@"密码管理"];
    NSArray * titl2Array = @[@"通用",@"隐私"];
    NSArray * titl3Array = @[@"联系我们",@"关于"];
    [self.titleArray addObject:title1Array];
    [self.titleArray addObject:titl2Array];
    [self.titleArray addObject:titl3Array];
    [self.tableView reloadData];
}

-(void)setupSubViews{
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = ({
        UIButton * footView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [footView setTitle:@"退出登录" forState:0];
        [footView.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [footView setTitleColor:[UIColor blackColor] forState:0];
        footView.backgroundColor = [UIColor whiteColor];
        [footView addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        footView;
    });
}

//退出登录
-(void)loginOut{
    
    LoginViewController * logVC = [[LoginViewController alloc]init];
    UINavigationController * logNav = [[UINavigationController alloc]initWithRootViewController:logVC];
    [[UIApplication sharedApplication] delegate].window.rootViewController = logNav;
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
    return [self.titleArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 2 ? 20: 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Setting"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Setting"];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    
    {
        NSArray * titleArray = [self.titleArray objectAtIndex:indexPath.section];
        cell.textLabel.text = titleArray[indexPath.row];
    }
    return cell;
}



-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}
@end
