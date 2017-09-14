//
//  AssisFoundationViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "AssisFoundationViewController.h"
#import "PersonalTableViewCell.h"

@interface AssisFoundationViewController ()

@end

@implementation AssisFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}
-(void)setupSubViews{
    
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [ThemeTool mainThemeColor];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"总资产";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    
    
    UICountingLabel *myLabel = [[UICountingLabel alloc] init];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont fontWithName:@"Avenir Next" size:48];
    myLabel.textColor = [UIColor goldenrodColor];
    [self.view addSubview:myLabel];
    //设置格式
    myLabel.format = @"%.2f";
    //设置分隔符样式
    myLabel.positiveFormat = @"###,##0.00";
    //设置变化范围及动画时间
    [myLabel countFrom:0.00
                         to:3048.64
               withDuration:1.0f];
    
    //Shimmer
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] init];
    shimmeringView.contentView = myLabel;
    shimmeringView.shimmering = YES;


    
    [headerView addSubview:titleLabel];
    [headerView addSubview:shimmeringView];
    
    //self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
    

    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.centerX.mas_offset(0);
        make.height.mas_equalTo(headerView).multipliedBy(0.3);
    }];
    [shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.centerX.mas_offset(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
    }];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    //饼图
    UIView * pieView = [[UIView alloc]init];
    pieView.backgroundColor = [ThemeTool mainThemeColor];
    
    [self.view addSubview:headerView];
    [self.view addSubview:pieView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.2);
    }];
    
    [pieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.3);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightGreen description:@"来自捐赠"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNRed description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNBrown description:@"GOOG I/O"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNYellow description:@"罚款给"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNBlue description:@"平台收益"]
                       ];
    
    PNPieChart * pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH*0.55, SCREEN_HEIGHT*0.3) items:items];
    
    pieChart.descriptionTextColor = [UIColor clearColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    pieChart.descriptionTextShadowColor = [UIColor clearColor];
    pieChart.showAbsoluteValues = NO;
    pieChart.showOnlyValues = YES;
    //pieChart.hideValues = YES;
    
//    pieChart.innerCircleRadius = 1;
//    [pieChart recompute];
    
    [pieChart strokeChart];
    
    
    pieChart.legendStyle = PNLegendItemStyleStacked;
    pieChart.legendPosition = PNLegendPositionRight;
    pieChart.legendFontColor = [UIColor whiteSmoke];
    pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [pieChart getLegendWithMaxWidth:SCREEN_WIDTH*0.4];
    
    [pieView addSubview:legend];
    [pieView addSubview:pieChart];
    
    [pieChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(0);
        make.top.mas_offset(20);
        make.bottom.mas_offset(-20);
        make.width.mas_equalTo(SCREEN_WIDTH*0.55);
    }];
    [legend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pieChart.mas_right).offset(20);
        make.centerY.mas_offset(0);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(pieChart.mas_height);
    }];
    
    //TableVIew
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.top.mas_equalTo(pieView.mas_bottom).offset(0);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return ({
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"资产明细";
        label;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        //cell.imageView.backgroundColor = [UIColor blueColor];
    }
    
    {
        NSArray * titleArray = @[@"余额",@"银行卡",@"其他"];
        [cell.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"Personal_%ld",indexPath.row+1]]];
        cell.textLabel.text = titleArray[indexPath.row];
    }
    return cell;
}

@end
