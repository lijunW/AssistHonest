//
//  BaseNavigationController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
+ (void)initialize
{
    UINavigationBar * bar = [UINavigationBar appearance];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTranslucent:NO];
    [bar setBarTintColor:[ThemeTool mainThemeColor]];
    
    //去掉单行跳底部的阴影线条
    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //[bar setBackgroundImage:[UIImage imageWithColor:[ThemeTool mainThemeColor] size:CGSizeMake(SCREEN_WIDTH, 64)] forBarMetrics:UIBarMetricsDefault];
    //[bar setBackgroundColor:[ThemeTool mainThemeColor]];
    [bar setShadowImage:[UIImage new]];
    
    
    // 设置title状态
    NSMutableDictionary *titleTextAttrs = [NSMutableDictionary dictionary];
    titleTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:titleTextAttrs];
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    [appearance setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *normalTextAttr = [NSMutableDictionary dictionary];
    normalTextAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:normalTextAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *highlightedTextAttr = [NSMutableDictionary dictionary];
    highlightedTextAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [appearance setTitleTextAttributes:highlightedTextAttr forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disabledTextAttr = [NSMutableDictionary dictionary];
    disabledTextAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabledTextAttr forState:UIControlStateDisabled];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果是第几个viewcontrllor push ，不执行隐藏
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
