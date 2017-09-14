//
//  CategoryCell.h
//  BeeQuick_One
//
//  Created by MinJing_Lin on 16/10/22.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CategoryCell : UITableViewCell
@property(nonatomic,copy)NSString * title;
+ (instancetype)cellWithTable:(UITableView *)tableView;

@end
