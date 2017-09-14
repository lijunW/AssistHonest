//
//  FriendsViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}

-(void)setSubviews{
    UIBarButtonItem * tongxunlu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"通讯录"] style:UIBarButtonItemStyleDone target:self action:@selector(tongxunlu)];
    UIBarButtonItem * add = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"添加"] style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    
    self.navigationItem.rightBarButtonItems = @[add,tongxunlu];

    [self.view addSubview:self.tableView];
    [self.tableView reloadEmptyDataSet];
}

-(void)tongxunlu{
}
-(void)add{
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"敬请期待！";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
