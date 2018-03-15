//
//  NewCommentController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewCommentController.h"

@interface NewCommentController () <UITextViewDelegate>
@property UIBarButtonItem *myButton;
@property UITextView *content;
@end

@implementation NewCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加評論";
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(clickSave)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    //
    self.content = [[UITextView alloc] initWithFrame:CGRectMake(5, marginTop, self.view.frame.size.width-10, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
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
