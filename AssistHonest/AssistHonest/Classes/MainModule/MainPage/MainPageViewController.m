//
//  MainPageViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "MainPageViewController.h"

#import "HomeDetailView.h"
#import "HomeMainView.h"


#import "IntroduceViewController.h"//平台简介


#import "FoundCustomViewController.h"//我要找_通用
#import "AlllMemberViewController.h"//我要找_全部会员

#import "NewsViewController.h"//企业头条

@interface MainPageViewController ()
@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)HomeMainView * mainHeaderView;
@property(nonatomic,strong)HomeDetailView * detailHeaderView;

@property(nonatomic,strong)UISearchBar * searchBar;

@property(nonatomic,strong)UITableViewCell * cell0;
@property(nonatomic,strong)UITableViewCell * cell1;
@property(nonatomic,strong)UITableViewCell * cell2;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self setupSubViews];
    [self setSubviewContains];
}
-(void)setupSubViews{
    UIBarButtonItem * tongxunlu = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"通讯录"] style:UIBarButtonItemStyleDone target:self action:@selector(tongxunlu:)];
    tongxunlu.width = -7;
    UIBarButtonItem * add = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"添加"] style:UIBarButtonItemStyleDone target:self action:@selector(add:)];
    add.width = -7;
    
    self.navigationItem.rightBarButtonItems = @[add,tongxunlu];
    
    self.navigationItem.titleView = self.searchBar;
    
    self.mainHeaderView.backgroundColor = [ThemeTool mainThemeColor];
    self.detailHeaderView.backgroundColor = [UIColor whiteSmoke];
    
    
    [self.headerView addSubview:self.mainHeaderView];
    [self.headerView addSubview:self.detailHeaderView];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.tableView];
    
    
    //扫一扫
    [self.mainHeaderView.scanButtonSignal subscribeNext:^(id x) {
      [[[RouterTool gotoViewController:@"扫一扫" transType:TransTypePresent from:self]  execute:nil] subscribeNext:^(NSString * successString) {
            NSLog(@"successBlock=%@",successString);
            [UIAlertView alertViewTitle:@"扫描成功" message:successString delegate:self cancelButtonTitle:@"取消"];
        }];
    }];
    
    //邀请码
    [self.mainHeaderView.intermentButtonSignal subscribeNext:^(id x) {
        [HudTool showAlertWithTitle:@"邀请码" withSubtitle:@"正在拼命开发中。。。"  withDoneButtonTitle:@"关闭" andButtons:nil];
    }];

    //
    //付款
    [self.mainHeaderView.payButtonSignal subscribeNext:^(id x) {
//        [HudTool showTSNotificationInViewController:self.navigationController title:@"温馨提示" subtitle:[NSString stringWithFormat:@"点了%@",x] image:nil type:TSMessageNotificationTypeSuccess duration:TSMessageNotificationDurationAutomatic callback:nil buttonTitle:nil buttonCallback:nil atPosition:TSMessageNotificationPositionNavBarOverlay canBeDismissedByUser:YES];
        //[HudTool showTSNotificationWithTitle: subtitle:[NSString stringWithFormat:@"点了%@",x] type:TSMessageNotificationTypeSuccess];
        [TSMessage showNotificationInViewController:self.navigationController
                                              title:NSLocalizedString(@"Whoa!", nil)
                                           subtitle:NSLocalizedString(@"Over the Navigation Bar!", nil)
                                              image:nil
                                               type:TSMessageNotificationTypeSuccess
                                           duration:TSMessageNotificationDurationAutomatic
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                               canBeDismissedByUser:YES];
    }];
    //邀请码
    [self.mainHeaderView.intermentButtonSignal subscribeNext:^(id x) {
        [HudTool showTSNotificationWithTitle:@"提示" subtitle:[NSString stringWithFormat:@"点了%@",x] type:TSMessageNotificationTypeWarning];
    }];
    //诚信基金
    [self.mainHeaderView.moneyButtonSignal subscribeNext:^(id x) {
        AssisFoundationViewController * assFoundVC = [[AssisFoundationViewController alloc]init];
        assFoundVC.navigationItem.title = @"诚信基金";
        [self.navigationController pushViewController:assFoundVC animated:YES];
    }];
    
    //detailView 点击
    [self.detailHeaderView.buttonSignal subscribeNext:^(NSString * buttonTitle) {
        if ([buttonTitle isEqualToString:@"我要找"]) {
            
            FoundCustomViewController * foundVC = [[FoundCustomViewController alloc]init];
            foundVC.navigationItem.title = buttonTitle;
            [self.navigationController pushViewController:foundVC animated:YES];

        } else if ([buttonTitle isEqualToString:@"我提供"]) {
            
        }else  if ([buttonTitle isEqualToString:@"我求助"]) {
            
        }else if ([buttonTitle isEqualToString:@"我帮扶"]) {
            
        }else if ([buttonTitle isEqualToString:@"平台简介"]) {
            NSMutableArray *titles = [[NSMutableArray alloc] initWithObjects:@"平台理念",@"创始人",@"运行模式",@"入会方式", nil];
            NSMutableArray * viewControllers= [[NSMutableArray alloc] initWithObjects:[IntroduceViewController class],[IntroduceViewController class],[IntroduceViewController class],[IntroduceViewController class], nil];
            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
            pageVC.menuItemWidth = 85;
            pageVC.postNotification = YES;
            pageVC.bounces = YES;
            pageVC.hidesBottomBarWhenPushed = YES;
            pageVC.title = buttonTitle;
            pageVC.menuViewStyle = WMMenuViewStyleLine;
            pageVC.titleSizeSelected = 15;
            pageVC.progressWidth = 10;
            pageVC.progressViewIsNaughty = YES;
            [self.navigationController pushViewController:pageVC animated:YES];
        }else if ([buttonTitle isEqualToString:@"成功案例"]) {
            
        }else if ([buttonTitle isEqualToString:@"合作大厅"]) {
            
        }else{//全部
            [HudTool showAlertWithTitle:@"创翔诚信平台服务条款" withSubtitle:@"\
            因为诚信，大家可以优先共享平台内的资源，互帮互助；\
            因为诚信，成员之间的合作可以给予绝对的信任，节省巨大的时间与谈判\
            成本，规避商业合作的风险；\
            因为诚信，成员合作中给予对方最大的优惠条件，利人最终利己，实现彼\
            此的共赢。"  withDoneButtonTitle:@"同意" andButtons:@[@"不同意"]];
        }
    

//        //web
//        [[[RouterTool gotoViewController:@"web" transType:TransTypePush from:self.navigationController] execute:@{@"UrlStr":@"http://xiaofan921.w317-e1.ezwebtest.com/portal.php",@"Title":x}] subscribeNext:^(id x) {
//            
//        }];
    }];
    
    
}

-(void)tongxunlu:(UIBarButtonItem *)sender{
    [HudTool showTSNotificationWithTitle:@"提示" subtitle:@"俄方我个发生的发E分发f sdf a f a ef f乏味阿尔法俄方饿阿飞" type:TSMessageNotificationTypeMessage];
}

-(void)add:(UIBarButtonItem *)sender{
    // 附带左边图标的
    PopoverAction *action1 = [PopoverAction actionWithImage:[[UIImage imageNamed:@"contacts_add_friend"] imageByTintColor:[ThemeTool mainThemeColor]] title:@"添加朋友" handler:^(PopoverAction *action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
    }];

    PopoverAction *action2 = [PopoverAction actionWithImage:[[UIImage imageNamed:@"contacts_add_money"]imageByTintColor:[ThemeTool mainThemeColor]] title:@"我要收款" handler:^(PopoverAction *action) {

    }];

    PopoverAction *action3 = [PopoverAction actionWithImage:[[UIImage imageNamed:@"contacts_add_newmessage"]imageByTintColor:[ThemeTool mainThemeColor]] title:@"发起群聊" handler:^(PopoverAction *action) {

    }];
    PopoverAction *action4 = [PopoverAction actionWithImage:[[UIImage imageNamed:@"contacts_add_scan"]imageByTintColor:[ThemeTool mainThemeColor]] title:@"扫一扫" handler:^(PopoverAction *action) {
        [[[RouterTool gotoViewController:@"扫一扫" transType:TransTypePresent from:self]  execute:nil] subscribeNext:^(NSString * successString) {
            NSLog(@"successBlock=%@",successString);
            [UIAlertView alertViewTitle:@"扫描成功" message:successString delegate:self cancelButtonTitle:@"取消"];
        }];
    }];

    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    //popoverView.style = PopoverViewStyleDark; // 设置为黑色风格
    //popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    // 有两种显示方法
    // 1. 显示在指定的控件
    //[popoverView showToView:sender.customView withActions:@[action1,action2,action3,action4]];
    // 2. 显示在指定的点(CGPoint), 该点的坐标是相对KeyWidnow的坐标.
    [popoverView showToPoint:CGPointMake(SCREEN_WIDTH-33-10, 64) withActions:@[action1,action2,action3,action4]];
}


-(void)setSubviewContains{
    [self.mainHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_equalTo(self.headerView.mas_height).multipliedBy(0.4);
    }];
    [self.detailHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.mainHeaderView.mas_bottom).offset(0);
    }];
    
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 100;
            break;
        case 2:
            return 150;
            break;
        default:
            return 44;
            break;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        return  self.cell0;
    }
    if (indexPath.section == 1) {
        return  self.cell1;
    }
    if (indexPath.section == 2) {
        return  self.cell2;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsViewController * newsVC = [[NewsViewController alloc]init];
    newsVC.navigationItem.title =@"企业头条";
    [self.navigationController pushViewController:newsVC animated:YES];
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
    }
    return _headerView;
}

-(HomeMainView *)mainHeaderView{
    if (!_mainHeaderView) {
        _mainHeaderView = [[HomeMainView alloc]init];
    }
    return _mainHeaderView;
}

-(HomeDetailView *)detailHeaderView{
    if (!_detailHeaderView) {
        _detailHeaderView = [[HomeDetailView alloc]init];
    }
    return _detailHeaderView;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.9, 24)];
        //_searchBar.searchBarStyle
    }
    return _searchBar;
}

-(UITableViewCell *)cell0{
    if (!_cell0) {
        _cell0 = [[UITableViewCell alloc]init];
        _cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell0.imageView.image = [[UIImage imageNamed:@"hotNews"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
        
        NSMutableArray *  dataSourceArray = [NSMutableArray array];
        NSArray *typeArray = @[@"最新", @"头条", @"推荐", @"热门"];
        NSArray *titleArray = @[@"小巧便携/USB充电", @"人工智能将是微软的下一件", @"小米5s高配版拆解", @"海量新画面根本不是一个画风"];
        NSArray *URLArray = @[@"http://0", @"http://1", @"http://2", @"http://3"];
        
        for (int i = 0; i < titleArray.count; i++) {
            NSString *title = [titleArray objectAtIndex:i];
            NSString *URLString = [URLArray objectAtIndex:i];
            NSString *type = [typeArray objectAtIndex:i];
            DataSourceModel *model = [DataSourceModel dataSourceModelWithType:type title:title URLString:URLString];
            [dataSourceArray addObject:model];
        }
        XLsn0wTextCarousel *view = [[XLsn0wTextCarousel alloc] init];
        view.userInteractionEnabled = NO;
        view.dataSourceArray = dataSourceArray;
        view.currentTextInfoView.xlsn0wDelegate = self;
        view.hiddenTextInfoView.xlsn0wDelegate = self;
        view.backgroundColor =[UIColor whiteColor];
        [_cell0.contentView addSubview:view];
        
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_cell0.imageView.mas_right).offset(10);
            make.right.mas_offset(20);
            make.bottom.top.mas_offset(0);
        }];
    }
    return _cell0;
}

-(UITableViewCell *)cell1{
    if (!_cell1) {
        _cell1 = [[UITableViewCell alloc]init];
        NSArray * imageUrlsGroup = @[@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/1.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/3.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/2.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/4.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/5.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/index_about.jpg"];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,CGRectGetWidth(SCREEN_RECT),200) imageURLStringsGroup:imageUrlsGroup];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.placeholderImage = [UIImage imageNamed:@"weibo movie_yingping_pic_placeholder"];
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.autoScrollTimeInterval = 3.0;
        [_cell1.contentView addSubview:cycleScrollView];
        [cycleScrollView adjustWhenControllerViewWillAppera];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        @weakify(self)
        cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex){
            @strongify(self)
            [UIAlertView alertViewTitle:@"点击" message:[NSString stringWithFormat:@"点击了第%ld张",currentIndex] delegate:nil cancelButtonTitle:@"取消"];
            //web
            [[[RouterTool gotoViewController:@"web" transType:TransTypePush from:self.navigationController] execute:@{@"UrlStr":@"http://xiaofan921.w317-e1.ezwebtest.com/portal.php",@"Title":@""}] subscribeNext:^(id x) {
            }];
        };
    }
    return _cell1;
}
-(UITableViewCell *)cell2{
    if (!_cell2) {
        _cell2 = [[UITableViewCell alloc]init];
        NSArray * imageUrlsGroup = @[@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/case_1.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/case_2.jpg",@"http://xiaofan921.w317-e1.ezwebtest.com/template/yunshan_t5/src/case_3.jpg"];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,CGRectGetWidth(SCREEN_RECT),200) imageURLStringsGroup:imageUrlsGroup];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.placeholderImage = [UIImage imageWithBgColor:[UIColor olive]];
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        cycleScrollView.autoScrollTimeInterval = 4.0;
        [_cell2.contentView addSubview:cycleScrollView];
        [cycleScrollView adjustWhenControllerViewWillAppera];
        [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        @weakify(self)
        cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex){
            @strongify(self)
            [UIAlertView alertViewTitle:@"点击" message:[NSString stringWithFormat:@"点击了第%ld张",currentIndex] delegate:nil cancelButtonTitle:@"取消"];
            //web
            [[[RouterTool gotoViewController:@"web" transType:TransTypePush from:self.navigationController] execute:@{@"UrlStr":@"http://xiaofan921.w317-e1.ezwebtest.com/portal.php",@"Title":@""}] subscribeNext:^(id x) {
            }];
        };
    }
    return _cell2;
}
@end
