//
//  RegistViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/18.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem * registItem = [[UIBarButtonItem alloc]initWithTitle:@"条款" style:UIBarButtonItemStylePlain target:self action:@selector(tiaokuang)];
        registItem;
    });
}
//注册
- (void)tiaokuang{
    //web
    [[[RouterTool gotoViewController:@"web" transType:TransTypePush from:self.navigationController] execute:@{@"UrlStr":[[[NSBundle mainBundle] URLForResource:@"注册条款" withExtension:@"html"] absoluteString],@"Title":@"欢迎注册创翔诚信平台"}] subscribeNext:^(id x) {
    }];
}

@end
