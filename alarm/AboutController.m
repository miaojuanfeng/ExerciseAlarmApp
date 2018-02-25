//
//  AboutController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"關於我們";
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    textView.text = @"\n<鍛鍊提醒> 程式是由香港大學工業及製造系統工程系人因工程實驗室開發並提供技術支持。\n\n如有需要，請與柯教授取得聯繫。\n(電話：1234-5678)";
    textView.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    textView.editable = NO;
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
