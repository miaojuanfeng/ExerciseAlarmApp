//
//  PasswordController.m
//  alarm
//
//  Created by USER on 13/4/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "PasswordController.h"
#import <AFNetworking/AFNetworking.h>

@interface PasswordController ()

@property AppDelegate *appDelegate;

@property UITextField *nameField;
@property UITextField *passwordField;
@property UITextField *cfmPwdField;

@end

@implementation PasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"註冊";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-40)/2, marginTop+20, 40, 40)];
    logoImageView.image = [UIImage imageNamed:@"clock"];
    [self.view addSubview:logoImageView];
    
    
    
    
    UILabel *filedLabel = nil;
    UIView *filedView = nil;
    int filedViewHeight = 40;
    int filedViewGap = 15;
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(40/2, logoImageView.frame.origin.y+logoImageView.frame.size.height+50, self.view.frame.size.width-40, (filedViewHeight+filedViewGap)*4-filedViewGap)];
//    textView.backgroundColor = RGBA_COLOR(44, 106, 81, 1);
    
    // Phone
    filedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textView.frame.size.width, filedViewHeight)];
    
        filedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, filedView.frame.size.height)];
        filedLabel.text = @"手機號碼";
        [filedView addSubview:filedLabel];
    
        self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(filedLabel.frame.origin.x+filedLabel.frame.size.width+10, 0, filedView.frame.size.width-filedLabel.frame.size.width-10, filedView.frame.size.height)];
        self.phoneField.backgroundColor = [UIColor whiteColor];
        self.phoneField.keyboardType = UIKeyboardTypePhonePad;
        self.phoneField.enabled = NO;
        CALayer *phoneFieldBorder = [CALayer layer];
        phoneFieldBorder.frame = CGRectMake(0.0f, self.phoneField.frame.size.height-1, self.phoneField.frame.size.width, BORDER_WIDTH);
        phoneFieldBorder.backgroundColor = BORDER_COLOR;
        [self.phoneField.layer addSublayer:phoneFieldBorder];
        [filedView addSubview:self.phoneField];
    
    [textView addSubview:filedView];
    // Name
    filedView = [[UIView alloc] initWithFrame:CGRectMake(0, filedViewHeight+filedViewGap, textView.frame.size.width, filedViewHeight)];
    
        filedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, filedView.frame.size.height)];
        filedLabel.text = @"用戶名";
        [filedView addSubview:filedLabel];
    
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(filedLabel.frame.origin.x+filedLabel.frame.size.width+10, 0, filedView.frame.size.width-filedLabel.frame.size.width-10, filedView.frame.size.height)];
        self.nameField.backgroundColor = [UIColor whiteColor];
        self.nameField.placeholder = @"請設置用戶名";
        CALayer *nameFieldBorder = [CALayer layer];
        nameFieldBorder.frame = CGRectMake(0.0f, self.nameField.frame.size.height-1, self.nameField.frame.size.width, BORDER_WIDTH);
        nameFieldBorder.backgroundColor = BORDER_COLOR;
        [self.nameField.layer addSublayer:nameFieldBorder];
        [filedView addSubview:self.nameField];
    
    [textView addSubview:filedView];
    // Password
    filedView = [[UIView alloc] initWithFrame:CGRectMake(0, (filedViewHeight+filedViewGap)*2, textView.frame.size.width, filedViewHeight)];
    
        filedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, filedView.frame.size.height)];
        filedLabel.text = @"設置密碼";
        [filedView addSubview:filedLabel];
    
        self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(filedLabel.frame.origin.x+filedLabel.frame.size.width+10, 0, filedView.frame.size.width-filedLabel.frame.size.width-10, filedView.frame.size.height)];
        self.passwordField.backgroundColor = [UIColor whiteColor];
        self.passwordField.secureTextEntry = YES;
        self.passwordField.placeholder = @"請設置密碼";
        CALayer *passwordFieldBorder = [CALayer layer];
        passwordFieldBorder.frame = CGRectMake(0.0f, self.passwordField.frame.size.height-1, self.passwordField.frame.size.width, BORDER_WIDTH);
        passwordFieldBorder.backgroundColor = BORDER_COLOR;
        [self.passwordField.layer addSublayer:passwordFieldBorder];
        [filedView addSubview:self.passwordField];
    
        [textView addSubview:filedView];
    // Confirm Pwd
    filedView = [[UIView alloc] initWithFrame:CGRectMake(0, (filedViewHeight+filedViewGap)*3, textView.frame.size.width, filedViewHeight)];
    
        filedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, filedView.frame.size.height)];
        filedLabel.text = @"確認密碼";
        [filedView addSubview:filedLabel];
    
        self.cfmPwdField = [[UITextField alloc] initWithFrame:CGRectMake(filedLabel.frame.origin.x+filedLabel.frame.size.width+10, 0, filedView.frame.size.width-filedLabel.frame.size.width-10, filedView.frame.size.height)];
        self.cfmPwdField.backgroundColor = [UIColor whiteColor];
        self.cfmPwdField.secureTextEntry = YES;
        self.cfmPwdField.placeholder = @"請再次輸入密碼";
        CALayer *cfmPwdFieldBorder = [CALayer layer];
        cfmPwdFieldBorder.frame = CGRectMake(0.0f, self.cfmPwdField.frame.size.height-1, self.cfmPwdField.frame.size.width, BORDER_WIDTH);
        cfmPwdFieldBorder.backgroundColor = BORDER_COLOR;
        [self.cfmPwdField.layer addSublayer:cfmPwdFieldBorder];
        [filedView addSubview:self.cfmPwdField];
    
        [textView addSubview:filedView];
    
    [self.view addSubview:textView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200/2, textView.frame.origin.y+textView.frame.size.height+50, self.view.frame.size.width-200, 44)];
    submitButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)clickSubmitButton {
    [self.view endEditing:YES];
    
    if( [self.nameField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請輸入用戶名");
        return;
    }
    
    if( [self.passwordField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請輸入密碼");
        return;
    }
    
    if( [self.cfmPwdField.text isEqualToString:@""] ){
        HUD_TOAST_SHOW(@"請再次輸入密碼");
        return;
    }
    
    if( ![self.cfmPwdField.text isEqualToString:self.passwordField.text] ){
        HUD_TOAST_SHOW(@"兩次密碼輸入不一致");
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{
                               @"user_username":self.phoneField.text,
                               @"user_nickname":self.nameField.text,
                               @"user_password":self.passwordField.text,
                               @"user_platform":@"ios"
                               };
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:BASE_URL(@"user/signup") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            HUD_TOAST_POP_SHOW(@"註冊成功", [self.navigationController.viewControllers objectAtIndex:0]);
        }else{
            HUD_TOAST_SHOW(MSG_ERROR_NETWORK);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败.%@",error);
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        HUD_WAITING_HIDE;
        HUD_TOAST_SHOW(MSG_ERROR_NETWORK);
    }];
}

@end
