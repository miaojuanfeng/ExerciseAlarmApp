//
//  NewCommentController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "NewCommentController.h"
#import <AFNetworking/AFNetworking.h>

@interface NewCommentController () <UITextViewDelegate>
@property UITextView *contentView;
@property AppDelegate *appDelegate;
@end

@implementation NewCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = RGBA_COLOR(240, 240, 245, 1);
    self.navigationItem.title = @"添加評論";
    
//    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
//    self.navigationItem.rightBarButtonItem = self.myButton;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20, marginTop+20, self.view.frame.size.width-40, self.view.frame.size.height)];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 200)];
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
    NSDictionary *parameters=@{@"user_username":self.contentView.text,@"user_password":self.contentView.text};
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:BASE_URL(@"comment/insert") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            
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

@end
