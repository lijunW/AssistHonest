//
//  HudTool.h
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef NS_ENUM(NSInteger, TSMessageNotificationType) {
//    TSMessageNotificationTypeMessage = 0,
//    TSMessageNotificationTypeWarning,
//    TSMessageNotificationTypeError,
//    TSMessageNotificationTypeSuccess
//};
//typedef NS_ENUM(NSInteger, TSMessageNotificationPosition) {
//    TSMessageNotificationPositionTop = 0,
//    TSMessageNotificationPositionNavBarOverlay,
//    TSMessageNotificationPositionBottom
//};
//
///** This enum can be passed to the duration parameter */
//typedef NS_ENUM(NSInteger,TSMessageNotificationDuration) {
//    TSMessageNotificationDurationAutomatic = 0,
//    TSMessageNotificationDurationEndless = -1 // The notification is displayed until the user dismissed it or it is dismissed by calling dismissActiveNotification
//};
#import "TSMessage.h"

@interface HudTool : NSObject
+ (void)showTSNotificationWithTitle:(NSString *)message
                             type:(TSMessageNotificationType)type;
+ (void)showTSNotificationWithTitle:(NSString *)title
                         subtitle:(NSString *)subtitle
                             type:(TSMessageNotificationType)type;
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type;
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type
                                duration:(NSTimeInterval)duration;
+ (void)showTSNotificationInViewController:(UIViewController *)viewController
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                                    type:(TSMessageNotificationType)type
                                duration:(NSTimeInterval)duration
                    canBeDismissedByUser:(BOOL)dismissingEnabled;
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
                    canBeDismissedByUser:(BOOL)dismissingEnabled;
+ (BOOL)dismissTSActiveNotification;


/**
 *  显示纯文本 加一个转圈
 *
 *  @param aText 要显示的文本
 */
+ (void)showText:(NSString *)aText;

/**
 *  显示错误信息
 *
 *  @param aText 错误信息文本
 */
+ (void)showErrorText:(NSString *)aText;

/**
 *  显示成功信息
 *
 *  @param aText 成功信息文本
 */
+ (void)showSuccessText:(NSString *)aText;

/**
 *  只显示一个加载框
 */
+ (void)showLoading;

/**
 *  隐藏加载框（所有类型的加载框 都可以通过这个方法 隐藏）
 */
+ (void)dismissLoading;

/**
 *  显示百分比
 *
 *  @param progress 百分比（整型 100 = 100%）
 */
+ (void)showProgress:(NSInteger)progress;

/**
 *  显示图文提示
 *
 *  @param image 自定义的图片
 *  @param aText 要显示的文本
 */
+ (void)showImage:(UIImage*)image text:(NSString*)aText;



//Alert
+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withDoneButtonTitle:(NSString *)done;
+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withDoneButtonTitle:(NSString *)done andButtons:(NSArray *)buttons;
+ (void)showAlertWithTitle:(NSString *)title withSubtitle:(NSString *)subTitle withCustomImage:(UIImage *)image withDoneButtonTitle:(NSString *)done andButtons:(NSArray *)buttons;
@end
