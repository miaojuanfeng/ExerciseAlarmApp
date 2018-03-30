//
//  NewQuestionController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "NewQuestionController.h"
#import <AFNetworking/AFNetworking.h>

@interface NewQuestionController () <UITextViewDelegate, UIGestureRecognizerDelegate>
@property UITextField *titleField;
@property UITextView *contentView;
@property AppDelegate *appDelegate;
@end

@implementation NewQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = RGBA_COLOR(240, 240, 245, 1);
    self.navigationItem.title = @"我要提問";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
//    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
//    self.navigationItem.rightBarButtonItem = self.myButton;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20, marginTop+20, self.view.frame.size.width-40, self.view.frame.size.height)];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 44)];
    [self setTextFieldLeftPadding:self.titleField forWidth:5];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.placeholder = @"輸入標題";
    [contentView addSubview:self.titleField];
    //
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleField.frame.origin.y+self.titleField.frame.size.height, contentView.frame.size.width, 10)];
    line.backgroundColor = RGBA_COLOR(240, 240, 245, 1);
    [contentView addSubview:line];
    //
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, line.frame.origin.y+line.frame.size.height, contentView.frame.size.width, 200)];
    self.contentView.text = @"輸入內容";
    self.contentView.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    self.contentView.textColor = [UIColor lightGrayColor];
    self.contentView.delegate = self;
    [contentView addSubview:self.contentView];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(250/2, self.contentView.frame.origin.y+self.contentView.frame.size.height+20, contentView.frame.size.width-250, 44)];
    submitButton.backgroundColor = RGBA_COLOR(49, 132, 225, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:submitButton];
    
    [self.view addSubview:contentView];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"輸入內容";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"輸入內容"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

- (void)clickSubmitButton {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"user_username":self.titleField.text,@"user_password":self.contentView.text};
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:BASE_URL(@"discuss/insert") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
            
            [self.navigationController popViewControllerAnimated:true];
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

- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

@end
