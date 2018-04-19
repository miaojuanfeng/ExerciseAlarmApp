//
//  ValidateController.m
//  alarm
//
//  Created by USER on 13/4/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "ValidateController.h"
#import "PasswordController.h"

@interface ValidateController ()

@property AppDelegate *appDelegate;

@property UITextField *codeField;

@end

@implementation ValidateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"註冊";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+100, self.view.frame.size.width-40, 30)];
    phoneLabel.text = @"請輸入驗證碼";
    phoneLabel.font = [UIFont systemFontOfSize:18.0f];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(200/2, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+50, self.view.frame.size.width-200, 40)];
    //    textView.backgroundColor = RGBA_COLOR(44, 106, 81, 1);
    
    self.codeField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, textView.frame.size.width, textView.frame.size.height)];
    self.codeField.backgroundColor = [UIColor whiteColor];
    self.codeField.keyboardType = UIKeyboardTypePhonePad;
    self.codeField.placeholder = @"請輸入驗證碼";
    CALayer *phoneFieldBorder = [CALayer layer];
    phoneFieldBorder.frame = CGRectMake(0.0f, self.codeField.frame.size.height-1, self.codeField.frame.size.width, BORDER_WIDTH);
    phoneFieldBorder.backgroundColor = BORDER_COLOR;
    [self.codeField.layer addSublayer:phoneFieldBorder];
    [textView addSubview:self.codeField];
    
    
    [self.view addSubview:textView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200/2, textView.frame.origin.y+textView.frame.size.height+50, self.view.frame.size.width-200, 44)];
    submitButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickNextButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)clickNextButton {
    [self.view endEditing:YES];
    
    NSString *code = [[self.appDelegate md5:[NSString stringWithFormat:@"ios!mM$*9%@%@Rd#s&D2%@", self.phoneCode, self.phoneNumber, self.codeField.text]] lowercaseString];
    
    if( [self.codeField.text isEqualToString:@""] || self.codeField.text.length != 4 || ![code isEqualToString:self.verifyCode] ){
        HUD_TOAST_SHOW(@"驗證碼不正確");
        return;
    }
    
    PasswordController *passwordController = [[PasswordController alloc] init];
    [self.navigationController pushViewController:passwordController animated:YES];
}


@end
