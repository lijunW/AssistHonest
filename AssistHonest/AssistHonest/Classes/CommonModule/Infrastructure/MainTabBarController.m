//
//  MainTabBarController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

static id _instace;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{   //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}

+ (instancetype)shareInstancetype{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.®
    [self addChildVC];
}

//-(void)viewWillAppear:(BOOL)animated{
//    if (self.tabBar.hidden) {
//        [self.tabBar setHidden:NO];
//    }
//}


- (void)addChildVC{
    [self addChildVC:[MainPageViewController new] title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    [self addChildVC:[ShopViewController new] title:@"商城" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    [self addChildVC:[FriendsViewController new] title:@"朋友" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    [self addChildVC:[PersonalViewController new] title:@"我的" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
}

- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectImage:(NSString *)selectedImageName {
    
    //设置标题
    childVc.title = title;
    
    //设置图标偏移量
    //childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //设置图标
    UIImage * image = [UIImage imageNamed:imageName];
    //image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = image;
    
    //设置选中图标
    UIImage * selectedImage = [UIImage imageNamed:selectedImageName];
    //selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置背景
    //self.tabBar.backgroundImage = [UIImage imageWithBgColor:[UIColor clearColor]];//[UIImage imageNamed:@"tabBar_bg"];
    //self.tabBar.shadowImage = [UIImage imageWithBgColor:[UIColor clearColor]];
    //添加导航控制器
    BaseNavigationController  *nav = [[BaseNavigationController alloc]initWithRootViewController:childVc];
    //childVc.navigationItem.title = title;
    [self addChildViewController:nav];
}


- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item
{
    //    CATransition *animation =[CATransition animation];
    //    [animation setDuration:0.5f];
    //    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    //    [self.view.layer addAnimation:animation forKey:@"Fade"];
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    [self animationWithIndex:index];
    
    //    if (self.selectedIndex != index) {
    //        [self animationWithIndex:index];
    //    }
    
    //    CATransition* animation = [CATransition animation];
    //    [animation setDuration:0.25f];
    //    [animation setType:kCATransitionFade];
    //    [animation setSubtype:kCATransitionFromRight];
    //    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    //    [[self.view layer] addAnimation:animation forKey:@"switchView"];
}
// 动画
- (void)animationWithIndex:(NSInteger) index {
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
//    //    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    //    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    //    pulse.duration = 0.08;
//    //    pulse.repeatCount= 1;
//    //    pulse.autoreverses= YES;
//    //    pulse.fromValue= [NSNumber numberWithFloat:0.7];
//    //    pulse.toValue= [NSNumber numberWithFloat:1.3];
//    //    [[tabbarbuttonArray[index] layer]
//    //     addAnimation:pulse forKey:nil];
//    
//    [UIView transitionWithView:tabbarbuttonArray[index] duration: 0.25 options: UIViewAnimationOptionTransitionFlipFromRight animations: ^{
//        
//    } completion: ^(BOOL finished) {}];
}
+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[ThemeTool mainThemeColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    UITabBar * tabbar = [UITabBar appearance];
    [tabbar setTintColor:[ThemeTool mainThemeColor]];
    
    tabbar.translucent = NO;
//    [tabbar setBackgroundImage:[UIImage imageWithColor:[UIColor black25PercentColor]]];
}

@end
