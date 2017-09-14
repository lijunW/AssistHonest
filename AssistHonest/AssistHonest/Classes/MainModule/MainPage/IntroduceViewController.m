//
//  IntroduceViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.title);
    if ([self.title isEqualToString:@"平台理念"]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Introduce" withExtension:@"html"];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else if ([self.title isEqualToString:@"创始人"]){
    }else if ([self.title isEqualToString:@"运行模式"]){
    }else if ([self.title isEqualToString:@"入会方式"]){
    }
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    }
    return _webView;
}

@end
