//
//  LoginController.m
//  alarm
//
//  Created by Dreamover Studio on 18/3/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGBA_COLOR(245, 245, 245, 1);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40-25, 44, 40, 24)];
    [registButton setTitle:@"註冊" forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(clickForgetPwdButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(50/2, (self.view.frame.size.height-100)/2-100, self.view.frame.size.width-50, 100)];
    userView.backgroundColor = [UIColor whiteColor];
    
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, userView.frame.size.width-20, 34)];
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.placeholder = @"用戶名";
    CALayer *userFieldBorder = [CALayer layer];
    userFieldBorder.frame = CGRectMake(0.0f, userField.frame.size.height-1, userField.frame.size.width, BORDER_WIDTH);
    userFieldBorder.backgroundColor = BORDER_COLOR;
    [userField.layer addSublayer:userFieldBorder];
    [userView addSubview:userField];
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, userField.frame.origin.y+userField.frame.size.height+10, userView.frame.size.width-20, 34)];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.placeholder = @"密碼";
    [passwordField setSecureTextEntry:YES];
    CALayer *passwordFieldBorder = [CALayer layer];
    passwordFieldBorder.frame = CGRectMake(0.0f, passwordField.frame.size.height-1, passwordField.frame.size.width, BORDER_WIDTH);
    passwordFieldBorder.backgroundColor = BORDER_COLOR;
    [passwordField.layer addSublayer:passwordFieldBorder];
    [userView addSubview:passwordField];
    
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
    
}

- (void)clickForgetPwdButton {
    
}


@end
