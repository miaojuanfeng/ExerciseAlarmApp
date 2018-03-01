//
//  NewQuestionController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewQuestionController.h"

@interface NewQuestionController () <UITextViewDelegate>
@property UIBarButtonItem *myButton;
@property UITextView *content;
@end

@implementation NewQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我要提問";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    UITextField *title = [[UITextField alloc] initWithFrame:CGRectMake(10, marginTop, self.view.frame.size.width-20, 44)];
    title.placeholder = @"輸入標題";
    [self.view addSubview:title];
    //
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+46, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    //
    self.content = [[UITextView alloc] initWithFrame:CGRectMake(5, marginTop+title.frame.size.height+line.frame.size.height+2, self.view.frame.size.width-10, self.view.frame.size.height-marginTop-title.frame.size.height-line.frame.size.height-2-self.tabBarController.tabBar.frame.size.height)];
    self.content.text = @"輸入內容";
    self.content.font = [UIFont fontWithName:@"AppleGothic" size:18.0];
    self.content.textColor = [UIColor lightGrayColor];
    self.content.delegate = self;
    [self.view addSubview:self.content];
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

- (void)clickSave {
    [self.navigationController popViewControllerAnimated:true];
}

@end
