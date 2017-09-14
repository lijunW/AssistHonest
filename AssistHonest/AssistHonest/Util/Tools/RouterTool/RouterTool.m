//
//  RouterTool.m
//  AssistHonest
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "RouterTool.h"

@implementation RouterTool
+(RACCommand *)gotoViewController:(id)viewController transType:(TransType)transType from:(UIViewController *)viewOrNav{
    if ([viewController isEqualToString:@"扫一扫"]) {
        return  [self gotoScanModuleTransType:transType from:viewOrNav];
    }else if ([viewController isEqualToString:@"web"]){
        return [self gotoWebModuleTransType:transType from:viewOrNav];
    }else{
        return nil;
    }
}


+(RACCommand *)gotoScanModuleTransType:(TransType)transType from:(UIViewController *)viewOrNav{
    
    @weakify(viewOrNav)
    
    RACCommand * scanCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            SJViewController *SJViewC = [[SJViewController alloc] init];
            /** 扫描成功返回来的数据 */
            SJViewC.successBlock = ^(NSString *successString) {
                @strongify(viewOrNav)
                if (transType==TransTypePush&&[viewOrNav isKindOfClass:[UINavigationController class]]) {
                    [(BaseNavigationController *)viewOrNav popViewControllerAnimated:YES];
                }else{
                    [viewOrNav dismissViewControllerAnimated:YES completion:nil];
                }
                NSLog(@"successBlock=%@",successString);
                
                [subscriber sendNext:successString];
                [subscriber sendCompleted];
            };
            
            if (transType==TransTypePush&&[viewOrNav                                                                                                                                                                                                                                                                                                                  isKindOfClass:[UINavigationController class]]) {
                [(BaseNavigationController *)viewOrNav pushViewController:SJViewC animated:YES];
            }else{
                [viewOrNav presentViewController:SJViewC animated:YES completion:nil];
            }
            return nil;
        }];
    }];
    return scanCommand;
}

+(RACCommand *)gotoWebModuleTransType:(TransType)transType from:(UIViewController *)viewOrNav{
    
    @weakify(viewOrNav)
    
    RACCommand * scanCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(viewOrNav)
            NSString* urlStr = input[@"UrlStr"];
            RxWebViewController* webViewController = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:urlStr]];
            webViewController.navigationItem.title = input[@"Title"];
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            if (transType==TransTypePush&&[viewOrNav isKindOfClass:[UINavigationController class]]) {
                [(BaseNavigationController *)viewOrNav pushViewController:webViewController animated:YES];
            }else{
                [viewOrNav presentViewController:webViewController animated:YES completion:nil];
            }
            return nil;
        }];
    }];
    return scanCommand;
}
@end
