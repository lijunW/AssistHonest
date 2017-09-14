//
//  ViewController.m
//  SJQRCode
//
//  Created by Sunjie on 16/11/15.
//  Copyright © 2016年 Sunjie. All rights reserved.
//
//  读取相册中的二维码只支持ios8以上的系统
//
// 项目还未完成，将继续更新。
//
//
// 初次封装代码，有不足的地方，请大神指教  邮箱：15220092519@163.com
//
//
#import "SJViewController.h"
#import "SJScanningView.h"
#import "SJCameraViewController.h"
#import "UIAlertView+SJAddtions.h"

#define kIsAuthorizedString @"请在iOS - 设置 － 隐私 － 相机 中打开相机权限"
#define kiOS8 [[UIDevice currentDevice].systemVersion integerValue]

@interface SJViewController ()<SJCameraControllerDelegate,SJScanningViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIView *preview;
@property (nonatomic, strong) SJScanningView *scanningView;
@property (nonatomic, strong) SJCameraViewController *cameraController;
@property (nonatomic, strong) UIImagePickerController *pickerController;

@end

@implementation SJViewController

#pragma mark - Properts

- (SJScanningView *)scanningView {
    if (_scanningView == nil) {
        _scanningView = [[SJScanningView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        _scanningView.scanningDelegate = self;
    }
    return _scanningView;
}

- (UIView *)preview {
    if (!_preview) {
        _preview = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _preview;
}

- (SJCameraViewController *)cameraController {
    if (!_cameraController) {
        _cameraController = [[SJCameraViewController alloc] init];
        _cameraController.delegate = self;
    }
    return _cameraController;
}

- (UIImagePickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerController.delegate = self;
        _pickerController.allowsEditing = NO;
    }
    return _pickerController;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self isCameraIsAuthorized]) {
        [self setupView];
    } else {
        UIAlertView *alert  =  [UIAlertView alertViewTitle:@"相机权限提示" message:kIsAuthorizedString  delegate:self cancelButtonTitle:@"知道了"];
        alert.tag = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SetUp View

/** 建立视图 */
- (void)setupView {
    [self.view addSubview:self.preview];
    [self.view addSubview:self.scanningView];
    [self.cameraController showCaptureOnView:self.preview];
    [self.scanningView scanning];
}

#pragma mark - The Camera is Authorized

/** 是否授权 */
- (BOOL)isCameraIsAuthorized {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied){
        return NO;
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }
    return YES;
}

#pragma mark - SJScanningViewDelegate BarBUttonItem 点击事件

/** 按钮的点击事件 */
- (void)clickBarButtonItemSJButtonType:(SJButtonType)type {
    if (type == SJButtonTypeReturn) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (type == SJButtonTypeTorch) {
        [self setTorchMode];
    } else if (type == SJButtonTypeAlbum) {
        [self openImagePickerController];
    }
}

#pragma mark - Configuration Torch

/** 配置手电筒 */
- (void)setTorchMode {
    if ([self.cameraController cameraHasTorch]) {
        [self configurationTorch];
    } else {
        return;
    }
}

#pragma mark - Torch Click


- (void)configurationTorch {
    UIButton *button = [self.scanningView viewWithTag:SJButtonTypeTorch];
    button.selected = !button.selected;
    if (button.selected) {
        [self.cameraController setTorchMode:AVCaptureTorchModeOn];
    } else {
        [self.cameraController setTorchMode:AVCaptureTorchModeOff];
    }
}

#pragma mark - Open imagePickController

/** 打开相册 */
- (void)openImagePickerController {
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

#pragma mark - SJCameraControllerDelegate 

/** codesString 扫描二维码返回的结果 */
- (void)didDetectCodes:(NSString *)codesString {
    [self.scanningView removeScanningAnimations];
    if (self.successBlock) {
        self.successBlock(codesString);
    }
}


#pragma mark - UIImagePickerControllerDelegate 

/** alertMessageString 读取相册中二维码相册的结果*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info; {
    UIImage *pickerImage= [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *resultString = nil;
    if (kiOS8 >= 8.0) {
        resultString = [self.cameraController readAlbumQRCodeImage:pickerImage];
        if (self.successBlock) {
            self.successBlock(resultString);
        }
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - StatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [self.cameraController stopSession];
}

@end
