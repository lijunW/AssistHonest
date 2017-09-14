//
//  LoginViewController.m
//  AssistHonest
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
@interface LoginViewController ()
@property(nonatomic,strong)UIImageView * headerImageView;
@property(nonatomic,strong)LoginInputView * nameView;
@property(nonatomic,strong)LoginInputView * passWordView;
@property(nonatomic,strong)UIButton * loginButton;
@property(nonatomic,strong)UIButton * forgotPassWprdButton;
@end

@implementation LoginViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubviews];
    [self setSubviewContains];
}
//注册
- (void)regist{
    [self.navigationController pushViewController:({
        RegistViewController * registVC  = [[RegistViewController alloc]init];
        registVC.navigationItem.title = @"注册";
        registVC;
    }) animated:YES];
}

-(void)setSubviews{
    
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    //bgImgView.image = [UIImage imageNamed:@"huoying4.jpg"];
//    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
//    // 对背景图片进行毛玻璃效果处理 参数blurRadius默认是20,可指定,最后一个参数block回调可以为nil
//    [bgImgView setImageToBlur: [UIImage imageNamed:@"LaunchScreen"] blurRadius:15 completionBlock:nil];
//    [self.view addSubview:bgImgView];


    

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    

    
    UIBarButtonItem * registItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist)];
    [registItem setTintColor:[ThemeTool mainThemeColor]];
    self.navigationItem.rightBarButtonItem =registItem;
    

    
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.passWordView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgotPassWprdButton];
    
    {
//        self.nameView.backgroundColor = [UIColor olive];
//        self.passWordView.backgroundColor = [UIColor olive];
        
        self.nameView.title = @"账号";
        self.nameView.rightIconHidden = YES;
        self.nameView.hidePassword = NO;
        self.nameView.placeHodel = @"手机号/用户名/邮箱";
        self.nameView.backgroundColor = [UIColor whiteSmoke];
        [self.nameView hyb_addCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadius:5 backgroundColor:[UIColor clearColor]];
        
        
        self.passWordView.title = @"密码";
        self.passWordView.rightIconHidden = NO;
        self.passWordView.placeHodel = @"请输入登录密码";
        self.passWordView.backgroundColor = [UIColor whiteSmoke];
        [self.passWordView hyb_addCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadius:5 backgroundColor:[UIColor clearColor]];
    }
    
    [self.headerImageView sd_setImageWithURL:[UserTool  shareInstancetype].userHeaderImageUrl placeholderImage:[UIImage imageNamed:@"header_placehodel"]];
    //[self.headerImageView hyb_addCorner:UIRectCornerAllCorners cornerRadius:5 backgroundColor:[UIColor clearColor]];
    [self.headerImageView.layer setCornerRadius:5];
    [self.headerImageView.layer setMasksToBounds:YES];
    
    [self.loginButton hyb_addCornerRadius:5];
    [self.loginButton setBackgroundColor:[ThemeTool mainThemeColor]];
    [self.loginButton setTitle:@"登录" forState:0];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:Fitsize(15, 568)]];
    [self.loginButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.forgotPassWprdButton setTitle:@"忘记密码？" forState:0];
    [self.forgotPassWprdButton setTitleColor:[ThemeTool mainThemeColor] forState:0];
    [self.forgotPassWprdButton.titleLabel setFont:[UIFont systemFontOfSize:Fitsize(15, 568)]];
    [self.forgotPassWprdButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[MainTabBarController shareInstancetype] setSelectedIndex:0];
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[MainTabBarController shareInstancetype]];
    }];
    
    [[self.forgotPassWprdButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

    }];
}
-(void)setSubviewContains{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.width.mas_equalTo(70);
        make.centerX.mas_offset(0);
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.0704);
    }];
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).offset(0.5);
        make.left.right.height.mas_equalTo(self.nameView);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordView.mas_bottom).offset(15);
        make.left.right.height.mas_equalTo(self.nameView);
    }];
    [self.forgotPassWprdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.nameView);
    }];
}


-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView hyb_addCornerRadius:4];
    }
    return _headerImageView;
}
-(LoginInputView *)nameView{
    if (!_nameView) {
        _nameView = [[LoginInputView alloc]init];
    }
    return _nameView;
}
-(LoginInputView *)passWordView{
    if (!_passWordView) {
        _passWordView = [[LoginInputView alloc]init];
    }
    return _passWordView;
}
-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
    }
    return _loginButton;
}
-(UIButton *)forgotPassWprdButton{
    if (!_forgotPassWprdButton) {
        _forgotPassWprdButton = [[UIButton alloc]init];
    }
    return _forgotPassWprdButton;
}
@end
