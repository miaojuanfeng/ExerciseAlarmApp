//
//  PwdController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "PwdController.h"
#import <AFNetworking/AFNetworking.h>

@interface PwdController ()
@property AppDelegate *appDelegate;

@property UITextField *oldPwdField;
@property UITextField *pwdField;
@property UITextField *cmfPwdField;
@end

@implementation PwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密碼";
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UILabel *oldPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop, self.view.frame.size.width-10, 64)];
    oldPwdLabel.text = @"輸入原密碼：";
    [self.view addSubview:oldPwdLabel];
    
    self.oldPwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+46, self.view.frame.size.width-20, 34)];
    self.oldPwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.oldPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.oldPwdField setSecureTextEntry:YES];
    [self.view addSubview:self.oldPwdField];
    
    UILabel *newPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop+76, self.view.frame.size.width-10, 64)];
    newPwdLabel.text = @"輸入新密碼：";
    [self.view addSubview:newPwdLabel];
    
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+124, self.view.frame.size.width-20, 34)];
    self.pwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.pwdField setSecureTextEntry:YES];
    [self.view addSubview:self.pwdField];
    
    UILabel *cnfPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop+156, self.view.frame.size.width-10, 64)];
    cnfPwdLabel.text = @"確認新密碼：";
    [self.view addSubview:cnfPwdLabel];
    
    self.cmfPwdField = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop+204, self.view.frame.size.width-20, 34)];
    self.cmfPwdField.borderStyle = UITextBorderStyleRoundedRect;
    self.cmfPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.cmfPwdField setSecureTextEntry:YES];
    [self.view addSubview:self.cmfPwdField];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, marginTop+286, self.view.frame.size.width-20, 44)];
    submitButton.backgroundColor = [UIColor blueColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickSaveButton {
    if( [self.oldPwdField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請輸入原密碼");
        return;
    }
    
    if( [self.pwdField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請輸入新密碼");
        return;
    }
    
    if( [self.cmfPwdField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請再次輸入新密碼");
        return;
    }
    
    if( ![self.pwdField.text isEqualToString:self.cmfPwdField.text] ){
        HUD_TOAST_SHOW(@"兩次密碼輸入不一致");
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"user_id":[self.appDelegate.user objectForKey:@"id"], @"user_password":self.pwdField.text};
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:BASE_URL(@"user/update_password") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            HUD_TOAST_POP_SHOW(@"修改成功", nil);
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

@end
