//
//  HudTool.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "HudTool.h"
@interface ALiProgressHUD : SVProgressHUD

@end

@implementation ALiProgressHUD
+ (void)initialize
{
    //    [self setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
    //    [self setInfoImage:[UIImage imageNamed:@"HUD_info"]];
    //    [self setErrorImage:[UIImage imageNamed:@"HUD_error"]];
    
    //    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleLight];
    [self setCornerRadius:8.0];
    [self setMinimumDismissTimeInterval:2];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:SVProgressHUDDidReceiveTouchEventNotification object:nil] subscribeNext:^(id x) {
        [self dismiss];
    }];
}
//// 根据 提示文字字数，判断 HUD 显示时间
//- (NSTimeInterval)displayDurationForString:(NSString*)string
//{
//    return MAX((float)string.length*0.06 + 0.5, 2);
//}
//// 修改 HUD 颜色，需要取消混合效果(使`backgroundColroForStyle`方法有效)
//- (void)updateBlurBounds{
//}
//// HUD 颜色
//- (UIColor*)backgroundColorForStyle{
//    return [UIColor colorWithWhite:0 alpha:0.9];
//}

@end


@implementation HudTool
+ (void)showTSNotificationWithTitle:(NSString *)message
                               type:(TSMessageNotificationType)type{
}
+ (void)showTSNotificationWithTitle:(NSString *)title
                           subtitle:(NSString *)subtitle
                               type:(TSMessageNotificationType)type{ 
}
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                     title:(NSString *)title
                                  subtitle:(NSString *)subtitle
                                      type:(TSMessageNotificationType)type{
}
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                     title:(NSString *)title
                                  subtitle:(NSString *)subtitle
                                      type:(TSMessageNotificationType)type
                                  duration:(NSTimeInterval)duration{
}
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                     title:(NSString *)title
                                  subtitle:(NSString *)subtitle
                                      type:(TSMessageNotificationType)type
                                  duration:(NSTimeInterval)duration
                      canBeDismissedByUser:(BOOL)dismissingEnabled{
}
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                     title:(NSString *)title
                                  subtitle:(NSString *)subtitle
                                     image:(UIImage *)image
                                      type:(TSMessageNotificationType)type
                                  duration:(NSTimeInterval)duration
                                  callback:(void (^)())callback
                               buttonTitle:(NSString *)buttonTitle
                            buttonCallback:(void (^)())buttonCallback
                                atPosition:(TSMessageNotificationPosition)messagePosition
                      canBeDismissedByUser:(BOOL)dismissingEnabled{
    [TSMessage showNotificationInViewController:viewController title:title subtitle:subtitle image:image type:type duration:TSMessageNotificationDurationAutomatic callback:callback buttonTitle:buttonTitle buttonCallback:buttonCallback atPosition:TSMessageNotificationPositionNavBarOverlay canBeDismissedByUser:dismissingEnabled];
}
+ (BOOL)dismissTSActiveNotification{
    return [TSMessage dismissActiveNotification];
}




+ (void)showText:(NSString *)aText
{
    [ALiProgressHUD showWithStatus:aText];
}


+ (void)showErrorText:(NSString *)aText
{
    [ALiProgressHUD showErrorWithStatus:aText];
}

+ (void)showSuccessText:(NSString *)aText
{
    [ALiProgressHUD showSuccessWithStatus:aText];
}

+ (void)showLoading
{
    [ALiProgressHUD show];
}


+ (void)dismissLoading
{
    [ALiProgressHUD dismiss];
}

+ (void)showProgress:(NSInteger)progress
{
    [ALiProgressHUD showProgress:progress status:[NSString stringWithFormat:@"%li%%",(long)progress]];
}

+ (void)showImage:(UIImage*)image text:(NSString*)aText
{
    [ALiProgressHUD showImage:image status:aText];
}




+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withDoneButtonTitle:(NSString *)done{
     [self showAlertWithTitle:title withSubtitle:subTitle withCustomImage:[UIImage imageNamed:@"握手"] withDoneButtonTitle:done andButtons:nil];
}

+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withDoneButtonTitle:(NSString *)done andButtons:(NSArray *)buttons{
    [self showAlertWithTitle:title withSubtitle:subTitle withCustomImage:[UIImage imageNamed:@"握手"] withDoneButtonTitle:done andButtons:buttons];
}

//Alert
+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withCustomImage:(UIImage *)image withDoneButtonTitle:(NSString *)done andButtons:(NSArray *)buttons{
    FCAlertView *alert = [[FCAlertView alloc] init];
    //alert.colorScheme;
    alert.colorScheme = [ThemeTool mainThemeColor];
    alert.tintColor = [UIColor purpleColor];
    
    //alert.titleColor =
    //alert.subTitleColor
    alert.cornerRadius = 5;
    //[alert showAlertTitle]
    alert.bounceAnimations = YES;
    //[alert makeAlertTypeCaution];
    alert.blurBackground = YES;
    alert.bounceAnimations = YES;
    //alert.alertViewTextField
    //[alert sound]
    alert.darkTheme = YES;
    //[alert roundButtons]
    //alert.numberOfButtons
    //alert.autoHideSeconds =
    alert.dismissOnOutsideTouch = YES;
    //alert.hideDoneButton
   // alert.hideAllButtons
    alert.avoidCustomImageTint=YES;
    alert.fullCircleCustomImage = NO;
    alert.hideSeparatorLineView = YES;
    //alert.animateAlertInFromLeft
    //alert.animateAlertOutToLeft
    [alert showAlertWithTitle:title withSubtitle:subTitle withCustomImage:image withDoneButtonTitle:done andButtons:buttons];
}
@end
