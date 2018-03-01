//
//  PwdController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PwdController.h"

@interface PwdController ()

@end

@implementation PwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密碼";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UILabel *oldPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop, self.view.frame.size.width-10, 64)];
    oldPwdLabel.text = @"輸入原密碼：";
    [self.view addSubview:oldPwdLabel];
    
    UITextField *oldPwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+46, self.view.frame.size.width-20, 34)];
    oldPwdField.borderStyle = UITextBorderStyleRoundedRect;
    oldPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [oldPwdField setSecureTextEntry:YES];
    [self.view addSubview:oldPwdField];
    
    UILabel *newPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop+76, self.view.frame.size.width-10, 64)];
    newPwdLabel.text = @"輸入新密碼：";
    [self.view addSubview:newPwdLabel];
    
    UITextField *newPwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+124, self.view.frame.size.width-20, 34)];
    newPwdField.borderStyle = UITextBorderStyleRoundedRect;
    newPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [newPwdField setSecureTextEntry:YES];
    [self.view addSubview:newPwdField];
    
    UILabel *cnfPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop+156, self.view.frame.size.width-10, 64)];
    cnfPwdLabel.text = @"確認新密碼：";
    [self.view addSubview:cnfPwdLabel];
    
    UITextField *cnfPwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+204, self.view.frame.size.width-20, 34)];
    cnfPwdField.borderStyle = UITextBorderStyleRoundedRect;
    cnfPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cnfPwdField setSecureTextEntry:YES];
    [self.view addSubview:cnfPwdField];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, marginTop+286, self.view.frame.size.width-20, 44)];
    submitButton.backgroundColor = [UIColor blueColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitForm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitForm {
    [self.view endEditing:YES];
}

@end
