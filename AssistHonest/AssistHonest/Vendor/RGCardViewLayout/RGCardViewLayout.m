//
//  RGCardViewLayout.m
//  RGCardViewLayout
//
//  Created by ROBERA GELETA on 1/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "RGCardViewLayout.h"

@implementation RGCardViewLayout
{
    CGFloat previousOffset;
    NSIndexPath *mainIndexPath;
    NSIndexPath *movingInIndexPath;
    CGFloat diffrence;
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self setupLayout];
}


- (void)setupLayout
{

    CGFloat inset  = self.collectionView.bounds.size.width * (5/64.0f);
    inset = floor(inset);

    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width - (2 *inset), self.collectionView.bounds.size.height * 3/4);
//    self.sectionInset = UIEdgeInsetsMake(inset,0, inset,0);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.minimumLineSpacing = 10;
//    self.minimumInteritemSpacing = 10;
    self.headerReferenceSize = CGSizeMake(10, self.collectionView.bounds.size.height);
    self.footerReferenceSize = CGSizeMake(10, self.collectionView.bounds.size.height);
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self applyTransformToLayoutAttributes:attributes];
    
    return attributes;
}



// indicate that we want to redraw as we scroll
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //1. 获取UICollectionView停止的时候的可视范围
    CGRect contentFrame;
    contentFrame.size = self.collectionView.frame.size;
    contentFrame.origin = proposedContentOffset;
    
    NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];
    
    //2. 计算在可视范围的距离中心线最近的Item
    CGFloat minCenterX = CGFLOAT_MAX;
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - collectionViewCenterX) < ABS(minCenterX)){
            minCenterX = attrs.center.x - collectionViewCenterX;
        }
    }
    //3. 补回ContentOffset，则正好将Item居中显示
    return CGPointMake(proposedContentOffset.x + minCenterX, proposedContentOffset.y);
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSArray *cellIndices = [self.collectionView indexPathsForVisibleItems];
    if(cellIndices.count == 0 )
    {
        return attributes;
    }
    else if (cellIndices.count == 1)
    {
        mainIndexPath = cellIndices.firstObject;
        movingInIndexPath = nil;
        
        
    }else if(cellIndices.count > 1)
    {
        NSIndexPath *firstIndexPath = cellIndices.firstObject;
        if(firstIndexPath == mainIndexPath)
        {
            movingInIndexPath = cellIndices[1];
            
        }
        else
        {
            movingInIndexPath = cellIndices.firstObject;
            mainIndexPath = cellIndices[1];
        }
        
    }
    
    diffrence =  self.collectionView.contentOffset.x - previousOffset;
    
    previousOffset = self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attribute in attributes)
    {
        [self applyTransformToLayoutAttributes:attribute];
    }
    return  attributes;
}




- (void)applyTransformToLayoutAttributes:(UICollectionViewLayoutAttributes *)attribute
{
    if(attribute.indexPath.section == mainIndexPath.section)
    {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:mainIndexPath];
        attribute.transform3D = [self transformFromView:cell];
        
    }
    else if (attribute.indexPath.section == movingInIndexPath.section)
    {
        
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:movingInIndexPath];
        attribute.transform3D = [self transformFromView:cell];
    }
}


- (CGRect)newFrameFromOriginal:(CGRect)orginalFrame withView:(UIView *)view
{
//    CGFloat computedY = [self heightOffsetForView:view];
    return orginalFrame;

}


#pragma mark - Logica
- (CGFloat)baseOffsetForView:(UIView *)view
{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)view;
    CGFloat offset =  ([self.collectionView indexPathForCell:cell].section) * self.collectionView.bounds.size.width;
    
    return offset;
}

- (CGFloat)heightOffsetForView:(UIView *)view
{
    CGFloat height;
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat scrollViewWidth = self.collectionView.bounds.size.width;
    //TODO:make this constant a certain proportion of the collection view
    height = 120 * (currentOffset - baseOffsetForCurrentView)/scrollViewWidth;
    if(height < 0 )
    {
        height = - 1 *height;
    }
    return height;
}

- (CGFloat)angleForView:(UIView *)view
{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat scrollViewWidth = self.collectionView.bounds.size.width;
    CGFloat angle = (currentOffset - baseOffsetForCurrentView)/scrollViewWidth;
    return angle;
}

- (BOOL)xAxisForView:(UIView *)view
{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view ];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat offset = (currentOffset - baseOffsetForCurrentView);
    if(offset >= 0)
    {
        return YES;
    }
    return NO;
    
}

#pragma mark - Transform Related Calculation
- (CATransform3D)transformFromView:(UIView *)view
{
    CGFloat angle = [self angleForView:view];
    CGFloat height = [self heightOffsetForView:view];
    BOOL xAxis = [self xAxisForView:view];
    return [self transformfromAngle:angle height:height xAxis:xAxis];
}

- (CATransform3D)transformfromAngle:(CGFloat )angle height:(CGFloat) height xAxis:(BOOL)axis
{
    CATransform3D t = CATransform3DIdentity;
    t.m34  = 1.0/-500;
    
    if (axis)
    {
        t = CATransform3DRotate(t,angle, 1, 1, 0);
    }
    else
    {
        t = CATransform3DRotate(t,angle, -1, 1, 0);
    }
    //    t = CATransform3DTranslate(t, 0, height, 0);
    
    return t;
}




@end

