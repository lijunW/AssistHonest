//
//  MyScoreViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "MyScoreViewController.h"
#import "DWFlowLayout.h"

@interface MyScoreViewController ()<UICollectionViewDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@end

@implementation MyScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setupSubview];
}


-(void)setupSubview{
    
    [self.view addSubview:({
        SXColorGradientView *grv3 = [SXColorGradientView createWithFromColor:[UIColor black50PercentColor] toColor:[UIColor black25PercentColor] frame:SCREEN_RECT direction:SXGradientToTop];
        grv3;
    })];
    
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.segmentedControl4.sectionTitles = @[@"概览", @"积分", @"消费",@"服务"];
    self.segmentedControl4.selectedSegmentIndex = 0;
    self.segmentedControl4.selectionIndicatorHeight = 2;
    self.segmentedControl4.backgroundColor = [UIColor clearColor];
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor black75PercentColor]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor goldenrod]};
    self.segmentedControl4.selectionIndicatorColor = [UIColor goldenrod];
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    [self.view addSubview:self.segmentedControl4];

    
    DWFlowLayout *layout = [[DWFlowLayout alloc] init];
    //设置是否需要分页
    [layout setPagingEnabled:YES];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT- 64 - 60 - 60);
    layout.sectionInset = UIEdgeInsetsMake(20, 30, 20, 30);
    layout.minimumInteritemSpacing = 15;
    
    UICollectionView * co9llectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, SCREEN_HEIGHT - 64 - 60 - 60) collectionViewLayout:layout];
    co9llectView.backgroundColor = [UIColor clearColor];
    co9llectView.showsHorizontalScrollIndicator = NO;
    //co9llectView.delegate = self;
    co9llectView.dataSource = self;
    [co9llectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:co9llectView];
    
    [co9llectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-44);
        make.top.mas_equalTo(self.segmentedControl4.mas_bottom);
    }];

    //联动
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [co9llectView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
    
    @weakify(self)
    //layout.IndexWillChangeBlock = ^(NSInteger index){
        //@strongify(self)
        //[self.segmentedControl4 setSelectedSegmentIndex:index animated:YES];
    //};
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor blueberryColor];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    cell.layer.shadowColor = [UIColor goldenrod].CGColor;
    cell.layer.shadowOpacity=0.5;
}

@end
