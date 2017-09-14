//
//  FoundCustomViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "FoundCustomViewController.h"
#import "CategoryCell.h"
#import "Categorys.h"
#import "ProductHeadView.h"
@interface FoundCustomViewController ()
@property (nonatomic,strong) UITableView * categoriesTableView;

@property (nonatomic,strong) UITableView * productsTableView;
//判断是否从下往上滑
@property (nonatomic) BOOL isScrollDown;
//记录上次滑动位置
@property (nonatomic) CGFloat lastOffsetY;

@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation FoundCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * categories = [[NSMutableArray alloc] initWithObjects:@"资金",@"项目",@"技术",@"设备",@"机会",@"工人",@"管理者", nil];

    for (NSString * oject in categories) {
        Categorys * category = [[Categorys alloc]init];
        category.name = oject;
        category.products = [[NSMutableArray alloc] initWithObjects:@"打我阿德",@"打我的",@"技恩给术",@"设 恶搞色e备",@"机会恩恩色",@"工啊额嘎嘎人",@"管理人给色者",@"全部啊各色会员", nil];
        [self.dataArray addObject:category];
    }
    [self setTableView];
    
    [self.categoriesTableView reloadData];
    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)setTableView
{
    self.categoriesTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tabView.backgroundColor = COLOR_BG;
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.categoriesTableView];
    [self.categoriesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.25);
    }];
    
    self.productsTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tabView.backgroundColor = COLOR_BG;
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.productsTableView];
    [self.productsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.left.mas_equalTo(self.categoriesTableView.mas_right);
    }];
//    LMJRefreshHeader * header =[LMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
//    self.productsTableView.mj_header  = header;

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:self.categoriesTableView]) {
        return  1;
    }else{
        return self.dataArray.count;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.categoriesTableView]) {
            return  self.dataArray.count;
    }else{
        return [[self.dataArray[section] products] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.categoriesTableView]) {
        return 40;
    }else{
        return 85;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:self.categoriesTableView]) {
        return 0.01;
    }else{
        return 25;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.categoriesTableView]) {
        return [UIView new];
    }else{
        ProductHeadView * head =[ProductHeadView headerCellWith:tableView];
        head.title = [self.dataArray[section] name];
        return head;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.categoriesTableView]) {
        CategoryCell *cell = [CategoryCell cellWithTable:tableView];
        cell.title = [self.dataArray[indexPath.row] name];
        return cell;
    }else{
        UITableViewCell * cell = [self.productsTableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        }
        //cell.textLabel.text = [self.dataArray[indexPath.section] products][indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"message_placeholder_picture"];
        cell.textLabel.text = @"求找一份高薪工作";
        cell.detailTextLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([tableView isEqual:self.categoriesTableView]) {
        return ;
    }else{
        if (!self.isScrollDown && tableView.dragging) {
            [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if ([tableView isEqual:self.categoriesTableView]) {
        return ;
    }else{
        if (self.isScrollDown && tableView.dragging) {
            [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section+1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.categoriesTableView]) {
        [self.productsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }else{
        return ;
    }
}
#pragma scorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.categoriesTableView]) {
        return ;
    }else{
        self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
        self.lastOffsetY = scrollView.contentOffset.y;
    }
}

#pragma mark CategoryTableViewDelagate





-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

@end
