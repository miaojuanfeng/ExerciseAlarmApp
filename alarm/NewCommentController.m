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

@interface NewCommentController () <UITextViewDelegate, UIGestureRecognizerDelegate>
@property UITextView *contentView;
@property AppDelegate *appDelegate;
@end

@implementation NewCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = RGBA_COLOR(240, 240, 245, 1);
    self.navigationItem.title = @"添加評論";
    self.navigationItem.leftBarButtonItem.title = @"";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
//    self.navigationItem.rightBarButtonItem = self.myButton;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(20, marginTop+20, self.view.frame.size.width-40, self.view.frame.size.height)];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 200)];
    self.contentView.text = @"輸入內容";
    self.contentView.font = [UIFont systemFontOfSize:17.0f];
    self.contentView.textColor = RGBA_COLOR(199, 199, 205, 1);
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
        textView.textColor = RGBA_COLOR(199, 199, 205, 1);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"輸入內容"]){
        textView.text=@"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)clickSubmitButton {
    [self.view endEditing:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{
                               @"comment_discuss_id":self.comment_discuss_id,
                               @"comment_comment_id":self.comment_comment_id,
                               @"comment_user_id":[self.appDelegate.user objectForKey:@"user_id"],
                               @"comment_content":self.contentView.text
                               };
    HUD_WAITING_SHOW(MSG_LOADING);
    [manager POST:BASE_URL(@"comment/insert") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            NSMutableDictionary *comment = [dic objectForKey:@"data"];
            if ([self.delegate respondsToSelector:@selector(updateComment:)]) { // 如果协议响应了sendValue:方法
                [self.delegate updateComment:comment]; // 通知执行协议方法
            }
            HUD_TOAST_POP_SHOW(@"發佈成功", nil);
        }else{
            NSString *msg = [dic objectForKey:@"msg"];
            HUD_TOAST_SHOW(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败.%@",error);
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        HUD_WAITING_HIDE;
        HUD_TOAST_SHOW(MSG_ERROR_NETWORK);
    }];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

@end
