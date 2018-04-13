//
//  LoginController.m
//  alarm
//
//  Created by Dreamover Studio on 18/3/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "RegisterController.h"
#import "ForgetPwdController.h"
#import <AFNetworking/AFNetworking.h>

#import "PasswordController.h"

@interface LoginController ()
@property UITextField *userField;
@property UITextField *passwordField;
@property AppDelegate *appDelegate;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGBA_COLOR(245, 245, 245, 1);
    
    self.navigationItem.title = @"用戶登錄";
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40-25, 44, 40, 24)];
    [registButton setTitle:@"註冊" forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(50/2, (self.view.frame.size.height-100)/2-100, self.view.frame.size.width-50, 100)];
    userView.backgroundColor = [UIColor whiteColor];
    
    self.userField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, userView.frame.size.width-20, 34)];
    self.userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userField.placeholder = @"用戶名";
    CALayer *userFieldBorder = [CALayer layer];
    userFieldBorder.frame = CGRectMake(0.0f, self.userField.frame.size.height-1, self.userField.frame.size.width, BORDER_WIDTH);
    userFieldBorder.backgroundColor = BORDER_COLOR;
    [self.userField.layer addSublayer:userFieldBorder];
    [userView addSubview:self.userField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.userField.frame.origin.y+self.userField.frame.size.height+10, userView.frame.size.width-20, 34)];
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordField.placeholder = @"密碼";
    [self.passwordField setSecureTextEntry:YES];
    CALayer *passwordFieldBorder = [CALayer layer];
    passwordFieldBorder.frame = CGRectMake(0.0f, self.passwordField.frame.size.height-1, self.passwordField.frame.size.width, BORDER_WIDTH);
    passwordFieldBorder.backgroundColor = BORDER_COLOR;
    [self.passwordField.layer addSublayer:passwordFieldBorder];
    [userView addSubview:self.passwordField];
    
    [self.view addSubview:userView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(250/2, userView.frame.origin.y+userView.frame.size.height+50, self.view.frame.size.width-250, 44)];
    submitButton.backgroundColor = RGBA_COLOR(49, 132, 225, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"登錄" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"忘記用戶名或密碼請點擊"];
    NSRange strRange = {0, [str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    UIButton *forgetPwdButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-240)/2, submitButton.frame.origin.y+submitButton.frame.size.height+40, 240, 24)];
    [forgetPwdButton setAttributedTitle:str forState:UIControlStateNormal];
    forgetPwdButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [forgetPwdButton addTarget:self action:@selector(clickForgetPwdButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdButton];
    
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)clickLoginButton {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"user_username":self.userField.text,@"user_password":self.passwordField.text};
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:BASE_URL(@"user/signin") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
//            NSDictionary *data = [dic objectForKey:@"data"];
//            NSString *device_id = [data objectForKey:@"device_id"];
//            
//            NSMutableDictionary *device = [[NSMutableDictionary alloc] init];
//            [device setObject:device_id forKey:@"device_id"];
//            [device setObject:self.deviceTokenField.text forKey:@"device_token"];
//            [device setObject:self.deviceNameField.text forKey:@"device_name"];
//            [self.appDelegate.deviceList addObject:device];
//            
//            NSLog(@"%@", self.appDelegate.deviceList);
//            [self.appDelegate saveDeviceList:device];
//
            [self.appDelegate saveUser:[dic objectForKey:@"data"]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSString *msg = [dic objectForKey:@"msg"];
            HUD_TOAST_SHOW(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败.%@",error);
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        HUD_WAITING_HIDE;
        HUD_TOAST_SHOW(@"Network Error");
    }];
}

- (void)clickRegisterButton {
    RegisterController *registerController = [[RegisterController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
//    PasswordController *passwordController = [[PasswordController alloc] init];
//    [self.navigationController pushViewController:passwordController animated:YES];
}

- (void)clickForgetPwdButton {
    ForgetPwdController *forgetPwdController = [[ForgetPwdController alloc] init];
    [self.navigationController pushViewController:forgetPwdController animated:YES];
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}


@end
