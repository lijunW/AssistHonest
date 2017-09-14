//
//  HomeDetailView.m
//  AssistHonest
//
//  Created by Apple on 2017/1/5.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "HomeDetailView.h"
#import "MainDetailCollectionViewCell.h"
static NSString * identifier = @"cxCellID";
static NSString * headIdentifier = @"cxHeadID";
static CGFloat kMagin = 10.f;
@interface HomeDetailView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@end
@implementation HomeDetailView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return  self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView =[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        CGFloat padding = Fitsize(10, 568);
        
        CGFloat itemWidth = (SCREEN_HEIGHT*0.4*0.6-padding-padding-2) / 2.0;
        
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = padding;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = padding;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, 0, kMagin);

        //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
        flowLayout.headerReferenceSize = CGSizeMake(0,1);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册cell
        [_collectionView registerClass:[MainDetailCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        //注册header
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    const NSArray * titleArray = @[@"我要找",@"我提供",@"我求助",@"我帮扶",@"平台简介",@"成功案例",@"合作大厅"];
    //根据identifier从缓冲池里去出cell
    MainDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.section == 1&&indexPath.row == 3) {
        cell.image = [UIImage imageNamed:@"all"];
        cell.title = @"全部";
    }else{
        cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.section*4+indexPath.row]];
        cell.title = titleArray[indexPath.section*4+indexPath.row];
    }
    //cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    const NSArray * titleArray = @[@"我要找",@"我提供",@"我求助",@"我帮扶",@"平台简介",@"成功案例",@"合作大厅"];
    if (indexPath.section == 1&&indexPath.row == 3) {
        [self.buttonSignal sendNext:@"全部"];
    }else{
        NSString * title = titleArray[indexPath.section*4+indexPath.row];
        [self.buttonSignal sendNext:title];
    }
    
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    //kind有两种 一种时header 一种事footer
//    if (kind == UICollectionElementKindSectionHeader) {
//        
//        UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
//        header.backgroundColor = [UIColor darkGrayColor];
//        return header;
//    }
//    return nil;
//}
-(RACReplaySubject *)buttonSignal{
    if (!_buttonSignal) {
        _buttonSignal = [RACReplaySubject subject];
    }
    return _buttonSignal;
}
@end
