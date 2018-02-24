//
//  HelpController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HelpController.h"

@interface HelpController ()

@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"查看幫助";
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    textView.text = @"\n歡迎使用 <鍛鍊提醒> 程式。\n\n您可以自由設置鍛煉提醒，並觀看教學視頻進行康復鍛煉。\n\n通過“我的狀態”，您可以隨時查看近期鍛煉情況。\n\n您也可以在討論區提出疑問，與專家及其他用戶進行交流。";
    textView.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
