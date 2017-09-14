//
//  BaseViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation BaseViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //push隐藏底部tabbar
    //self.hidesBottomBarWhenPushed = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:SCREEN_RECT style:UITableViewStyleGrouped];
        _tableView.delegate =  self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        // A little trick for removing the cell separators
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"缺省页"];
}
//The attributed string for the title of the empty state:
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"这里什么都没有";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHex:@"7b8994"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"You must connect to a Wi-Fi network to control";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12.5f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHex:@"7b8994"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
  return [UIColor colorWithHex:@"f0f3f5"];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}
@end
